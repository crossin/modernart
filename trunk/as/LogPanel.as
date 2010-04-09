package {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;	

	/**
	 * @author Shin
	 */
	public class LogPanel extends MovieClip {
		public function LogPanel() {
			this["txtLog"].wordWrap = true;
			this["txtLog"].multiline = true;
			//this["btnOK"].addEventListener(MouseEvent.CLICK, onClickCloseLog);
			this.visible = false;
			this["maskLog"].mouseEnabled = false;
			this["btnOK"].addEventListener(MouseEvent.CLICK, onClickCloseLog);
			this["btnUp"].addEventListener(MouseEvent.CLICK, onClickUp);
			this["btnDown"].addEventListener(MouseEvent.CLICK, onClickDown);
			//this["btnOK"].alpha = 0.5;
		}

		private function onClickUp(event : MouseEvent) : void {
			this["txtLog"].scrollV--;
			if(!this["btnDown"].mouseEnabled) {
				this["btnDown"].mouseEnabled = true;
				this["btnDown"].alpha = 1;
			}
			if(this["txtLog"].scrollV == 1) {
				this["btnUp"].mouseEnabled = false;
				this["btnUp"].alpha = 0.5;
			}
		}

		private function onClickDown(event : MouseEvent) : void {
			this["txtLog"].scrollV++;
			if(!this["btnUp"].mouseEnabled) {
				this["btnUp"].mouseEnabled = true;
				this["btnUp"].alpha = 1;
			}
			if(this["txtLog"].scrollV == this["txtLog"].maxScrollV ) {
				this["btnDown"].mouseEnabled = false;
				this["btnDown"].alpha = 0.5;
			}
		}

		private function onClickCloseLog(event : MouseEvent) : void {
			//this["panelLog"].visible = false;
			play();
		}

		public function showLog() : void {
			this["txtLog"].htmlText = "";
			for (var t in MAView.model.logs) {
				var month : String = ((MAView.model.logs[t].time.month + 1) < 10) ? ("0" + (MAView.model.logs[t].time.month + 1)) : (MAView.model.logs[t].time.month + 1);
				var day : String = (MAView.model.logs[t].time.date < 10) ? ("0" + MAView.model.logs[t].time.date) : MAView.model.logs[t].time.date;
				var hour : String = (MAView.model.logs[t].time.hours < 10) ? ("0" + MAView.model.logs[t].time.hours) : MAView.model.logs[t].time.hours;
				var minute : String = (MAView.model.logs[t].time.minutes < 10) ? ("0" + MAView.model.logs[t].time.minutes) : MAView.model.logs[t].time.minutes;
				this["txtLog"].htmlText += ( month + "-" + day + " " + hour + ":" + minute + " " + MAView.model.logs[t].message);
			}
			this["btnUp"].mouseEnabled = false;
			this["btnUp"].alpha = 0.5;
			if(this["txtLog"].maxScrollV == 1) {
				this["btnDown"].mouseEnabled = false;
				this["btnDown"].alpha = 0.5;
			} else {
				this["btnDown"].mouseEnabled = true;
				this["btnDown"].alpha = 1;
			}
		}
	}
}
