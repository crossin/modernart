package {

    /**
     * @author user
     */
    public class PriceModel {
        public var card_class : int;
        public var count : int;
        public var price_all : int;
        public var price_now : int;
        var price_1 : int;
        var price_2 : int;
        var price_3 : int;
        var price_4 : int;
        var repurchasable : Boolean;

        
        public function PriceModel(p : Object) {
            card_class = p["card_class"];
            count = p["count"];
            price_1 = p["price_1"];
            price_2 = (p["price_2"] == 0) ? 0 : (p["price_2"] - p["price_1"]);
            price_3 = (p["price_3"] == 0) ? 0 : (p["price_3"] - p["price_2"]);
            price_4 = (p["price_4"] == 0) ? 0 : (p["price_4"] - p["price_3"]);
            repurchasable = false;
            price_all = price_1 + price_2 + price_3 + price_4;
            price_now = 0;
        }
    }
}
