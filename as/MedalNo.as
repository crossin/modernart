package {
    import flash.display.Sprite;    
    
    /**
     * @author user
     */
    public class MedalNo extends Sprite {
        public function MedalNo(price : int) {
            this["txtPrice"].text = price;
        }
    }
}