package {

    /**
     * @author user
     */

    public class LogModel {
        var time : Date;
        var message : String;

        public function LogModel(log : Object) {
            time = log["time"];
            message = log["message"];
        }
    }
}
