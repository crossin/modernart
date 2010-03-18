package {
    import flash.display.Sprite;
    import flash.events.MouseEvent;    

    /**
     * @author user
     */
    public class MessageBox extends Sprite {
        var msg : String;

        public function MessageBox() {
        	x = 50;
        	y = 50;
        	
        	addEventListener(MouseEvent.CLICK, clickHandler);
        }
        
        private function clickHandler(event : MouseEvent) : void {
        	this["txtMessage"].text = "";
        	visible = false;
        }
    }
}
