#-*- coding:utf-8 -*-
# Create your views here.
import pyamf
from models     import *;
from statuscode import *;
from gamelogic  import *;

from pyamf.remoting.gateway.django import DjangoGateway
from datetime import *;

from django.db import transaction

pyamf.register_package(models, 'models')

def createplayer(request):
    new_user = Player();
    new_user.save();
    return {
            'statuscode':CREATEPLAYER_SUCCESS,
            'id':new_user.id,
            }

@transaction.commit_on_success
def auction( request, player_id, card_id, price = 0 ):
    try:
        player = Player.objects.get( id = player_id );
        card    = Card.objects.get(     id = card_id    );
        
        player_cards = Player_Card.objects.filter( player = player, card = card );#TODO: direct access via id
        if ( len( player_cards ) == 0 ):
            raise RuntimeError("Player haven't got this kind of card")
        player_card = player_cards[0];
        
        if( card.auction_type != FIXED_BID ): price = 0;
        
        if player.in_auction :
            return {'statuscode':AUCTION_FAILED_INAUCTION};
        elif player_card.is_bought :
            return {'statuscode':AUCTION_ERROR};
        else:
            new_auction = Auction( owner = player , 
                                   auctioncenter = player.auctioncenter,
                                   card = card,
                                   price = price,
                                   time_start = datetime.utcnow(),
                                   time_latest = datetime.utcnow()
                                   );
            player.in_auction = True;
            new_auction.save();
            player.save();
            player_card.delete();
            
            #log
            msg = u"发起拍卖"+FONT_str%card.name;
            LogPlayerMsg(player, msg);
            return {'statuscode':AUCTION_SUCCESS};
    except Exception,e:
        print e;
        print 'auction -- player_id:%s, card_id:%s'%(player_id,card_id);
        return {'statuscode':AUCTION_ERROR};

def getCardList( request, player_id ):
    try:
        player  = Player.objects.get(   id = player_id );   
        pclist = Player_Card.objects.filter( player = player );
        
        for pc in pclist:
            pc.card = pc.card;


        #cardlist = [];
        #for player_card in pclist:
            #cardlist.append( player_card.card );
        
        return {'statuscode':GETCARDLIST_SUCCESS,
                    'card_list':pclist};
    except Exception,e:
        print e;
        print 'getCardlist -- player_id:%s'%(player_id);
        return {'statuscode':GETCARDLIST_ERROR};

@transaction.commit_on_success
def bid( request, player_id, auction_id, price ):
    try:
        player  = Player.objects.get(       id = player_id );
        auction = Auction.objects.get(      id = auction_id    );
        
        if ( player.gold - player.gold_frozen < price ) :
            return {'statuscode':BID_FAILED_NOTENOUGHGOLD};
        
        bid_handle = BidFactory.constructBid( auction.card.auction_type );
        return {'statuscode': bid_handle.bidding( player,auction,price )};   
    except Exception,e:
        print e;
        print 'bid -- player_id:%s, auction_id:%s, price:%d'%(player_id,auction_id,price);
        return {'statuscode':BID_ERROR};
    
@transaction.commit_on_success
def enterAuctionCenter( request, player_id, auctioncenter_id ):
    try:
        auctioncenter = AuctionCenter.objects.get( id = auctioncenter_id );
        player = Player.objects.get( id = player_id );
        #if ( player.auctioncenter != None ):
        #    return {'statuscode':ENTERAUCTIONCENTER_ERROR};
        if ( auctioncenter.count_player + 1 > auctioncenter.max_player ):
            return {'statuscode':ENTERAUCTIONCENTER_FAILED_FULL};
        
        
        
        #player = Player.objects.get( id = player_id );
        if( player.auctioncenter != None ):
            #raise RuntimeError("Null auctioncenter when exit AC") 
            
            if( player.in_auction ):
                return {'statuscode':ENTERAUCTIONCENTER_FAILED_INAUCTION};
            bid_history_len = Bid.objects.filter( player = player ).count();
            if( bid_history_len != 0 ) :
                return {'statuscode':ENTERAUCTIONCENTER_FAILED_INAUCTION};
            ac = player.auctioncenter;
            if( ac.id == auctioncenter_id ) :
                return {'statuscode':ENTERAUCTIONCENTER_FAILED_HASENTERED};
            ac.count_player -= 1;
            ClearPlayerCardRecord( player );
            player.count_card = 0;
            player.save();
            ac.save();
        
        auctioncenter.count_player = auctioncenter.count_player+1;
        player.auctioncenter = auctioncenter;
        SupplyPlayerWithCards( player, INITIAL_CARD_COUNT );
        auctioncenter.save();
        player.save();
        
        #log
        msg = u"进入拍卖行"+FONT_int%auctioncenter_id;
        LogPlayerMsg(player, msg);
        return {'statuscode':ENTERAUCTIONCENTER_SUCCESS};
        
    except Exception,e:
        print e;
        print 'enterAuctionCenter -- player_id:%s, auctioncenter_id:%s'%(player_id,auctioncenter_id);
        return {'statuscode':ENTERAUCTIONCENTER_ERROR};

'''
@transaction.commit_on_success  
def exitAuctionCenter( request, player_id ):
    try:
        #auctioncenter = AuctionCenter.objects.get( id = auctioncenter_id );

        #log
        msg = u"离开拍卖行"+FONT_int%auctioncenter.id;
        LogPlayerMsg(player, msg);
        return {'statuscode':EXITAUCTIONCENTER_SUCCESS};
                                    
    except Exception,e:
        print e;
        print 'exitAuctionCenter -- player_id:%s'%(player_id);
        return {'statuscode':EXITAUCTIONCENTER_ERROR};
'''    
    
