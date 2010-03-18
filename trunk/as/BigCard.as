package {
    import flash.display.Bitmap;
    import flash.display.Loader;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.net.URLRequest;    

    /**
     * @author user
     */
    public class BigCard extends Sprite {
        var content : Object;
        var image : Loader;
        var imgBorder : Bitmap;
        var imgType : Bitmap;

        public function BigCard(c : Object) {
            content = c;
            image = new Loader();
            loadPic();
            image.x = 16;
            image.y = 48;
            addChild(image);
            //imgBorder.x = -50;
            //imgBorder.y = -100;
            addChild(imgBorder);
            if(imgType) {
                imgType.x = 150;
                imgType.y = 7;
                addChild(imgType);
            }      

            //            addEventListener(MouseEvent.CLICK, clickHandler);
            //            buttonMode = true;
            addChild(this["textName"]);
            addChild(this["textDesc"]);
        }

        //        private function clickHandler(event : MouseEvent) : void {
        //            //ShowPanel(parent).showButton();
        //        }

        private function loadPic() : void {      	
            var request : URLRequest;
            if(content is CardModel) {
                request = new URLRequest(content["content"] + ".png");
                switch(content["card_class"]) {
                    case 0:
                        imgBorder = new Bitmap(new PicBigBorder_0(200, 270));
                        break;
                    case 1:
                        imgBorder = new Bitmap(new PicBigBorder_1(200, 270));
                        break;
                    case 2:
                        imgBorder = new Bitmap(new PicBigBorder_2(200, 270));
                        break;
                    case 3:
                        imgBorder = new Bitmap(new PicBigBorder_3(200, 270));
                        break;
                    case 4:
                        imgBorder = new Bitmap(new PicBigBorder_4(200, 270));
                        break;
                    case 5:
                        imgBorder = new Bitmap(new PicBigBorder_5(200, 270));
                        break;
                    case 6:
                        imgBorder = new Bitmap(new PicBigBorder_6(200, 270));
                        break;
                    case 7:
                        imgBorder = new Bitmap(new PicBigBorder_7(200, 270));
                        break;
                }
                switch(content["auction_type"]) {
                    case 1:
                        imgType = new Bitmap(new PicType_1(36, 36));
                        break;
                    case 2:
                        imgType = new Bitmap(new PicType_2(36, 36));
                        break;
                    case 3:
                        imgType = new Bitmap(new PicType_3(36, 36));
                        break;
                }
                this["textName"].text = CardModel.CARD_NAMES[content["content"] - 1];
                this["textDesc"].text = CardModel.CARD_DESCS[content["content"] - 1];
            }
            else if(content is AuctionModel) {
                request = new URLRequest(content["card"].content + ".png");
                switch(content["card"].card_class) {
                    case 0:
                        imgBorder = new Bitmap(new PicBigBorder_0(200, 270));
                        break;
                    case 1:
                        imgBorder = new Bitmap(new PicBigBorder_1(200, 270));
                        break;
                    case 2:
                        imgBorder = new Bitmap(new PicBigBorder_2(200, 270));
                        break;
                    case 3:
                        imgBorder = new Bitmap(new PicBigBorder_3(200, 270));
                        break;
                    case 4:
                        imgBorder = new Bitmap(new PicBigBorder_4(200, 270));
                        break;
                    case 5:
                        imgBorder = new Bitmap(new PicBigBorder_5(200, 270));
                        break;
                    case 6:
                        imgBorder = new Bitmap(new PicBigBorder_6(200, 270));
                        break;
                    case 7:
                        imgBorder = new Bitmap(new PicBigBorder_7(200, 270));
                        break;
                }
                switch(content["card"].auction_type) {
                    case 1:
                        imgType = new Bitmap(new PicType_1(36, 36));
                        break;
                    case 2:
                        imgType = new Bitmap(new PicType_2(36, 36));
                        break;
                    case 3:
                        imgType = new Bitmap(new PicType_3(36, 36));
                        break;
                }
                this["textName"].text = CardModel.CARD_NAMES[content["card"].content - 1];
                this["textDesc"].text = CardModel.CARD_DESCS[content["card"].content - 1];
            }
            else if(content is CenterModel) {
                request = new URLRequest("ac" + content["id"] + ".png");
                imgBorder = new Bitmap(new PicBigBorder_AC(200, 270));
            }
            image.load(request);
        }

        public function deconstructor() : void {
            content = null;
            imgBorder = null;
            imgType = null;
            image.unloadAndStop();
            //            removeEventListener(MouseEvent.CLICK, clickHandler);
            parent.removeChild(this);
        }
    }
}
