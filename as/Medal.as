package {
    import flash.display.Sprite;    

    /**
     * @author user
     */
    public class Medal extends Sprite {
        public function Medal(price : int) {
            this["txtPrice"].text = price;
        }
    }
}
