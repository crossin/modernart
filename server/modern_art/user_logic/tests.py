from django.test import Client, TestCase
import unittest
from game import *;
from management.commands.prepare_data import *;

class test_game_server_api(TestCase):
    def setUp(self):
        command = Command();
        command.handle();
        self.req = {};
        pass;
    """
    auction( request, player_id, card_id ):
    AUCTION_SUCCESS                         = 0x0001;
    AUCTION_FAILED_INAUCTION                = 0x0002;
    AUCTION_ERROR                           = 0x0003;
    """
    def testAuction_Success(self):
        pid = player_list[0].id; cid = card_list[0].id;
        player = Player.objects.get( id = pid );
        player.auctioncenter = auctioncenter_list[0];#let player enter auction center
        player.save();
        result =  auction(self.req,pid,cid);
        self.assertEqual( result['statuscode'], AUCTION_SUCCESS );
        player.auctioncenter = None;
        player.save();
    def testAuction_FailedInAuction(self):
        #an auction is created here 
        pid = player_list[0].id; cid = card_list[0].id;
        player = Player.objects.get( id = pid );
        player.in_auction = True;
        player.save();
        result =  auction(self.req,pid,cid);
        self.assertEqual( result['statuscode'], AUCTION_FAILED_INAUCTION );
        player.in_auction = False;
        player.save();
    def testAuction_FailedCardAlreadyBought(self):
        #an auction is created here 
        pid = player_list[0].id; cid = card_list[0].id;
        player = Player.objects.get( id = pid );
        player_card = Player_Card.objects.get( player = pid, card = cid );
        player_card.is_bought = True;
        player_card.save();
        result =  auction(self.req,pid,cid);
        self.assertEqual( result['statuscode'], AUCTION_ERROR );
        player_card.is_bought = False;
        player_card.save();
    
    """
    getCardList( request, player_id ):
    GETCARDLIST_SUCCESS
    GETCARDLIST_ERROR
    """     
    def testGetCardList_Success(self):
        pid = player_list[0].id;
        result = getCardList( self.req, pid );
        self.assertEqual( result['statuscode'], GETCARDLIST_SUCCESS );
    def testGetCardList_Error(self):
        pid = 1000;
        result = getCardList( self.req, pid );
        self.assertEqual( result['statuscode'], GETCARDLIST_ERROR );
        
    """
    bid( request, player_id, auction_id, price ):
    BID_ERROR                               = 0x0004;
    BID_FAILED_PRICETOOLOW                  = 0x0005;
    BID_FAILED_HASBIDDED                    = 0x0006;
    BID_SUCCESS                             = 0x0007;
    BID_FAILED_NOT_ENOUGHGOLD               = 0x0108;
    """
    def testBid_Error(self):
        result = bid( self.req, 1,2,100 );
        self.assertEqual( result['statuscode'], BID_ERROR );
    def testBid_FailedPriceTooLow(self):
        pid = player_list[0].id;
        auction = auction_list[0];
        auction.price = 100;
        auction.save();
        result = bid(self.req,pid,auction.id, 80 );
        self.assertEqual( result['statuscode'], BID_FAILED_PRICETOOLOW );
    def testBid_FailedHasBided(self):
        player  = player_list[0];
        auction = auction_list[0];
        auction.bidder = player;
        auction.save();
        bidobject = Bid( auction = auction, player = player, price = 100 );
        bidobject.save();
        result = bid(self.req,player.id,auction.id, 80 );
        self.assertEqual( result['statuscode'], BID_FAILED_HASBIDDED );
        bidobject.delete();
    def testBid_FailedNotEnoughGold(self):
        pid = player_list[0].id;
        auction = auction_list[0];
        auction.price = 10000;
        auction.save();
        result = bid(self.req,pid,auction.id, 20000 );
        self.assertEqual( result['statuscode'], BID_FAILED_NOTENOUGHGOLD );
    def testBid_Success(self):
        pid = player_list[3].id;
        auction = auction_list[0];
        auction.price = 100;
        auction.save();
        result = bid(self.req,pid,auction.id, 800 );
        self.assertEqual( result['statuscode'], BID_SUCCESS );
        
        
    """
    enterAuctionCenter( request, player_id, auctioncenter_id ):
    ENTERAUCTION_CENTER_ERROR              = 0x0008;
    ENTERAUCTION_CENTER_SUCCESS                   = 0x0009;
    """
    def testEnterAuctionCenter_Success(self):
        pid = player_list[0].id;
        ac_id = auctioncenter_list[0].id;
        result = enterAuctionCenter(self.req,pid,ac_id);
        self.assertEqual( result['statuscode'], ENTERAUCTIONCENTER_SUCCESS );      
    def testEnterAuctionCenter_Error(self):
        player = player_list[0];
        ac = auctioncenter_list[0];
        player.auctioncenter = ac;
        player.save();
        result = enterAuctionCenter(self.req,player.id,ac.id);
        self.assertEqual( result['statuscode'], ENTERAUCTIONCENTER_ERROR );
        player.auctioncenter = None;
        player.save();
    
    """
    exitAuctionCenter( request, player_id, auctioncenter_id ):
    EXITAUCTION_FAILED_INAUCTION           = 0x000a;
    EXITAUCTION_SUCCESS                    = 0x000b;
    EXITAUCTION_CENTER_ERROR               = 0x000c;
    """
    def testExitAuctionCenter_Success(self): #this test is coupled with upper
        player = player_list[0];
        ac = auctioncenter_list[0];
        player.auctioncenter = ac;
        player.save();
        result = exitAuctionCenter(self.req,player.id);
        self.assertEqual( result['statuscode'], EXITAUCTIONCENTER_SUCCESS );
        player.auctioncenter = None;
        player.save();
    def testExitAuctionFailed_InAuction(self):
        player = player_list[0];
        ac     = auctioncenter_list[0];
        player.in_auction = True;
        player.auctioncenter = ac;
        player.save();
        result = exitAuctionCenter(self.req,player.id);
        self.assertEqual( result['statuscode'],  EXITAUCTIONCENTER_FAILED_INAUCTION);
        player.in_auction = False;
        player.save();
    def testExitAuctionFailed_Error(self):
        pid = player_list[0].id;
        result = exitAuctionCenter(self.req,pid );
        self.assertEqual( result['statuscode'],  EXITAUCTIONCENTER_ERROR);
        
    """
    getPlayer( request, player_id):
    GETPLAYER_SUCCESS                      = 0x000d;
    GETPLAYER_ERROR                        = 0x000e;
    """
    def testGetPlayer_Success(self):
        pid = player_list[0].id;
        result =  getPlayer(self.req,pid);
        self.assertEqual( result['statuscode'], GETPLAYER_SUCCESS );
    def testGetPlayer_Error(self):
        pid = 100;
        result =  getPlayer(self.req,pid);
        self.assertEqual( result['statuscode'], GETPLAYER_ERROR );
        
    
    """
    getAuctionCenter( request, ac_id ):
    GETAUCTIONCENTER_SUCCESS               = 0x000f;
    GETAUCTIONCENTER_ERROR                 = 0x0010; 
    """
    def testGetAuctionCenter_Success(self):
        ac_id = auctioncenter_list[0].id;
        result =  getAuctionCenter(self.req,ac_id);
        self.assertEqual( result['statuscode'], GETAUCTIONCENTER_SUCCESS );
    def testGetAuctionCenter_Error(self):
        ac_id = 1000;
        result =  getAuctionCenter(self.req,ac_id);
        self.assertEqual( result['statuscode'], GETAUCTIONCENTER_ERROR );
    
    """
    def getAuction( request, auction_id ): 
    GETAUCTION_SUCCESS                 = 0x0013;
    GETAUCTION_ERROR                   = 0x0014;
    """
    def testGetAuction_Success(self):
        auction = auction_list[0];
        result =  getAuction(self.req,auction.id);
        self.assertEqual( result['statuscode'], GETAUCTION_SUCCESS );
    def testGetAuction_Error(self):
        aid = 1000;
        result =  getAuction(self.req,aid);
        self.assertEqual( result['statuscode'], GETAUCTION_ERROR );
    
        
    """
    getAuctionList( request, ac_id ): 
    GETAUCTIONLIST_SUCCESS                 = 0x0013;
    GETAUCTIONLIST_ERROR                   = 0x0014;
    """
    def testGetAuctionList_Success(self):
        #we have added a test auction in the preparing phase
        ac_id  = auctioncenter_list[0].id;
        result = getAuctionList(self.req,ac_id);
        self.assertEqual( result['statuscode'], GETAUCTIONLIST_SUCCESS );      
    def testGetAuctionList_Error(self):
        #we have added a test auction in the preparing phase
        ac_id  = 1000;
        result = getAuctionList(self.req,ac_id);
        self.assertEqual( result['statuscode'], GETAUCTIONLIST_ERROR );
    
    """
    getBid( request, player_id ): 
    GETBID_SUCCESS                         = 0x0015;
    GETBID_ERROR                           = 0x0016;
    """
    def testGetBid_Success(self):
        player  = player_list[0];
        auction = auction_list[0];
        bid = Bid( auction = auction, player = player, price = 100 );
        bid.save();
        result = getBid(self.req,player.id );
        self.assertEqual( result['statuscode'], GETBID_SUCCESS );
        bid.delete();
    def testGetBid_Error(self):
        player  = player_list[0];
        result = getBid(self.req,player.id );
        self.assertEqual( result['statuscode'], GETBID_ERROR );
    
    """
    ackNewCard( request, player_id ):
    ACKNEWCARD_SUCCESS                      = 0x0017;
    ACKNEWCARD_ERROR                        = 0x0018;
    """
    
    def testAckNewCard_Success(self):
        player  = player_list[0];
        for pc in player_card_list:
            pc.is_new =True;
        result = ackNewCard(self.req,player.id );
        self.assertEqual( result['statuscode'], ACKNEWCARD_SUCCESS );
        
    def testAckNewCard_Error(self):
        pid = 1000;
        result = ackNewCard(self.req,pid );
        self.assertEqual( result['statuscode'], ACKNEWCARD_ERROR );
        
    def testRepurchase(self):
        playerA = player_list[2];
        playerB = player_list[1];
        ac = auctioncenter_list[0];
        enterAuctionCenter( None, playerA.id, ac.id );
        enterAuctionCenter( None, playerB.id, ac.id );
        A_cards = Player_Card.objects.filter( player = playerA );
        auction( None, playerA.id, A_cards[0].card.id );
        print "All Auctions count %d" %len( Auction.objects.all() )
        print "player auction selled %d class card"%(A_cards[0].card.card_class)
        a = Auction.objects.get( owner = playerA, card=A_cards[0].card);
        bid( None, playerB.id , a.id, 50 );
        RepurchaseButton();
        self.assertEqual( playerA.gold, 1000 );
        self.assertEqual( playerB.gold, 1000-50+300 );
    


    
    def tearDown(self):
        command = Command();
        command.unhandle();
        pass;