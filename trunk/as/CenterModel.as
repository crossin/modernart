package {

    /**
     * @author user
     */
    public class CenterModel {
        var id : int;
        var count_card : int;
        var max_card : int;

        public function CenterModel(ac : Object) {
            id = ac["id"];
            count_card = ac["count_card"];
            max_card = ac["max_card"];
        }
    }
}
