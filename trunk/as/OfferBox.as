package {
    import flash.display.Sprite;
    import flash.events.MouseEvent;    

    /**
     * @author user
     */
    public class OfferBox extends Sprite {
        public function OfferBox() {
            x = 15;
            y = 15;
            this["btnOK"].addEventListener(MouseEvent.CLICK, onClickOK);
        }
        
        private function onClickOK(event : MouseEvent) : void {
            visible = false;
            if(this["txtIn"].text > 0) {
            //MAView.controller.bid(ShowPanel(parent).card.content["id"], this["txtIn"].text);
            MAView.controller.auction(ShowPanel(parent).card.content["id"], this["txtIn"].text);
        }
        }
    }
}
