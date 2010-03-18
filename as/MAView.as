package {
    import flash.display.Sprite;

    /**
     * @author user
     */
    public class MAView extends Sprite {
        static var controller : MAController;
        static var model : MAModel;
        var centerView : CenterView;
        var msgBox : MessageBox;

        public function MAView() {
            model = new MAModel();
            controller = new MAController(this);
            
            centerView = new CenterView();
            addChild(centerView);
            
            msgBox = new MessageBox();
            msgBox.visible = false;
            addChild(msgBox);

            controller.initGame();
        }
    }
}
