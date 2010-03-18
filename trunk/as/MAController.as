package {
    import flash.display.LoaderInfo;
    import flash.net.NetConnection;
    import flash.net.Responder;    

    /**
     * @author user
     */
    public class MAController {
        var view : MAView;
        var model : MAModel;
        var nc : NetConnection;
        var responder : Responder;
        var timeStart : Date;
        var timeSystem : Date;
        var currentPhase : int;

        public function MAController(v : MAView) {
            view = v;
            model = MAView.model;
            nc = new NetConnection();
            //nc.connect("http://192.168.18.149:8000/service/game/");

            nc.connect("http://192.168.18.19:8000/service/game/");

            responder = new Responder(gotResult, gotError);
        }

        private function gotResult(result_value : Object) : void {
            //trace(resultValue);
            //trace(resultValue.player);
            //trace(resultValue.player.gold);
            var status_code : int = result_value["statuscode"];
            trace("0x0" + status_code.toString(16))
            //            for (var v in result_value.auctionlist) {
            //                trace(result_value.auctionlist[v].card)
            //            }
            switch(status_code) {
                // auction
                case MAConst.AUCTION_SUCCESS:
                    view.msgBox["txtMessage"].text = "拍卖提交成功";
                    view.msgBox.visible = true;
                    getCardList();
                    break;
                case MAConst.AUCTION_FAILED_INAUCTION:
                    view.msgBox["txtMessage"].text = "拍卖提交失败（正在拍卖中）";
                    view.msgBox.visible = true;
                    break;
//                case MAConst.AUCTION_ERROR:
                //                    view.msgBox["txtMessage"].text = "拍卖提交错误";
                //                    view.msgBox.visible = true;
                //                    break;
                    
                // bid
                case MAConst.BID_SUCCESS:
                    view.msgBox["txtMessage"].text = "竞价成功";
                    view.msgBox.visible = true;
                    getPlayerInfo(model.player.id);
                    
                    var card : BigCard = view.centerView.showPanel.card;
                    if (card && card["content"] is AuctionModel && card["content"].card.auction_type != 3) {
                        getAuction(card["content"].id);
                    }
                    break;
                case MAConst.BID_FAILED_PRICETOOLOW:
                    view.msgBox["txtMessage"].text = "竞价失败（出价太低）";
                    view.msgBox.visible = true;
                    break;
                case MAConst.BID_FAILED_HASBIDDED:
                    view.msgBox["txtMessage"].text = "竞价失败（已出价）";
                    view.msgBox.visible = true;
                    break;
                case MAConst.BID_FAILED_NOTENOUGHGOLD:
                    view.msgBox["txtMessage"].text = "竞价失败（金钱不足）";
                    view.msgBox.visible = true;
                    break;
//                case MAConst.BID_ERROR:
                //                    view.msgBox["txtMessage"].text = "竞价错误";
                //                    view.msgBox.visible = true;
                //                    break;
                    
                // enter
                case MAConst.ENTERAUCTIONCENTER_SUCCESS:
                    getPlayerInfo(model.player.id);
                    //view.centerView.listPanel.showTab();
                    view.centerView.showPanel.clearCard();
                    view.msgBox["txtMessage"].text = "进入拍卖行成功";
                    view.msgBox.visible = true;
                    break;
//                case MAConst.ENTERAUCTIONCENTER_ERROR:
                //                    view.msgBox["txtMessage"].text = "进入拍卖行错误";
                //                    view.msgBox.visible = true;
                //                    break;
                    
                // exit
                //                case MAConst.EXITAUCTIONCENTER_SUCCESS:
                //                    model.center = null;
                //                    getCenterList();
                //                    view.centerView.showPanel.clearCard();
                //                    view.centerView.rankPanel.clearPrices();
                //                    view.msgBox["txtMessage"].text = "离开拍卖行成功";
                //                    view.msgBox.visible = true;
                //                    break;
                case MAConst.ENTERAUCTIONCENTER_FAILED_INAUCTION:
                    view.msgBox["txtMessage"].text = "进入拍卖行失败（正在拍卖中）";
                    view.msgBox.visible = true;
                    break;
                case MAConst.ENTERAUCTIONCENTER_FAILED_FULL:
                    view.msgBox["txtMessage"].text = "进入拍卖行失败（人数已满）";
                    view.msgBox.visible = true;
                    break;
//                case MAConst.EXITAUCTIONCENTER_ERROR:
                //                    view.msgBox["txtMessage"].text = "离开拍卖行错误";
                //                    view.msgBox.visible = true;
                //                    break;
                
                // get    
                case MAConst.GETPLAYER_SUCCESS:
                    //if(!model.center) {
                    model.updatePlayer(result_value["player"]);
                    if (model.center) {
                        getCardList();
                        getCenter();
                    } else {
                        getCenterList();
                    }
                    //                    } else {
                    //                        model.updatePlayer(result_value["player"]);
                    //                    }
                    //                    view.centerView.infoPanel.setGold(model.player.gold);
                    //                    view.centerView.infoPanel.setExp(model.player.exp);
                    view.centerView.infoPanel.updateInfo();
                    break;

                case MAConst.GETAUCTIONCENTER_SUCCESS:
                    model.updatePrices(result_value["pricelist"]);
                    view.centerView.rankPanel.refreshPrices();
                    break;
                    
                case MAConst.GETAUCTIONCENTERLIST_SUCCESS:
                    //model.updatePrices(result_value["auctioncenterlist"]);
                    model.updateCenters(result_value["auctioncenterlist"]);
                    view.centerView.listPanel["listBack"].gotoAndStop("CENTER");
                    view.centerView.listPanel.showList(model.centers);
                    //view.centerView.listPanel.hideTab();
                    //trace(model.prices.length)
                    break;
                    
                case MAConst.GETCARDLIST_SUCCESS:
                    model.updateCards(result_value["card_list"]);
                    if (view.centerView.listPanel.listType == MAConst.LIST_CARDS) {
                        view.centerView.listPanel["listBack"].gotoAndStop("CARD");
                        view.centerView.listPanel.showList(model.cards);
                    }
                    else if(view.centerView.listPanel.listType == MAConst.LIST_BOUGHT) {
                        view.centerView.listPanel["listBack"].gotoAndStop("BOUGHT");
                        view.centerView.listPanel.showList(model.cards_bought);
                    }
                    //view.centerView.infoPanel.setGold(result_value.player.gold);
                    //view.centerView.infoPanel.setExp(result_value.player.exp);
                    break;
                    
                case MAConst.GETAUCTIONLIST_SUCCESS:
                    model.updateAuctions(result_value["auctionlist"]);
                    view.centerView.listPanel["listBack"].gotoAndStop("AUCTION");
                    view.centerView.listPanel.showList(model.auctions);
                    break;
                    
                case MAConst.GETBID_SUCCESS:
                    model.updateAuctions(result_value["auctionlist"]);
                    view.centerView.listPanel["listBack"].gotoAndStop("BID");
                    view.centerView.listPanel.showList(model.auctions);
                    break;
                    
                case MAConst.GETAUCTION_SUCCESS:
                    view.centerView.showPanel.updateAuctionInfo(result_value["auction"]);
                    break;
                    
                case MAConst.GETTIME_SUCCESS:
                    timeStart = new Date();
                    timeSystem = result_value["time"];
                    currentPhase = result_value["phase"];
                    break;
                    
                case MAConst.GETPLAYERLOG_SUCCESS:
                    model.updateLogs(result_value["loglist"]);
                    view.centerView.showLog();
                    break;
                    
                default:
                    view.msgBox["txtMessage"].text = "操作错误";
                    view.msgBox.visible = true;
                    break;
            }
        }

        
        
        private function gotError(evt : Object) : void {
            trace("Server error" + evt["description"]);
        }

        public function initGame() : void {
            //            MAModel.initCards();
            getSystemTime();
            
            
            
            var paramObj : Object = LoaderInfo(view.root.loaderInfo).parameters;
            
            
            
            if(paramObj["id"])
getPlayerInfo(paramObj["id"]);
else
getPlayerInfo(6);
        }

        public function onClickSmallCard(content : Object) : void {
            view.centerView.showPanel.showCard(content);
        }

        public function showBidBox() : void {
            view.centerView.showPanel.showInputBox();
        }

        public function showOfferBox() : void {
            view.centerView.showPanel.showOfferBox();
        }

        public function getPlayerInfo(id : int) : Boolean {
            nc.call("game.getPlayer", responder, id);
            return true;
        }

        public function getCenterList() : Boolean {
            nc.call("game.getAuctionCenterList", responder);
            return true;
        }

        public function getCenter() : Boolean {
            nc.call("game.getAuctionCenter", responder, model.center.id);
            return true;
        }

        public function getCardList() : Boolean {
            nc.call("game.getCardList", responder, model.player.id);
            return true;
        }

        public function auction(card_id : int,price : int = 0) : Boolean {
            nc.call("game.auction", responder, model.player.id, card_id, price);
            return true;
        }

        public function bid(auction_id : int,price : int = 0) : Boolean {
            nc.call("game.bid", responder, model.player.id, auction_id, price);
            return true;
        }

        public function enterAuctionCenter(center_id : int) : Boolean {
            nc.call("game.enterAuctionCenter", responder, model.player.id, center_id);
            return true;
        }

        public function exitAuctionCenter() : Boolean {
            nc.call("game.exitAuctionCenter", responder, model.player.id);
            return true;
        }

        public function getAuctionList() : Boolean {
            nc.call("game.getAuctionList", responder, model.center.id);
            return true;
        }

        public function getBidList() : Boolean {
            nc.call("game.getBid", responder, model.player.id);
            return true;
        }

        public function getAuction(id : int) : Boolean {
            nc.call("game.getAuction", responder, id);
            return true;
        }

        public function getPlayerLog() : Boolean {
            nc.call("game.getPlayerLog", responder, model.player.id);
            return true;
        }

        private function getSystemTime() : Boolean {
            nc.call("game.getSystemTime", responder);
            return true;
        }
    }
}
