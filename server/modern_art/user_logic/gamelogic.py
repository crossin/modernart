#-*- coding:utf-8 -*-
from statuscode import *;
from models import *;
#from datetime import *;
import datetime;

from django.db import transaction;

import logging;
import random;


PUBLIC_BID      = 0x000001;
PRIVATE_BID     = 0x000002;
FIXED_BID       = 0x000003;

AUCTION_LAST    = datetime.timedelta( minutes = 3 );

RANK_PRICE_TABLE = [30,15,5];

INITIAL_CARD_COUNT = 14;

now = datetime.datetime.utcnow();
BASE_CHECK_TIME = datetime.datetime( year=now.year, month = now.month, day=now.day,
                            hour=7, minute=30,second = 0 );
CHECK_DELTA = datetime.timedelta( hours = 3 );
CHECK_POINT_PHASE = [BASE_CHECK_TIME+CHECK_DELTA*i for i in range(5) ];
#CHECK_POINT_PHASE_1 = BASE_CHECK_TIME ;
#CHECK_POINT_PHASE_2 = BASE_CHECK_TIME + CHECK_DELTA;
#CHECK_POINT_PHASE_3 = BASE_CHECK_TIME + CHECK_DELTA*2;
#CHECK_POINT_PHASE_4 = BASE_CHECK_TIME + CHECK_DELTA*3;
#CHECK_POINT_PHASE_5 = BASE_CHECK_TIME + CHECK_DELTA*4;

#TEST SECTION
T_CHECK_DELTA = datetime.timedelta( seconds = 15 );
T_CHECK_POINT_PHASE = [now+T_CHECK_DELTA*i for i in range(5) ];
#T_CHECK_POINT_PHASE_1 = now;
#T_CHECK_POINT_PHASE_2 = now+T_CHECK_DELTA;
#T_CHECK_POINT_PHASE_3 = now+T_CHECK_DELTA*2;
#T_CHECK_POINT_PHASE_4 = now+T_CHECK_DELTA*3;
#T_CHECK_POINT_PHASE_5 = now+T_CHECK_DELTA*4;

CURRENT_CHECK_PHASE = 0;
CURRENT_PHASE = 0;

FONT_int = "<b><font color='#962A05'>%d</font></b>"
FONT_str = "<b><font color='#962A05'>%s</font></b>"

class BidBase():
    def __init__(self):
        pass;
    def bidding(self):
        pass;
    def deal(self):
        pass;

