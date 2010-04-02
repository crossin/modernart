package {

    /**
     * @author user
     */
    public class MAConst {
        static const AUCTION_SUCCESS : int = 0x0001;
        static const AUCTION_FAILED_INAUCTION : int = 0x0002;
        static const AUCTION_ERROR : int = 0x0003;
        static const BID_ERROR : int = 0x0004;
        static const BID_FAILED_PRICETOOLOW : int = 0x0005;
        static const BID_FAILED_HASBIDDED : int = 0x0006;
        static const BID_SUCCESS : int = 0x0007;
        static const BID_FAILED_NOTENOUGHGOLD : int = 0x0108;
        static const ENTERAUCTIONCENTER_ERROR : int = 0x0008;
        static const ENTERAUCTIONCENTER_SUCCESS : int = 0x0009;
        static const ENTERAUCTIONCENTER_FAILED_INAUCTION : int = 0x000a;
        static const ENTERAUCTIONCENTER_FAILED_HASENTERED : int = 0x000b;
        static const ENTERAUCTIONCENTER_FAILED_FULL : int = 0x000c;
        static const GETPLAYER_SUCCESS : int = 0x000d;
        static const GETPLAYER_ERROR : int = 0x000e;
        static const GETAUCTIONCENTER_SUCCESS : int = 0x000f;
        static const GETAUCTIONCENTER_ERROR : int = 0x0010;
        static const GETAUCTION_SUCCESS : int = 0x0011;
        static const GETAUCTION_ERROR : int = 0x0012;
        static const GETAUCTIONLIST_SUCCESS : int = 0x0013;
        static const GETAUCTIONLIST_ERROR : int = 0x0014;
        static const GETBID_SUCCESS : int = 0x0015;
        static const GETBID_ERROR : int = 0x0016;
        static const ACKNEWCARD_SUCCESS : int = 0x0017;
        static const ACKNEWCARD_ERROR : int = 0x0018;
        static const GETCARDLIST_SUCCESS : int = 0x0019;
        static const GETCARDLIST_ERROR : int = 0x001a;
        static const GETAUCTIONCENTERLIST_SUCCESS : int = 0x001b;
        static const GETAUCTIONCENTERLIST_ERROR : int = 0x001c;
        static const GETTIME_SUCCESS : int = 0x001e;
        static const GETTIME_ERROR : int = 0x001f;
        static const GETPLAYERLOG_SUCCESS : int = 0x0020;
        static const GETPLAYERLOG_ERROR : int = 0x0021;

        static const LIST_CARDS : int = 0x0201;
        static const LIST_BOUGHT : int = 0x202;
        //        static const LIST_BLANK : int = 0x1001;
        //        static const LIST_CARDS : int = 0x1002;
        //        static const LIST_AUCTIONS : int = 0x1003;
        //        static const LIST_PLAYERS : int = 0x1004;
        //        static const LIST_CENTERS : int = 0x1005;

        static const URL_HOST : String = "http://127.0.0.1:8000/";//        static const URL_HOST : String = "http://202.120.40.90:9091/";
        static const URL_SERVICE : String = URL_HOST + "service/game/";
        static const URL_PIC : String = URL_HOST + "media/";
    }
}
