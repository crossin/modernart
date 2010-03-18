package {
    import flash.display.Bitmap;
    import flash.display.Loader;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.net.URLRequest;    

    /**
     * @author user
     */
    public class SmallCard extends Sprite {
        //var mcLoader:MovieClipLoader;
        var content : Object;
        var image : Loader;
        var imgBorder : Bitmap;
        var imgType : Bitmap;
        var isSelected : Boolean;

        public function SmallCard(c : Object) {
            content = c;
                        
            image = new Loader();
            //configureListeners(loader.contentLoaderInfo);
            //loader.addEventListener(MouseEvent.CLICK, clickHandler);
            loadPic();
            image.x = -38;
            image.y = -77;
            addChild(image);
            imgBorder.x = -50;
            imgBorder.y = -100;
            addChild(imgBorder);
            if(imgType) {
                imgType.x = 12;
                imgType.y = -98;
                addChild(imgType);
            }
            
            addEventListener(MouseEvent.CLICK, clickHandler);
            addEventListener(MouseEvent.MOUSE_OVER, hoverHandler);
            addEventListener(MouseEvent.MOUSE_OUT, outHandler);
            
            buttonMode = true;
        }

        private function outHandler(event : MouseEvent) : void {
            if (!isSelected) {
                scaleX = 1;
                scaleY = 1;
            }
            //ListPanel(parent.parent).isSliding = false;
        }

        private function hoverHandler(event : MouseEvent) : void {
            scaleX = 1.2;
            scaleY = 1.2; 
            parent.addChildAt(this, parent.numChildren - 1);
            

            //            ListPanel(parent.parent).cardSelected = this;
            //ListPanel(parent.parent).isSliding = true;
        }

        private function clickHandler(event : MouseEvent) : void {
            // select
            var c : Bitmap = ListPanel(parent.parent).circle;
            c.visible = true;
            c.x = this.x + parent.x - 80;
            c.y = this.y - 150;
            
            var sc : SmallCard = ListPanel(parent.parent).cardSelected;
            if (sc) {
                sc.isSelected = false;
                sc.scaleX = 1;
                sc.scaleY = 1;
            }
            ListPanel(parent.parent).cardSelected = this;
            isSelected = true;
            
            MAView.controller.onClickSmallCard(content);
            ListPanel(parent.parent).showButton();
        }

        private function loadPic() : void {
            var request : URLRequest;
            if(content is CardModel) {
                request = new URLRequest(content["content"] + "_s.png");
                switch(content["card_class"]) {
                    case 0:
                        imgBorder = new Bitmap(new PicSmallBorder_0(100, 100));
                        break;
                    case 1:
                        imgBorder = new Bitmap(new PicSmallBorder_1(100, 100));
                        break;
                    case 2:
                        imgBorder = new Bitmap(new PicSmallBorder_2(100, 100));
                        break;
                    case 3:
                        imgBorder = new Bitmap(new PicSmallBorder_3(100, 100));
                        break;
                    case 4:
                        imgBorder = new Bitmap(new PicSmallBorder_4(100, 100));
                        break;
                    case 5:
                        imgBorder = new Bitmap(new PicSmallBorder_5(100, 100));
                        break;
                    case 6:
                        imgBorder = new Bitmap(new PicSmallBorder_6(100, 100));
                        break;
                    case 7:
                        imgBorder = new Bitmap(new PicSmallBorder_7(100, 100));
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
            }
            else if(content is AuctionModel) {
                request = new URLRequest(content["card"].content + "_s.png");
                switch(content["card"].card_class) {
                    case 0:
                        imgBorder = new Bitmap(new PicSmallBorder_0(100, 100));
                        break;
                    case 1:
                        imgBorder = new Bitmap(new PicSmallBorder_1(100, 100));
                        break;
                    case 2:
                        imgBorder = new Bitmap(new PicSmallBorder_2(100, 100));
                        break;
                    case 3:
                        imgBorder = new Bitmap(new PicSmallBorder_3(100, 100));
                        break;
                    case 4:
                        imgBorder = new Bitmap(new PicSmallBorder_4(100, 100));
                        break;
                    case 5:
                        imgBorder = new Bitmap(new PicSmallBorder_5(100, 100));
                        break;
                    case 6:
                        imgBorder = new Bitmap(new PicSmallBorder_6(100, 100));
                        break;
                    case 7:
                        imgBorder = new Bitmap(new PicSmallBorder_7(100, 100));
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
            }
            else if(content is CenterModel) {
                request = new URLRequest("ac" + content["id"] + "_s.png");
                imgBorder = new Bitmap(new PicSmallBorder_AC(100, 100));
            }
            //loader.load(request);
            image.load(request);
        }

        
        
        public function deconstructor() : void {
            content = null;
            imgBorder = null;
            imgType = null;
            image.unloadAndStop();
            removeEventListener(MouseEvent.CLICK, clickHandler);
            parent.removeChild(this);
        }
    }
}