class PublicBid(BidBase):
    def __init__(self):
        pass;
    @transaction.commit_on_success
    def bidding(self, bidder, auction, price ):
        if ( price < auction.price ):
            return BID_FAILED_PRICETOOLOW;
        if ( auction.bidder == bidder ):
            return BID_FAILED_HASBIDDED;
        elif ( auction.bidder != None ) :#bid successfully, return previous bidder BUG_FIX 01
            previous_bidder = auction.bidder;
            previous_bidder.gold_frozen = previous_bidder.gold_frozen - auction.price;
            previous_bidder.save();
        auction.bidder = bidder;
        auction.price  = price;
        bid_record = Bid( auction = auction, player = bidder, price = price);
        bidder.gold_frozen = bidder.gold_frozen + price;
        auction.time_latest = datetime.datetime.utcnow();      
        auction.count_bid = auction.count_bid + 1;
        bidder.save();
        bid_record.save();
        auction.save();        
        
        #log
        msg = u"以"+FONT_int%price+u"金竞拍"+FONT_str%auction.card.name;
        LogPlayerMsg(bidder, msg);
            
        return BID_SUCCESS;
    
    @transaction.commit_on_success
    def deal( self, auction ):
        owner  = auction.owner;
        card   = auction.card;
        if ( auction.bidder == None ):
            player_card = Player_Card( player = owner , card = card );
            player_card.save();
            owner.in_auction = False;
            owner.save();
            #log
            msg = FONT_str%auction.card.name+u"流标";
            LogPlayerMsg(owner, msg);
            print "Public Auction Deal finished with no bidder -- onwer_id %d,  auction %d"%(owner.id,  auction.id);
        else:
            if (owner.id != auction.bidder.id):
                owner.gold = owner.gold + auction.price;
                #log
                msg = u"以"+FONT_int%auction.price+u"金售出"+FONT_str%auction.card.name;
                LogPlayerMsg(owner, msg);
            #TODO: EXPERIENCE
            owner.in_auction = False;
            owner.save();

            
            #TO prevent dirty data, when owner and bidder is same person
            bidder = Player.objects.get( id = auction.bidder.id );
            player_card = Player_Card( player = bidder , card = card , is_bought = True);
            player_card.save();
            bidder.gold = bidder.gold - auction.price;
            bidder.gold_frozen = bidder.gold_frozen - auction.price;
            bidder.save();
            #log
            msg = u"以"+FONT_int%auction.price+u"金购得"+FONT_str%auction.card.name;
            LogPlayerMsg(bidder, msg);
            
            ac = auction.auctioncenter;
            try:
                rpt = RepurchasePrice.objects.get( auctioncenter=ac, card_class = card.card_class );
                rpt.count = rpt.count + 1;
                rpt.save();
            except Exception,e:
                print e;
                print "Public Auction No Corresponding repurchase price with ac_id %d, card_class %d"%(ac.id, card.card_class);
                #logging.ERROR("No Corresponding repurchase price with ac_id %d, card_class %d"%(ac.id, card.card_class) );
            
            bid_list = Bid.objects.filter( auction = auction );
            for bid in bid_list:
                #bid_attendee = bid.player;
                #bid_attendee.gold_frozen = bid_attendee.gold_frozen - bid.price;
                #bid_attendee.save();
                bid.delete();
            print "Public Auction Deal successfully finished with auction onwer_id %d, bidder %d, auction %d"%(owner.id, bidder.id, auction.id);
            #logging.INFO("Deal successfully finished with player_id %d, bidder %d, auction %d"%(owner.id, bidder.id, auction.id) );
        auction.delete();
            
            
class FixedBid(BidBase):
    def __init__(self):
        pass;
    @transaction.commit_on_success
    def bidding(self, bidder, auction, price ):
        if ( bidder.gold < auction.price ):
            return BID_FAILED_NOTENOUGHGOLD;
        if ( auction.bidder == None ):
            #auction.bidder = bidder;
            bidder.gold = bidder.gold - auction.price;
            bidder.save();
            player_card = Player_Card( player = bidder , card = auction.card , is_bought = True);
            player_card.save();
            owner = Player.objects.get( id = auction.owner.id );
            if (owner.id != bidder.id):
                owner.gold = owner.gold + auction.price;
                #log
                msg = u"以"+FONT_int%auction.price+u"金售出"+FONT_str%auction.card.name;
                LogPlayerMsg(owner, msg);
            owner.in_auction = False;
            owner.save();
            #log
            msg = u"以"+FONT_int%auction.price+u"金购得"+FONT_str%auction.card.name;
            LogPlayerMsg(bidder, msg);
            
            ac = auction.auctioncenter;
            try:
                rpt = RepurchasePrice.objects.get( auctioncenter=ac, card_class = auction.card.card_class );
                rpt.count = rpt.count + 1;
                rpt.save();
            except Exception,e:
                print e;
                print "Public Auction No Corresponding repurchase price with ac_id %d, card_class %d"%(ac.id, card.card_class);
                
            auction.delete();    

        
            return BID_SUCCESS;
        else:
            print 'FIXED BID ALREADY BIDDED ERROR';
            return BID_ERROR;
        
    
    @transaction.commit_on_success
    def deal( self, auction ):
        owner  = auction.owner;
        card   = auction.card;
        if ( auction.bidder == None ):
            player_card = Player_Card( player = owner , card = card );
            player_card.save();
            owner.in_auction = False;
            owner.save();
            #log
            msg = FONT_str%auction.card.name+u"流标";
            LogPlayerMsg(owner, msg);
            print "Public Auction Deal finished with no bidder -- onwer_id %d,  auction %d"%(owner.id,  auction.id);
            auction.delete();
        else:
            print 'FIXED BID ALREADY BIDDED ERROR';
            auction.delete();
            return BID_ERROR;
    
