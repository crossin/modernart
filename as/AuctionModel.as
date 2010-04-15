package {

	/**
	 * @author user
	 */
	public class AuctionModel {
		var id : int;
		//var owner : PlayerModel;
		var bidder_id : int;
		var card : CardModel;
		var auctioncenter : CenterModel;
		var price : int;
		var count_bid : int;
		var time_start : Date;
		var time_latest : Date;

		public function AuctionModel(a : Object) {
			id = a["id"];
			//owner = a["owner"];
			bidder_id = 0;
			price = a["price"];
			count_bid = a["count_bid"];
			time_start = a["time_start"];
			time_latest = a["time_latest"];
        	
			card = new CardModel(a["card"]);
		}
	}
}
