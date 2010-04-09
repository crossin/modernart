package {

	/**
	 * @author user
	 */
	public class CenterModel {
		var id : int;
		var count_player : int;
		var max_player : int;
		var name : String;

		public function CenterModel(ac : Object) {
			id = ac["id"];
			count_player = ac["count_player"];
			max_player = ac["max_player"];
			name = ac["name"];
		}
	}
}