class PrivateBid(BidBase):
    def __init__(self):
        pass;
    @transaction.commit_on_success
    def bidding(self, bidder, auction, price ):
        bid_history_len = Bid.objects.filter( auction = auction, 
                player = bidder ).count();
        if( bid_history_len != 0 ):
            return BID_FAILED_HASBIDDED;
        auction.bidder = bidder;
        auction.price  = price;
        bid_record = Bid( auction = auction, player = bidder, price = price);
        bidder.gold_frozen = bidder.gold_frozen + price;
        auction.time_latest = datetime.datetime.utcnow();
        auction.count_bid = auction.count_bid + 1;
        bidder.save();
        bid_record.save();
        auction.save();    
        
        #log
        msg = u"以"+FONT_int%price+u"金竞拍"+FONT_str%auction.card.name;
        LogPlayerMsg(bidder, msg);
        
        return BID_SUCCESS;
    
    @transaction.commit_on_success
    def deal( self, auction ):
        owner  = auction.owner;
        card   = auction.card;
        if ( auction.bidder == None ):
            player_card = Player_Card( player = owner , card = card );
            player_card.save();
            owner.in_auction = False;
            owner.save();
            #log
            msg = FONT_str%auction.card.name+u"流标";
            LogPlayerMsg(owner, msg);
            print "Private Auction Deal finished with no bidder -- onwer_id %d,  auction %d"%(owner.id,  auction.id);
        else:
            if (owner.id != auction.bidder.id):
                owner.gold = owner.gold + auction.price;
                #log
                msg = u"以"+FONT_int%auction.price+u"金售出"+FONT_str%auction.card.name;
                LogPlayerMsg(owner, msg);
            #TODO: EXPERIENCE
            owner.in_auction = False;
            owner.save();
            
            #TO prevent dirty data, when owner and bidder is same person
            bidder = Player.objects.get( id = auction.bidder.id );
            player_card = Player_Card( player = bidder , card = card , is_bought = True);
            player_card.save();
            bidder.gold = bidder.gold - auction.price;
            #bidder.gold_frozen = bidder.gold_frozen - auction.price;
            bidder.save();
            #log
            msg = u"以"+FONT_int%auction.price+u"金购得"+FONT_str%auction.card.name;
            LogPlayerMsg(bidder, msg);
            
            ac = auction.auctioncenter;
            try:
                rpt = RepurchasePrice.objects.get( auctioncenter=ac, card_class = card.card_class );
                rpt.count = rpt.count + 1;
                rpt.save();
            except Exception,e:
                print e;
                print "Private Auction No Corresponding repurchase price with ac_id %d, card_class %d"%(ac.id, card.card_class);
                #logging.ERROR("No Corresponding repurchase price with ac_id %d, card_class %d"%(ac.id, card.card_class) );
            
            bid_list = Bid.objects.filter( auction = auction );
            for bid in bid_list:
                bid_attendee = bid.player;
                bid_attendee.gold_frozen = bid_attendee.gold_frozen - bid.price;
                bid_attendee.save();
                bid.delete();
            print "Private Auction Deal successfully finished with auction onwer_id %d, bidder %d, auction %d"%(owner.id, bidder.id, auction.id);
            #logging.INFO("Deal successfully finished with player_id %d, bidder %d, auction %d"%(owner.id, bidder.id, auction.id) );
        auction.delete();
        
class BidFactory():
    @staticmethod
    def constructBid( auction_type ):
        if( auction_type == PUBLIC_BID ):
            return PublicBid();
        elif( auction_type == PRIVATE_BID ):
            return PrivateBid();
        elif( auction_type == FIXED_BID ):
            return FixedBid();
        
@transaction.commit_on_success   
def SupplyPlayerWithCards( player, count ):
    """
    """
    cards = Card.objects.all();
    available_count = min( player.max_card - player.count_card , count );
    shuffled_cards = random.sample( cards, available_count );
    #print available_count;
    if( shuffled_cards <= 0 ):
        return;
    player.count_card = player.count_card + available_count;
    player.save();
    for card in shuffled_cards:
        p_c = Player_Card( player = player, card = card, is_new = True );
        p_c.save();
@transaction.commit_on_success
def ClearPlayerCardRecord( player ):
    p_cards = Player_Card.objects.filter( player = player );
    for p_c in p_cards:
        p_c.delete();
        
        
