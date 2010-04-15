package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;	

	/**
	 * @author user
	 */
	public class CenterView extends Sprite {
		var infoPanel : InfoPanel;
		var showPanel : ShowPanel;
		var rankPanel : RankPanel;
		var listPanel : ListPanel;
		var onHint : Boolean;
		var tick : int;

		public function CenterView() {
			InitLayout();
			onHint = false;
			tick = 0;
			this["txtHint"].backgroundColor = 0xffffcc;
			this["txtHint"].alpha = 0.7;
			this["txtHint"].multiline = true;
			//this["txtHint"].wordWrap = false;
			this["txtHint"].autoSize = TextFieldAutoSize.LEFT;
			this["txtHint"].mouseEnabled = false;
			this["txtHint"].visible = false;
			
			this["btnLog"].addEventListener(MouseEvent.CLICK, onClickOpenLog);
			this["btnLog"].addEventListener(MouseEvent.MOUSE_OVER, onHover);
			this["btnLog"].addEventListener(MouseEvent.MOUSE_OUT, onLeave);
			
			addEventListener(Event.ENTER_FRAME, onUpdate);
		}

		private function onUpdate(event : Event) : void {
			if(onHint) {
				if (!this["txtHint"].visible && tick > 15) {
					addChild(this["txtHint"]);
					this["txtHint"].x = (stage.mouseX + 15 + this["txtHint"].width > MAConst.WIDTH - 10) ? (MAConst.WIDTH - 10 - this["txtHint"].width) : (stage.mouseX + 15);
					this["txtHint"].y = stage.mouseY + 15;
					this["txtHint"].visible = true;
				} else {
					tick++;
				}
			} else {
				if (this["txtHint"].visible) {
					tick = 0;
					this["txtHint"].visible = false;
				}
			}
		}

		private function onHover(event : MouseEvent) : void {
			this["txtHint"].text = "日志";
			onHint = true;
		}

		private function onLeave(event : MouseEvent) : void {
			onHint = false;
		}

		private function InitLayout() : void {          
			infoPanel = new InfoPanel();
			infoPanel.x = 50;
			infoPanel.y = 5;
			addChild(infoPanel);
            
			rankPanel = new RankPanel();
			rankPanel.x = 530;
			rankPanel.y = 50;
			addChild(rankPanel);
            
			listPanel = new ListPanel();
			listPanel.x = 20;
			listPanel.y = 450;
			addChild(listPanel);
			
			showPanel = new ShowPanel();
			showPanel.x = 5;
			showPanel.y = 100;
			addChild(showPanel);
		}

		private function onClickOpenLog(event : MouseEvent) : void {
			MAView.controller.getPlayerLog();
			this["panelLog"].gotoAndPlay(1);
			this["panelLog"].visible = true;
			addChild(this["panelLog"]);
		}

		public function showLog() : void {
			this["panelLog"].showLog();
		}
	}
}
