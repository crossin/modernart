package {
    import flash.display.Loader;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.net.URLRequest;    

    /**
     * @author user
     */
    public class InfoPanel extends Sprite {
        var imgHead : Loader;

        public function InfoPanel() {
            imgHead = new Loader();
            imgHead.x = -40;
            imgHead.y = 40;
            addChild(imgHead);

            addEventListener(Event.ENTER_FRAME, onTick);
        }

        
        public function updateInfo() : void {
            this["textGold"].text = MAView.model.player.gold;
            this["textAvailable"].text = MAView.model.player.gold - MAView.model.player.gold_frozen;
            //this["textExp"].text = 
            var exp : int = MAView.model.player.exp;
            var next : int = 0;
            var level : int = 0;
            while(next <= exp) {
                level++;
                next = level * (level * 5 + 95);
            }
            this["textExp"].text = exp + " / " + next;
            this["textLevel"].text = "LV. " + level;
            
            imgHead.load(new URLRequest(MAConst.URL_PIC +"u" + MAView.model.player.id + ".jpg"));
            this["txtName"].text = MAView.model.player.name;
        }

        private function onTick(event : Event) : void {
            if(MAView.controller.timeStart) {
                var now : Date = new Date();
                var end : Date = new Date();
                now.setTime(now.getTime() - MAView.controller.timeStart.getTime() + MAView.controller.timeSystem.getTime());
                if(now.hours < 10) {
                    end.setHours(10, 0, 0, 0);
                }
            else if(now.hours < 14) {
                    end.setHours(14, 0, 0, 0);
                }
            else if(now.hours < 18) {
                    end.setHours(18, 0, 0, 0);
                }
            else if(now.hours < 22) {
                    end.setHours(22, 0, 0, 0);
                } else {
                    end.setDate(end.date + 1);
                    end.setHours(10, 0, 0, 0);
                }
                var delta : int = (end.getTime() - now.getTime()) / 1000 / 60;
                var minute : int = delta % 60;
                var hour : int = delta / 60;
                this["textTime"].text = hour + ":" + ((minute < 10) ? ("0" + minute) : minute);
            }
        }
    }
}
