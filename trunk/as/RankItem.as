package {
    import flash.display.Sprite;    

    /**
     * @author user
     */
    public class RankItem extends Sprite {
        var content : Object;

        public function RankItem(p : Object) {
            content = p;
            this["txtClass"].text = content["card_class"];
            this["txtCount"].text = content["count"];
            var medal : Medal;
            for (var i : int = 1;i <= 4;i++) {
                if (content["price_" + i] != 0) {
                    medal = new Medal(content["price_" + i]);
                    medal.x = 50 * i;
                    medal.y = 0;
                    addChild(medal);
                }
            }
            if (content["repurchasable"]) {
                var medal_yes : MedalYes = new MedalYes(content["price_now"]);
                medal_yes.x = 50 * MAView.controller.currentPhase;
                medal_yes.y = 0;
                addChild(medal_yes);
            } else {
                var medal_no : MedalNo = new MedalNo(content["price_now"]);
                medal_no.x = 50 * MAView.controller.currentPhase;
                medal_no.y = 0;
                addChild(medal_no);
            }
        }

        public function deconstructor() : void {
            content = null;
            //loader.unloadAndStop();
            //removeEventListener(MouseEvent.CLICK, clickHandler);
            parent.removeChild(this);
        }
    }
}
