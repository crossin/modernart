package {
    import flash.display.Bitmap;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.ui.Mouse;    

    /**
     * @author user
     */
    public class ListPanel extends Sprite {
        var cardList : Array;
        var nextList : Array;
        var posLeft : int;
        var posRight : int;
        var posCurrent : int;
        var cardSelected : SmallCard;
        var cardContainer : Sprite;
        //        var isSliding : Boolean;
        var border : Bitmap;
        var circle : Bitmap;
        var cursor : Sprite;
        var speed : Number;
        var listType : int;
        var effectChange : int;

        
        //var btnAuction : SimpleButton;

        public function ListPanel() {
            listType = MAConst.LIST_CARDS;
            posLeft = 50;
            posRight = 700;
            speed = 0;
            posCurrent = posLeft;
            effectChange = 0;
            //            isSliding = false;
            //cardList = new Array();
            //cardList.push(new SmallCard());
            //addChild(cardList[0]);
            cardList = new Array();

            cardContainer = new Sprite();
            addChild(cardContainer);
            //hideButton();

            this["arrowLeft"].alpha = 0.5;
            addChild(this["arrowLeft"]);
            this["arrowRight"].alpha = 0.5;
            addChild(this["arrowRight"]);
            
            addChild(this["btnGetAuctions"]);
            addChild(this["btnGetCards"]);
            addChild(this["btnGetBids"]);
            addChild(this["btnGetBought"]);
            addChild(this["btnGetCenters"]);
            
            border = new Bitmap(new PicListBorder(760, 140));
            addChild(border);
            
            cardContainer.cacheAsBitmap = true;
            //this["maskList"].cacheAsBitmap = true;
            cardContainer.mask = this["maskList"];
            
            circle = new Bitmap(new PicSelect(168, 170));
            circle.visible = false;
            addChild(circle);
            
            this["btnAuction"].visible = false;
            addChild(this["btnAuction"]);
            this["btnBid"].visible = false;
            addChild(this["btnBid"]);
            this["btnEnter"].visible = false;
            addChild(this["btnEnter"]);
				
            this["listBack"].gotoAndStop("CCENTER");
            
            this["btnGetAuctions"].addEventListener(MouseEvent.CLICK, onClickGetAuctions);
            this["btnGetCards"].addEventListener(MouseEvent.CLICK, onClickGetCards);
            this["btnGetBids"].addEventListener(MouseEvent.CLICK, onClickGetBids);
            this["btnGetBought"].addEventListener(MouseEvent.CLICK, onClickGetBought);
            this["btnGetCenters"].addEventListener(MouseEvent.CLICK, onClickGetCenters);
            
            this["btnAuction"].addEventListener(MouseEvent.CLICK, onClickAuction);
            this["btnBid"].addEventListener(MouseEvent.CLICK, onClickBid);
            this["btnEnter"].addEventListener(MouseEvent.CLICK, onClickEnter);
          
            this["arrowLeft"].addEventListener(MouseEvent.MOUSE_OVER, onSlideLeft);
            this["arrowRight"].addEventListener(MouseEvent.MOUSE_OVER, onSlideRight);
            this["arrowLeft"].addEventListener(MouseEvent.MOUSE_OUT, onStop);
            this["arrowRight"].addEventListener(MouseEvent.MOUSE_OUT, onStop);
                        
            addEventListener(Event.ENTER_FRAME, onUpdate);
        }

        private function onStop(event : MouseEvent) : void {
            this["arrowLeft"].alpha = 0.5;
            this["arrowRight"].alpha = 0.5;
            speed = 0;
        }

        
        private function onSlideLeft(event : MouseEvent) : void {
            if (posCurrent < posLeft) {
                this["arrowLeft"].alpha = 1;
                hideButton();
                speed = 3;
            }
        }

        private function onSlideRight(event : MouseEvent) : void {
            if (posCurrent + cardContainer.width > posRight) {
                this["arrowRight"].alpha = 1;
                hideButton();
                speed = -3;
            }
        }

        private function onUpdate(event : Event) : void {
            if ((posCurrent < posLeft && speed > 0) || (posCurrent + cardContainer.width > posRight) && (speed < 0)) {
                cardContainer.x += speed;
                posCurrent = cardContainer.x;
            } else {
                this["arrowLeft"].alpha = 0.5;
                this["arrowRight"].alpha = 0.5;
                speed = 0;
            }
            
            if(effectChange == 1) {
                cardContainer.y += 15;
                if (cardContainer.y > 100) {
                    effectChange = 2;
                    clearList();
                    cardList = nextList;
                    nextList = null;
                    for(var c in cardList) {
                        cardContainer.addChild(cardList[c]);
                    } 
                }
            }
            else if(effectChange == 2) {
                cardContainer.y -= 15;
                if (cardContainer.y < 0) {
                    effectChange = 0;
                    cardContainer.y = 0;
                }
            }
        }

        private function onClickGetCenters(event : MouseEvent) : void {
            MAView.controller.getCenterList();
            hideButton();
        }

        private function onClickGetBids(event : MouseEvent) : void {
            MAView.controller.getBidList();
            hideButton();
        }

        private function onClickGetCards(event : MouseEvent) : void {
            listType = MAConst.LIST_CARDS;;
            MAView.controller.getCardList();
            hideButton();
        }

        private function onClickGetBought(event : MouseEvent) : void {
            listType = MAConst.LIST_BOUGHT;
            MAView.controller.getCardList();
            hideButton();
        }

        private function onClickGetAuctions(event : MouseEvent) : void {
            MAView.controller.getAuctionList();
            hideButton();
        }

        private function onClickAuction(event : MouseEvent) : void {
            if(cardSelected.content["auction_type"] == 3) {
                MAView.controller.showOfferBox();
            } else {
                MAView.controller.auction(cardSelected.content["id"]);
            }
        }

        private function onClickBid(event : MouseEvent) : void {
            if(cardSelected.content["card"].auction_type == 3) {
                MAView.controller.bid(cardSelected.content["id"]);
            } else {
                MAView.controller.showBidBox();
            }
        }

        private function onClickEnter(event : MouseEvent) : void {
            MAView.controller.enterAuctionCenter(cardSelected.content["id"]);
        }

        public function showList(list : Array) : void {
            //var index:int =0;
            //
            //            cardSelected = null;

            //clearList();
            
            nextList = new Array();
            for(var c in list) {
                nextList.push(new SmallCard(list[c]));
                nextList[c].x = 101 * c + 55;
                nextList[c].y = 132;
                //cardContainer.addChild(cardList[c]);
            }
            effectChange = 1;
            hideButton();
        }

        public function clearList() : void {
            var temp : SmallCard;
            while(cardList.length > 0) {
                temp = cardList.pop();
                temp.deconstructor();
                //removeChild(temp);
                temp = null;
            }
            //            isSliding = false;
            posCurrent = posLeft;
            cardContainer.x = posCurrent;
            
        }

        public function showButton() : void {
            //this["btnGetCenters"].visible = true;

            if(cardSelected) {
                if(cardSelected.content is CardModel) {
                    this["btnAuction"].visible = true;
                    this["btnAuction"].x = cardSelected.x + cardContainer.x - 40;
                }
	            else if(cardSelected.content is AuctionModel) {
                    this["btnBid"].visible = true;
                    this["btnBid"].x = cardSelected.x + cardContainer.x - 40;
	//                this["btnBid"].visible = true;
	//                pricePanel["txtPrice"].text = card.content["price"];
	//                MAView.controller.getAuction(card.content["id"]);
	//                //pricePanel["txtOwner"].text = card.content["owner"];
	//                //pricePanel["txtBidder"].text = card.content["bidder"];
	//                pricePanel.visible = true;
                }
	            else if(cardSelected.content is CenterModel) {
                    this["btnEnter"].visible = true;
                    this["btnEnter"].x = cardSelected.x + cardContainer.x - 40;
                }
            } else {
                this["btnAuction"].visible = false;
            }
        }

        public function hideButton() : void {
            this["btnAuction"].visible = false;
            this["btnBid"].visible = false;
            this["btnEnter"].visible = false;
            circle.visible = false;
        }

//        public function hideTab() : void {
//            this["btnGetAuctions"].visible = false;
//            this["btnGetCards"].visible = false;
//            this["btnGetBought"].visible = false;
//            this["btnGetCenters"].visible = false;
//            this["btnGetBids"].visible = false;
//        }

//        public function showTab() : void {
//            this["btnGetAuctions"].visible = true;
//            this["btnGetCards"].visible = true;
//            this["btnGetBought"].visible = true;
//            this["btnGetCenters"].visible = true;
//            this["btnGetBids"].visible = true;
//        }
    }
}