def getPlayer( request, player_id):
    try:
        player = Player.objects.get( xn_id = player_id );
        player.auctioncenter = player.auctioncenter;#TODO: optimize
        return {
                'player':player,
                'statuscode':GETPLAYER_SUCCESS,
            }
    except Exception,e:
        print e;
        print 'getPlayer -- player_id:%s'%(player_id);
        return {'statuscode':GETPLAYER_ERROR};
    

def getAuctionCenter( request, ac_id ): 
    try:
        ac = AuctionCenter.objects.get( id = ac_id );
        rpl = RepurchasePrice.objects.filter( auctioncenter = ac );
        if( len(rpl) == 0 ):
            raise RuntimeError("No RepurchasePrice info related with this AuctionCenter"); 
        
        return {
                'auctioncenter':ac,
                'pricelist':rpl,
                'statuscode':GETAUCTIONCENTER_SUCCESS,
            }
    except Exception,e:
        print e;
        print 'getAuctionCenter -- ac_id:%s'%(ac_id);
        return {'statuscode':GETAUCTIONCENTER_ERROR};
    
            
def getAuction( request, auction_id ): 
    try:
        a = Auction.objects.get( id = auction_id );
        a.owner = a.owner;
        a.bidder = a.bidder;
        return {
                'auction':a,
                'statuscode':GETAUCTION_SUCCESS,
            } 
    except Exception,e:
        print e;
        print 'getAuction -- auction_id:%s'%(auction_id);
        return {'statuscode':GETAUCTION_ERROR};  
    
def getAuctionList( request, ac_id ): 
    try:
        ac = AuctionCenter.objects.get( id = ac_id );
        al = Auction.objects.filter( auctioncenter = ac );
        for a in al:
            a.card = a.card;
        return {
                'auctionlist':al,
                'statuscode':GETAUCTIONLIST_SUCCESS,
            } 
    except Exception,e: 
        print e;
        print 'getAuctionList -- ac_id:%s'%(ac_id);
        return {'statuscode':GETAUCTIONLIST_ERROR};  
    
def getBid( request, player_id ):    
    try:
        player = Player.objects.get( id = player_id );
        bid_list = Bid.objects.filter( player = player );
        #if( len(bid_list ) == 0 ):
            #raise RuntimeError("BIDLIST NULL")
        auctionlist = [ bid.auction for bid in bid_list ];
        for auction in auctionlist:
            auction.card = auction.card;
        return {
                'auctionlist':auctionlist,
                'statuscode':GETBID_SUCCESS,
            } 
    except Exception,e: 
        print e;
        print 'getBid -- player_id:%s'%(player_id);
        return {'statuscode':GETBID_ERROR};
     
@transaction.commit_on_success
def ackNewCard( request, player_id ):
    try:
        player = Player.objects.get( id = player_id );
        player_card_list = Player_Card.objects.filter( player = player );
        for playercard in player_card_list:
            playercard.is_new = False;
            playercard.save();
        return {'statuscode':ACKNEWCARD_SUCCESS};
        
    except Exception,e: 
        print e;
        print 'ackNewCard -- player_id:%s'%(player_id);
        return {'statuscode':ACKNEWCARD_ERROR};
    
    
def getSystemTime( request ): 
    try:
        ac = AuctionCenter.objects.get(id=1);
        return {'statuscode':GETTIME_SUCCESS,
                'time':datetime.utcnow(),
                'phase':ac.phase,
                };
    except Exception,e:
        return {'statuscode':GETTIME_ERROR}; 
    
def getAuctionCenterList( request ): 
    try:
        ac_list = AuctionCenter.objects.all();
        if( len(ac_list ) == 0 ):
            raise RuntimeError("AuctionCenterList NULL")
        return {'statuscode':GETAUCTIONCENTERLIST_SUCCESS,
                'auctioncenterlist':ac_list};
        
    except Exception,e:
        print e;
        print 'getAuctionCenterList --';
        return {'statuscode':GETAUCTIONCENTERLIST_ERROR}; 

def getPlayerLog( request, player_id ):
    try:
        player  = Player.objects.get(   id = player_id );   
        loglist = PlayerLog.objects.filter( player = player );
        
        #cardlist = [];
        #for player_card in pclist:
            #cardlist.append( player_card.card );
        
        return {'statuscode':GETPLAYERLOG_SUCCESS,
                    'loglist':loglist};
    except Exception,e:
        print e;
        print 'getPlayerLog -- player_id:%s'%(player_id);
        return {'statuscode':GETPLAYERLOG_ERROR};
        
gameGateway = DjangoGateway({
    'game.getPlayer': getPlayer,
    'game.getCardList':getCardList,
    'game.auction': auction,
    'game.bid': bid,
    'game.enterAuctionCenter':enterAuctionCenter,
    #'game.exitAuctionCenter':exitAuctionCenter,
    'game.getAuctionCenter':getAuctionCenter,
    'game.getAuction':getAuction,
    'game.getAuctionList':getAuctionList,
    'game.getBid':getBid,
    'game.ackNewCard':ackNewCard,
    'game.getAuctionCenterList':getAuctionCenterList,
    'game.getSystemTime':getSystemTime,
    'game.getPlayerLog':getPlayerLog,
    'game.createplayer':createplayer,
})
 
 