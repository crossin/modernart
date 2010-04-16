package {
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
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
		var button : MovieClip;

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

			addEventListener(MouseEvent.CLICK, clickHandler);
			addEventListener(MouseEvent.MOUSE_OVER, overHandler);
			addEventListener(MouseEvent.MOUSE_OUT, outHandler);

			addChild(this["textName"]);
			addChild(this["textDesc"]);
			mouseChildren = false;
			checkButton();
		}

		private function checkButton() : void {
			this["btnAuction"].visible = false;
			this["btnBid"].visible = false;
			this["btnEnter"].visible = false;
			if(content is CardModel) {
				button = this["btnAuction"];
				addChild(this["btnAuction"]);
			}
            else if(content is AuctionModel) {
				button = this["btnBid"];
				addChild(this["btnBid"]);
			}
            else if(content is CenterModel) {
				button = this["btnEnter"];
				addChild(this["btnEnter"]);
			}
			buttonMode = true;
		}

		private function outHandler(event : MouseEvent) : void {
			parent.parent["onHint"] = false;
			if(buttonMode) {
				button.visible = false;
			}
		}

		private function overHandler(event : MouseEvent) : void {
			//if(buttonMode) {
			if(content is CardModel) {
				if (MAView.model.player.in_auction) {
					buttonMode = false;
					parent.parent["txtHint"].text = "正在拍卖过程中\n不能再发起拍卖";
				} else {
					parent.parent["txtHint"].text = "点击拍卖此商品";
				}	
			} else if(content is AuctionModel) {
				if (content["bidder_id"] == MAView.model.player.id) {
					buttonMode = false;
					parent.parent["txtHint"].text = "已经对此商品出价\n无需再次竞拍";
				} else if (((content["card"].auction_type == 1) && (MAView.model.player.gold - MAView.model.player.gold_frozen <= content["price"])) || ((content["card"].auction_type == 2) && (MAView.model.player.gold - MAView.model.player.gold_frozen <= 0)) || ((content["card"].auction_type == 3) && (MAView.model.player.gold - MAView.model.player.gold_frozen < content["price"]))) {
					buttonMode = false;
					parent.parent["txtHint"].text = "资金不足\n不能参与竞拍此商品";
				} else {
					parent.parent["txtHint"].text = "点击竞拍此商品";
				}		
			} else if(content is CenterModel) {
				if (content["id"] == MAView.model.center.id) {
					buttonMode = false;
					parent.parent["txtHint"].text = "已经在此拍卖行中";
				} else if (MAView.model.player.in_auction) {
					buttonMode = false;
					parent.parent["txtHint"].text = "正在拍卖过程中\n不能离开当前拍卖行";
				} else {
					parent.parent["txtHint"].text = "点击进入拍卖行";
				}
			}
			//}
			if(buttonMode) {
				button.visible = true;
			}
			if(buttonMode || !button.visible) {
				parent.parent["onHint"] = true;
			}
		}

		private function clickHandler(event : MouseEvent) : void {
			if(buttonMode) {
				if(content is CardModel) {
					onAuction();
				}
           		else if(content is AuctionModel) {
					onBid();
				}
            	else if(content is CenterModel) {
					onEnter();
				}
			}
			buttonMode = false;
			//removeEventListener(MouseEvent.CLICK, clickHandler);
		}

		public function action() : void {
			buttonMode = false;
			button.play();
		}

		//        private function clickHandler(event : MouseEvent) : void {
		//            //ShowPanel(parent).showButton();
		//        }

		private function onAuction() : void {
			if(content["auction_type"] == 3) {
				MAView.controller.showOfferBox();
			} else {
				MAView.controller.auction(content["id"]);
			}
		}

		private function onBid() : void {
			if(content["card"].auction_type == 3) {
				MAView.controller.bid(content["id"]);
			} else {
				MAView.controller.showBidBox();
			}
		}

		private function onEnter() : void {
			MAView.controller.enterAuctionCenter(content["id"]);
		}

		
		private function loadPic() : void {      	
			var request : URLRequest;
			if(content is CardModel) {
				request = new URLRequest(MAConst.URL_PIC + content["content"] + ".png");
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
				this["textName"].text = content["name"];
				this["textDesc"].text = content["description"];
			}
            else if(content is AuctionModel) {
				request = new URLRequest(MAConst.URL_PIC + content["card"].content + ".png");
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
				this["textName"].text = content["card"].name;
				this["textDesc"].text = content["card"].description;
//				this["textName"].text = CardModel.CARD_NAMES[content["card"].content - 1];
//				this["textDesc"].text = CardModel.CARD_DESCS[content["card"].content - 1];
			}
            else if(content is CenterModel) {
				request = new URLRequest(MAConst.URL_PIC + "ac" + content["id"] + ".png");
				imgBorder = new Bitmap(new PicBigBorder_AC(200, 270));
				this["textName"].text = content["name"];
				this["textDesc"].text = content["description"];
			}
			image.load(request);
		}

		public function deconstructor() : void {
			content = null;
			imgBorder = null;
			imgType = null;
			image.unloadAndStop();
			removeEventListener(MouseEvent.CLICK, clickHandler);
			removeEventListener(MouseEvent.MOUSE_OVER, overHandler);
			removeEventListener(MouseEvent.MOUSE_OUT, outHandler);
			parent.removeChild(this);
		}
	}
}
