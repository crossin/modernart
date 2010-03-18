package {

    /**
     * @author user
     */
    public class MAModel {
        //        static var card_data : Dictionary;

        var player : PlayerModel;
        var center : CenterModel;
        var cards : Array;
        var cards_new : Array;
        var cards_bought : Array;
        var auctions : Array;
        var prices : Array;
        var centers : Array;
        var logs : Array;

        var list_content : int;

        public function MAModel() {
            player = new PlayerModel();
            //center = new CenterModel();
            //list_content = MAConst.LIST_BLANK;
        }

        public function updatePlayer(p : Object) : void {
            for (var t in p) {
                if(t != "auctioncenter") {
                    player[t] = p[t];
                }
                else if (p[t]) {
                    center = new CenterModel(p[t]);
                }
            }
        }

        public function updateCards(c : Object) : void {
            cards = new Array();
            cards_new = new Array();
            cards_bought = new Array();
            for (var t in c) {
                if (c[t].is_bought) {
                    cards_bought.push(new CardModel(c[t].card));
                } else {
                    cards.push(new CardModel(c[t].card));
                }
            }
        }

        public function updateAuctions(a : Object) : void {
            auctions = new Array();
            for (var t in a) {
                auctions.push(new AuctionModel(a[t]));
            }
        }

        public function updatePrices(p : Object) : void {
            prices = new Array();
            for (var t in p) {
                prices.push(new PriceModel(p[t]));
            }
            prices.sortOn(["count","card_class"], [Array.DESCENDING | Array.NUMERIC, Array.NUMERIC]);
            
            //add repurchase hint
            prices[0].repurchasable = true;
            prices[0].price_now = prices[0].price_all + 30;
            prices[1].repurchasable = true;
            prices[1].price_now = prices[1].price_all + 20;
            prices[2].repurchasable = true;
            prices[2].price_now = prices[2].price_all + 10;
            prices[prices.length - 1].repurchasable = true;
            prices[prices.length - 1].price_now = prices[prices.length - 1].price_all + 50;
        }

        public function updateCenters(c : Object) : void {
            centers = new Array();
            for (var t in c) {
                centers.push(new CenterModel(c[t]));
            }
        }

        public function updateLogs(l : Object) : void {
            logs = new Array();
            for (var t in l) {
                logs.push(new LogModel(l[t]));
            }
        }
//        public static function initCards() : void {
//            card_data = new Dictionary();
//            card_data["1"] = new CardModel(1, 0, 1);
//            card_data["2"] = new CardModel(2, 1, 1);
//            card_data["3"] = new CardModel(3, 2, 1);
//            card_data["4"] = new CardModel(4, 3, 1);
//            card_data["5"] = new CardModel(5, 0, 2);
//            card_data["6"] = new CardModel(6, 1, 2);
//            card_data["7"] = new CardModel(7, 2, 2);
//            card_data["8"] = new CardModel(8, 3, 2);
//        }
    }
}