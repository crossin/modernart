package {
	import flash.display.Sprite;
	import flash.events.MouseEvent;    

	/**
	 * @author user
	 */
	public class CenterView extends Sprite {
		var infoPanel : InfoPanel;
		var showPanel : ShowPanel;
		var rankPanel : RankPanel;
		var listPanel : ListPanel;

		
		public function CenterView() {
			InitLayout();
			this["btnLog"].addEventListener(MouseEvent.CLICK, onClickOpenLog);
		}

		private function InitLayout() : void {          
			showPanel = new ShowPanel();
			showPanel.x = 5;
			showPanel.y = 100;
			addChild(showPanel);
            
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
