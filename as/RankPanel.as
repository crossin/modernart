package {
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.text.TextFormat;	

	/**
	 * @author user
	 */
	public class RankPanel extends Sprite {
		var rankList : Array;
		var effectChange : int;
		var sortType : int;
		var timeChange : int;
		var imgCenter : Loader;

		const SORT_COUNT : int = 1;
		const SORT_PRICE : int = 2;
		const SORT_VALUE : int = 3;
		const SORT_INDEX : int = 4;

		public function RankPanel() {
			rankList = new Array();
			effectChange = 0;
			sortType = SORT_COUNT;
            
			imgCenter = new Loader();
			imgCenter.x = 200;
			imgCenter.y = 0;
			imgCenter.scaleX = 0.3;
			imgCenter.scaleY = 0.3;
			imgCenter.mask = this["maskCenter"];
			addChild(imgCenter);
			//            this["rankHint"].visible = false;
			//			this["boxSort"].setStyle("fontSize", 36);
			var format : TextFormat = new TextFormat("_sans", 12);	
			this["boxSort"].textField.setStyle("textFormat", format);			
			this["boxSort"].dropdown.setRendererStyle("textFormat", format);
			this["boxSort"].addEventListener(Event.CHANGE, onChange);
			this["boxSort"].addEventListener(MouseEvent.MOUSE_OVER, onHover);
			this["boxSort"].addEventListener(MouseEvent.MOUSE_OUT, onLeave);

			//			this["btnCount"].addEventListener(MouseEvent.CLICK, onCount);
			//			this["btnPrice"].addEventListener(MouseEvent.CLICK, onPrice);
			//			this["btnValue"].addEventListener(MouseEvent.CLICK, onValue);
			//			this["btnIndex"].addEventListener(MouseEvent.CLICK, onIndex);
			addEventListener(Event.ENTER_FRAME, onUpdate);
		}

		private function onHover(event : MouseEvent) : void {
			parent["txtHint"].text = "选择排序方式";
			parent["onHint"] = true;
		}

		private function onLeave(event : MouseEvent) : void {
			parent["onHint"] = false;
		}

		private function onChange(event : Event) : void {
			switch(this["boxSort"].selectedLabel) {
				case "本轮交易量":
					onCount();
					break;
				case "本轮回购价":
					onPrice();
					break;
				case "历史价值":
					onValue();
					break;
				case "稀有程度":
					onIndex();
					break;
			}
		}

		private function onUpdate(event : Event) : void {
			//            if (rankList.length > 0) {
			if(effectChange == 1) {
				if (timeChange <= 0) {
					clearPrices();
					effectChange = 2;
					switch(sortType) {
						case SORT_COUNT:
							MAView.model.prices.sortOn(["count","card_class"], [Array.DESCENDING | Array.NUMERIC, Array.NUMERIC]);
							break;
						case SORT_PRICE:
							MAView.model.prices.sortOn(["price_now","card_class"], [Array.DESCENDING | Array.NUMERIC, Array.NUMERIC]);
							break;
						case SORT_VALUE:
							MAView.model.prices.sortOn(["price_all","card_class"], [Array.DESCENDING | Array.NUMERIC, Array.NUMERIC]);
							break;
						case SORT_INDEX:
							MAView.model.prices.sortOn("card_class", Array.NUMERIC);
							break;
					}
					showPrices(MAView.model.prices);
					timeChange = 0;
				} else {
					rankList[timeChange].visible = false;
					timeChange--;
				}
			}
           	else if(effectChange == 2) {

				if (timeChange >= rankList.length) {
					effectChange = 0;
				} else {                
					rankList[timeChange].visible = true;
					timeChange++;
				}
			}
//            }
		}

		private function onCount() : void {
			sortType = SORT_COUNT;
			effectChange = 1;
			timeChange = rankList.length - 1;
		}

		private function onIndex() : void {
			sortType = SORT_INDEX;
			effectChange = 1;
			timeChange = rankList.length - 1;
		}

		private function onValue() : void {
			sortType = SORT_VALUE;
			effectChange = 1;
			timeChange = rankList.length - 1;
		}

		private function onPrice() : void {
			sortType = SORT_PRICE;
			effectChange = 1;
			timeChange = rankList.length - 1;
		}

		public function refreshPrices() : void {
			updateInfo();
			effectChange = 1;
			timeChange = rankList.length - 1;
		}

		private function updateInfo() : void {
			var center : CenterModel = MAView.model.center;
			imgCenter.load(new URLRequest(MAConst.URL_PIC + "ac" + center.id + ".png"));
			this["txtCenter"].text = center.name + " (" + center.count_player + "/" + center.max_player + ")";
			this["boxSort"].textField.y = 0;
			this["boxSort"].textField.height = 18;
		}

		public function showPrices(list : Array) : void {
			for(var p in list) {
				rankList.push(new RankItem(list[p]));
				rankList[p].x = 10;
				rankList[p].y = 40 * p + 50;
				rankList[p].visible = false;
				addChild(rankList[p]);
			}
			//            this["rankHint"].x = 50 * MAView.controller.currentPhase + 10;
			//            this["rankHint"].visible = true;
			//            addChild(this["rankHint"]);
		}

		public function clearPrices() : void {
			var temp : RankItem;
			while(rankList.length > 0) {
				temp = rankList.pop();
				temp.deconstructor();
				//removeChild(temp);
				temp = null;
			}
//			this["txtCenter"].text = "";
//            this["rankHint"].visible = false;
		}
	}
}