def LogPlayerMsg(player, msg):
    try:
        new_log = PlayerLog( player = player , 
                             time = datetime.datetime.utcnow(),
                             message = msg,
                            );
        new_log.save();
        #return {'statuscode':AUCTION_SUCCESS};
    except Exception,e:
        print e;
        print 'log -- player_id:%s'%(player);
        #return {'statuscode':AUCTION_ERROR};

        
@transaction.commit_on_success
def DealDeamonTask( force = False ):
    if( force ):
        auctions = Auction.objects.all();
    else :
        auctions = Auction.objects.filter( time_start__lt =  datetime.datetime.utcnow()-AUCTION_LAST );
    for auction in auctions:
        auction_handle = BidFactory.constructBid( auction.card.auction_type );
        auction_handle.deal( auction );
    #return { 'auctions': auctions}

Price_table={'1':30,'2':20,'3':10,'-1':50};
@transaction.commit_on_success
def RepurchaseDeamonTask( ):
    #cphase = LocateCurrentCheckPhase();
    #cphase = 1;
    global CURRENT_PHASE;
    cphase = CURRENT_PHASE;
    print 'current phase:%d'%cphase;
    if ( cphase <= 0 or cphase > 4  ): return;
    
    acs = AuctionCenter.objects.all();
    for ac in acs:
        rps_count = RepurchasePrice.objects.filter(auctioncenter=ac).order_by('-count','card_class');
        last_index = len(rps_count) - 1;
        
        print 'Ranking Status: %d %d %d %d'%(rps_count[0].card_class,rps_count[1].card_class,rps_count[2].card_class,rps_count[last_index].card_class)
        
        if( len(rps_count) < 4 ):
            print 'less than 4 card type accessed, Exceptions encountered';
            return;
        #TODO:joint query
        player_selled_cards = Player_Card.objects.filter( is_bought = True ,player__auctioncenter = ac );
        
        print "%d player selled cards in the game"%( len(player_selled_cards) );
         
        
        if cphase == 1:
            rps_count[0].price_1    = Price_table['1'];
            rps_count[1].price_1    = Price_table['2'];
            rps_count[2].price_1    = Price_table['3'];
            rps_count[last_index].price_1   = Price_table['-1'];
            rps_table = [rps_count[0], rps_count[1],rps_count[2],rps_count[last_index]]
            for rps in rps_table:
                rps.save();
            for psc in player_selled_cards:
                for rps in rps_table:
                    if( psc.card.card_class == rps.card_class ):
                        psc.player.gold = psc.player.gold + rps.price_1;
                        print "player %d get %d gold"%(psc.player.id, rps.price_1);
                        psc.player.save();
                        #log
                        msg = FONT_str%psc.card.name+u"以"+FONT_int%rps.price_1+u"金被回购";
                        LogPlayerMsg(psc.player, msg);
                psc.delete();
                
        elif cphase == 2:
            rps_count[0].price_2    = rps_count[0].price_1 + Price_table['1'];
            rps_count[1].price_2    = rps_count[1].price_1 + Price_table['2'];
            rps_count[2].price_2    = rps_count[2].price_1 + Price_table['3'];
            rps_count[last_index].price_2   = rps_count[last_index].price_1 + Price_table['-1'];
            rps_table = [rps_count[0], rps_count[1],rps_count[2],rps_count[last_index]]
            for rps in rps_table:
                rps.save();
            for psc in player_selled_cards:
                for rps in rps_table:
                    if( psc.card.card_class == rps.card_class ):
                        psc.player.gold = psc.player.gold + rps.price_2;
                        psc.player.save();
                        #log
                        msg = FONT_str%psc.card.name+u"以"+FONT_int%rps.price_2+u"金被回购";
                        LogPlayerMsg(psc.player, msg);
                psc.delete();
                        
        elif cphase == 3:
            rps_count[0].price_3    = rps_count[0].price_2 + Price_table['1'];
            rps_count[1].price_3    = rps_count[1].price_2 + Price_table['2'];
            rps_count[2].price_3    = rps_count[2].price_2 + Price_table['3'];
            rps_count[last_index].price_3   = rps_count[last_index].price_2 + Price_table['-1'];
            rps_table = [rps_count[0], rps_count[1],rps_count[2],rps_count[last_index]]
            for rps in rps_table:
                rps.save();
            for psc in player_selled_cards:
                for rps in rps_table:
                    if( psc.card.card_class == rps.card_class ):
                        psc.player.gold = psc.player.gold + rps.price_3;
                        psc.player.save();
                        #log
                        msg = FONT_str%psc.card.name+u"以"+FONT_int%rps.price_3+u"金被回购";
                        LogPlayerMsg(psc.player, msg);
                psc.delete();
        elif cphase == 4:
            rps_count[0].price_4    = rps_count[0].price_3 + Price_table['1'];
            rps_count[1].price_4    = rps_count[1].price_3 + Price_table['2'];
            rps_count[2].price_4    = rps_count[2].price_3 + Price_table['3'];
            rps_count[last_index].price_4   = rps_count[last_index].price_3 + Price_table['-1'];
            rps_table = [rps_count[0], rps_count[1],rps_count[2],rps_count[last_index]]
            for rps in rps_table:
                rps.save();
            for psc in player_selled_cards:
                for rps in rps_table:
                    if( psc.card.card_class == rps.card_class ):
                        psc.player.gold = psc.player.gold + rps.price_3;
                        psc.player.save();
                        #log
                        msg = FONT_str%psc.card.name+u"以"+FONT_int%rps.price_4+u"金被回购";
                        LogPlayerMsg(psc.player, msg);
                psc.delete();
                
    rps = RepurchasePrice.objects.all();
    for rp in rps:
        rp.count = 0;
        if (cphase == 4):
            rp.price_1 = 0;
            rp.price_2 = 0;
            rp.price_3 = 0;
            rp.price_4 = 0;
        rp.save();
        
