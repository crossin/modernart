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

            this["textLog"].backgroundColor = "0xCDFFFF";
            this["textLog"].wordWrap = true;
            this["textLog"].multiline = true;
            this["textLog"].visible = false;
			
            this["btnLog"].addEventListener(MouseEvent.CLICK, onClickOpenLog);
            this["textLog"].addEventListener(MouseEvent.CLICK, onClickCloseLog);
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
        	
            this["textLog"].visible = true;
            addChild(this["textLog"]);
        }

        private function onClickCloseLog(event : MouseEvent) : void {
            this["textLog"].visible = false;
        }

        public function showLog() : void {
            this["textLog"].htmlText = "";
            for (var t in MAView.model.logs) {
                var month : String = ((MAView.model.logs[t].time.month + 1) < 10) ? ("0" + (MAView.model.logs[t].time.month + 1)) : (MAView.model.logs[t].time.month + 1);
                var day : String = (MAView.model.logs[t].time.date < 10) ? ("0" + MAView.model.logs[t].time.date) : MAView.model.logs[t].time.date;
                var hour : String = (MAView.model.logs[t].time.hours < 10) ? ("0" + MAView.model.logs[t].time.hours) : MAView.model.logs[t].time.hours;
                var minute : String = (MAView.model.logs[t].time.minutes < 10) ? ("0" + MAView.model.logs[t].time.minutes) : MAView.model.logs[t].time.minutes;
                this["textLog"].htmlText += ( month + "-" + day + " " + hour + ":" + minute + " " + MAView.model.logs[t].message + "<br>");
            }
        }
    }
}
