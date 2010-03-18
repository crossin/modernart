package {

    /**
     * @author user
     */
    public class AuctionModel {
        var id : int;
        var owner : PlayerModel;
        var bidder : PlayerModel;
        var card : CardModel;
        var auctioncenter : CenterModel;
        var price : int;
        var count_bid : int;
        var time_start : Date;
        var time_latest : Date;
        
        public function AuctionModel(a : Object) {
        	id = a["id"];
        	owner = a["own_id"]
        	price = a["price"];
        	count_bid = a["count_bid"];
        	time_start = a["time_start"];
        	time_latest = a["time_latest"];
        	
        	card = new CardModel(a["card"]);
        	
        }
    }
}