def LocateCurrentCheckPhase():
    now = datetime.datetime.utcnow();
    #CURRENT_CHECK_PHASE = -1;
    global CURRENT_CHECK_PHASE;
    for i in range(4):
        if ( now >= T_CHECK_POINT_PHASE[i] and now <= T_CHECK_POINT_PHASE[i+1] and CURRENT_CHECK_PHASE != i+1 ):
            CURRENT_CHECK_PHASE = i+1;
            return CURRENT_CHECK_PHASE;
    return 0;

Checkpoints=[15,30,45,0];
def DealButton( force = False ):
    #print "CheckTime Rested and begin deal"
    DealDeamonTask( force );
    global CURRENT_PHASE;
    #print "DealButton - CURRENT_PHASE:%d"%CURRENT_PHASE
    if (CURRENT_PHASE == 0):
        ac = AuctionCenter.objects.get(id=1);
        CURRENT_PHASE = ac.phase;
    currentHour = datetime.datetime.now().minute;
    #print "DealButton - currentHour:%d"%currentHour
    if (currentHour == Checkpoints[CURRENT_PHASE-1]):
        DealDeamonTask( True );
        RepurchaseButton();


def RepurchaseButton():
    global CURRENT_PHASE;
    #if( CURRENT_PHASE == 0 ):
    #    CURRENT_PHASE = CURRENT_PHASE + 1;
    #    return;
    #elif( CURRENT_PHASE > 4 ):
    #    CURRENT_PHASE = 0;
    #DealButton(True);
    RepurchaseDeamonTask();
    CURRENT_PHASE = CURRENT_PHASE % 4 + 1;
    ac = AuctionCenter.objects.get(id=1);
    ac.phase = CURRENT_PHASE;
    ac.save();
    print "All Ranked Deals Repurchased"
    
"""
    global T_CHECK_DELTA;
    global T_CHECK_POINT_PHASE;
    global Initialized
    if( Initialized ):
        DealButton(True);
        RepurchaseDeamonTask();
        print "All Ranked Deals Repurchased"
    else:
        T_CHECK_DELTA = datetime.timedelta( minutes=1,seconds = 15 );
        T_CHECK_POINT_PHASE = [datetime.datetime.utcnow()+T_CHECK_DELTA*i for i in range(5) ];
        Initialized = True;
"""    
    
    
    