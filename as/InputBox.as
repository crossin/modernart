package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;	

	/**
	 * @author user
	 */
	public class InputBox extends Sprite {
		public function InputBox() {
			x = 250;
			y = 100;
			//            this["btnOK"].addEventListener(MouseEvent.CLICK, onClickOK);
			this["txtIn"].restrict = "0-9";
			this["txtIn"].text = 0;
			this["btnCancel"].addEventListener(MouseEvent.CLICK, onClickCancel);
			
			this["btn0"].addEventListener(MouseEvent.CLICK, onClick0);			this["btn1"].addEventListener(MouseEvent.CLICK, onClick1);			this["btn5"].addEventListener(MouseEvent.CLICK, onClick5);			this["btn10"].addEventListener(MouseEvent.CLICK, onClick10);			this["btn50"].addEventListener(MouseEvent.CLICK, onClick50);			this["btn100"].addEventListener(MouseEvent.CLICK, onClick100);
		}

		private function onClick0(event : MouseEvent) : void {
			this["txtIn"].text = 0;
			this["txtIn"].dispatchEvent(new Event(Event.CHANGE));
		}		

		private function onClick1(event : MouseEvent) : void {
			this["txtIn"].text = int(this["txtIn"].text) + 1;
			this["txtIn"].dispatchEvent(new Event(Event.CHANGE));
		}

		private function onClick5(event : MouseEvent) : void {
			this["txtIn"].text = int(this["txtIn"].text) + 5;
			this["txtIn"].dispatchEvent(new Event(Event.CHANGE));
		}

		private function onClick10(event : MouseEvent) : void {
			this["txtIn"].text = int(this["txtIn"].text) + 10;
			this["txtIn"].dispatchEvent(new Event(Event.CHANGE));
		}

		private function onClick50(event : MouseEvent) : void {
			this["txtIn"].text = int(this["txtIn"].text) + 50;
			this["txtIn"].dispatchEvent(new Event(Event.CHANGE));
		}

		private function onClick100(event : MouseEvent) : void {
			this["txtIn"].text = int(this["txtIn"].text) + 100;
			this["txtIn"].dispatchEvent(new Event(Event.CHANGE));
		}

		
		private function onClickCancel(event : MouseEvent) : void {
			visible = false;
			this["txtIn"].text = 0;
			ShowPanel(parent).card.buttonMode = true;
			ShowPanel(parent).card.button.visible = false;
		}
//
//        private function onClickOK(event : MouseEvent) : void {
//        	visible = false;
//            if(this["txtIn"].text > 0) {
//                MAView.controller.bid(ShowPanel(parent).card.content["id"], this["txtIn"].text);
//            }
//        }
	}
}
