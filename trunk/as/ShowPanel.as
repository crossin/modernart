package {
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;    

	/**
	 * @author user
	 */
	public class ShowPanel extends Sprite {
		var card : BigCard;
		var auctionBox : InputBox;
		var bidBox : InputBox;
		//var pricePanel : PricePanel;
		var headImage : Loader;
		var auctionStart : Date;

		public function ShowPanel() {
        	
			//txt.text = "123abc";
			//txt.filters = [new GlowFilter(0, 1, 2, 2, 10, 1)];
			//showCard = new BigCard();
			//showCard.x = 100;
			//showCard.y = 50;
			//addChild(showCard);
			auctionBox = new InputBox();
			bidBox = new InputBox();
			//pricePanel = new PricePanel();
			//addChild(pricePanel);
			//inputBox.z = 9999
			auctionBox.visible = false;
			bidBox.visible = false;
			auctionBox["btnOK"].addEventListener(MouseEvent.CLICK, onClickAuction);
			bidBox["btnOK"].addEventListener(MouseEvent.CLICK, onClickBid);
            
			initInfoBoxes();
            
//            this["btnAuction"].addEventListener(MouseEvent.CLICK, onClickAuction);
//            this["btnBid"].addEventListener(MouseEvent.CLICK, onClickBid);
//            this["btnEnter"].addEventListener(MouseEvent.CLICK, onClickEnter);
		}

		private function onClickBid(event : MouseEvent) : void {
			bidBox.visible = false;
			if(bidBox["txtIn"].text > 0) {
				//MAView.controller.bid(ShowPanel(parent).card.content["id"], this["txtIn"].text);
				MAView.controller.bid(card.content["id"], bidBox["txtIn"].text);
			}		
		}

		private function onClickAuction(event : MouseEvent) : void {
			auctionBox.visible = false;
			if(auctionBox["txtIn"].text > 0) {
				//MAView.controller.bid(ShowPanel(parent).card.content["id"], this["txtIn"].text);
				MAView.controller.auction(card.content["id"], auctionBox["txtIn"].text);
			}
		}

		private function initInfoBoxes() : void {
			headImage = new Loader();
			headImage.x = 20;
			headImage.y = 22;
			headImage.scaleX = 1.3;
			headImage.scaleY = 1.3;
			auctionStart = null;


			this["boxUser"].addChildAt(headImage, 0);
            
			//                        var request : URLRequest;
			//            request = new URLRequest("head.jpg");

			this["boxUser"].visible = false;
			this["boxGold"].visible = false;
			this["boxTime"].visible = false;

			headImage.load(new URLRequest(MAConst.URL_PIC + "head.jpg"));
            
			addEventListener(Event.ENTER_FRAME, onTick);
		}

		
		//private function hideButton() : void {
		//this["btnAuction"].visible = false;
		//this["btnBid"].visible = false;
		//this["btnEnter"].visible = false;
		//this["btnExit"].mouseEnabled = false;
            
		//this["btnExit"].visible = false;
		//pricePanel.visible = false;
		//}

		//        private function onClickBid(event : MouseEvent) : void {
		//
		//            //MAView.controller.bid(card.content["id"], 18);
		//        }        

		//        private function onClickEnter(event : MouseEvent) : void {
		//            MAView.controller.enterAuctionCenter(card.content["id"]);
		//        }

		//        private function onClickAuction(event : MouseEvent) : void {
		//            MAView.controller.auction(card.content["id"]);
		//        }
		public function showAuctionBox() : void {
			addChild(auctionBox);
			auctionBox.visible = true;
		}

		public function showBidBox() : void {
			addChild(bidBox);
			bidBox.visible = true;
		}

		public function showCard(content : Object) : void {
			clearCard();
			card = new BigCard(content);
			card.x = 145;
			card.y = 40;
			addChild(card);
            
			//show info
			showInfo();
		}

		public function clearCard() : void {
			if (card) {
				card.deconstructor();
				card = null;
                //hideButton();
			}
			this["boxUser"].visible = false;
			this["boxGold"].visible = false;
			this["boxTime"].visible = false;
			auctionStart = null;
		}

		private function showInfo() : void {
			//this["btnExit"].visible = true;
			if(card.content is CardModel) {


            }
            else if(card.content is AuctionModel) {
				this["boxUser"].visible = true;
				this["boxGold"].visible = true;
				this["boxTime"].visible = true;
                
				//this["boxUser"].textGold.text = card.content["price"];
                
				//
				this["boxGold"].textGold.text = card.content["price"];
				
				//this["btnBid"].visible = true;
				//pricePanel["txtPrice"].text = card.content["price"];
				MAView.controller.getAuction(card.content["id"]);
                //pricePanel["txtOwner"].text = card.content["owner"];
                //pricePanel["txtBidder"].text = card.content["bidder"];
                //pricePanel.visible = true;
			}
            else if(card.content is CenterModel) {
                //this["btnEnter"].visible = true;
            }
		}

		public function updateAuctionInfo(a : Object) : void {
			if (card.content["id"] == a["id"]) {
				headImage.load(new URLRequest(MAConst.URL_PIC + "u" + a["owner"].id + ".jpg"));
				this["boxGold"].textGold.text = a["price"];
                
				auctionStart = a["time_start"];
				var now : Date = new Date();
				now.setTime(now.getTime() - MAView.controller.timeStart.getTime() + MAView.controller.timeSystem.getTime());
				var delta : int = (now.getTime() - auctionStart.getTime()) / 1000;
				var second : int = delta % 60;
				var minute : int = delta / 60 % 60;
				this["boxTime"].textTime.text = minute + ":" + second;
                
				//pricePanel["txtOwner"].text = a["owner"].id;
				if (a["bidder"]) {
                    //pricePanel["txtBidder"].text = a["bidder"].id;
                }
			}
		}

		private function onTick(event : Event) : void {
			if (auctionStart) {
				var now : Date = new Date();
				now.setTime(now.getTime() - MAView.controller.timeStart.getTime() + MAView.controller.timeSystem.getTime());
				var delta : int = (now.getTime() - auctionStart.getTime()) / 1000;
				var second : int = delta % 60;
				var minute : int = delta / 60 % 60;
				// var flash : Boolean = (now.getTime() / 500 % 2) < 1;
				this["boxTime"].textTime.text = minute + ":" + ((second < 10) ? ("0" + second) : second);
  //         this["boxTime"].textTime.text=MAView.controller.timeStart.getTime() - MAView.controller.timeSystem.getTime()
			}
		}
	}
}
