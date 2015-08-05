package View.GameView
{
	import ConnectModule.websocket.WebSoketInternalMsg;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import Model.valueObject.*
	import Res.ResName;
	import util.DI;
	import Model.*
	import util.node;
	import View.Viewutil.*;
	import View.ViewBase.ViewBase;
	import util.*;
	import View.ViewComponent.Visual_Coin;
	
	import Command.*;
	
	import caurina.transitions.Tweener;	
	import caurina.transitions.properties.CurveModifiers;
	/**
	 * ...
	 * @author hhg
	 */
	public class betView extends ViewBase
	{
		[Inject]
		public var _betCommand:BetCommand;
		
		[Inject]
		public var _regular:RegularSetting;	
		
		[Inject]
		public var _visual_coin:Visual_Coin;
		
		private var _mainroad:MultiObject = new MultiObject();
				
		public var _mainTable:LinkList = new LinkList();
		public var _bigroadTable:LinkList = new LinkList();
		
		//private var fwd:Array = [];
		private var dynamicpoker:Array = [];
		
		public function betView()  
		{
			utilFun.Log("betView");
		}
		
		[MessageHandler(type="Model.valueObject.Intobject",selector="EnterView")]
		override public function EnterView (View:Intobject):void
		{
			if (View.Value != modelName.Bet) return;
			super.EnterView(View);
			//清除前一畫面
			utilFun.Log("in to EnterBetview=");			
			
			_tool = new AdjustTool();
			_betCommand.bet_init();
			
			var view:MultiObject = prepare("_view", new MultiObject() , this);
			view.Create_by_list(1, [ResName.Bet_Scene], 0, 0, 1, 0, 0, "a_");	
			
			var playerCon:MultiObject = prepare(modelName.PLAYER_POKER, new MultiObject(), this);
			playerCon.autoClean = true;
			playerCon.container.x = 700;
			playerCon.container.y = 200;
			
			var bankerCon:MultiObject =  prepare(modelName.BANKER_POKER, new MultiObject(), this);
			bankerCon.autoClean = true;
			bankerCon.container.x = 1010;
			bankerCon.container.y = 200;
			
			var zoneCon:MultiObject = prepare("zone", new MultiObject(), this);
			zoneCon.Create_by_list(2, [ResName.bankerScore, ResName.playerScore], 0 , 0, 2, -770, 0, "Bet_");
			zoneCon.container.visible = false;
			zoneCon.container.x = 1290;
			zoneCon.container.y = 150;

			//var info:MultiObject = prepare(modelName.CREDIT, new MultiObject() , this);
			//info.container.x = 11.3;
			//info.container.y = 910.5;
			//info.Create_by_list(1, [ResName.playerInfo], 0, 0, 1, 0, 0, "info_");			
			//utilFun.SetText(info.ItemList[0]["_Account"], _model.getValue(modelName.UUID) );
			//utilFun.SetText(info.ItemList[0]["nickname"], _model.getValue(modelName.NICKNAME) );			
			//utilFun.SetText(info.ItemList[0]["credit"], _model.getValue(modelName.CREDIT).toString());
			
			var countDown:MultiObject = prepare(modelName.REMAIN_TIME,new MultiObject()  , this);
		   countDown.Create_by_list(1, [ResName.Timer], 0, 0, 1, 0, 0, "time_");
		   countDown.container.x = 350;
		   countDown.container.y = 280;
		   countDown.container.visible = false;
		   
			var hintmsg:MultiObject = prepare(modelName.HINT_MSG, new MultiObject()  , this);
			hintmsg.Create_by_list(1, [ResName.Hint], 0, 0, 1, 0, 0, "time_");
			hintmsg.container.x = 627.3;			
			hintmsg.container.y = 459.3;			
			
			
			//bet區容器
			//coin
			var coinob:MultiObject = prepare("CoinOb", new MultiObject(), this);
			coinob.container.x = 640;
			coinob.container.y = 800;
			coinob.MouseFrame = utilFun.Frametype(MouseBehavior.Customized,[0,0,3,0]);
			coinob.CustomizedFun = _regular.FrameSetting;
			coinob.CustomizedData = [3, 2, 2, 2, 2];
			coinob.Posi_CustzmiedFun = _regular.Posi_y_Setting;
			coinob.Post_CustomizedData = [0,10,20,10,0];
			coinob.Create_by_list(5,  [ResName.coin1,ResName.coin2,ResName.coin3,ResName.coin4,ResName.coin5], 0 , 0, 5, 130, 0, "Coin_");
			coinob.mousedown = _visual_coin.betSelect;			
			
			var betzone:Array = _model.getValue(modelName.BET_ZONE);
			var allzone:Array = [ResName.betzone_banker, ResName.betzone_player, ResName.betzone_tie, ResName.betzone_banker_pair, ResName.betzone_player_pari];
			var avaliblezone:Array = [];
			for each (var i:int in betzone)
			{
				avaliblezone.push ( allzone[i - 1]);
			}
			
			//stick cotainer  
			var coinstack:MultiObject = prepare("coinstakeZone", new MultiObject(), this);	
			coinstack.container.x = 196;
			coinstack.container.y = 502;
			coinstack.Posi_CustzmiedFun = _regular.Posi_xy_Setting;
			coinstack.Post_CustomizedData = [[830,200],[180,100],[615,57]];
			coinstack.Create_by_list(avaliblezone.length, [ResName.emptymc], 0, 0, avaliblezone.length, 0, 0, "time_");
			
			//下注區容器
			var playerzone:MultiObject = prepare("betzone", new MultiObject() , this);
			playerzone.MouseFrame = utilFun.Frametype(MouseBehavior.Customized,[0,0,3,1]); //1 ,2,3,2
			playerzone.container.x = 196;
			playerzone.container.y = 502;
			playerzone.Posi_CustzmiedFun = _regular.Posi_xy_Setting;
			playerzone.Post_CustomizedData = [[760,0],[0,0],[575,-33]];
			playerzone.Create_by_list(avaliblezone.length, avaliblezone, 0, 0, avaliblezone.length, 0, 0, "time_");
			
			
			
			//_tool.SetControlMc(coinstack.ItemList[0]);
			//addChild(_tool);
			
			
			CurveModifiers.init();
			
			//_tool.SetControlMc(hintmsg);
			//addChild(_tool);
			return
			
			var maintableCon:MovieClip = prepare("maintablecon",  utilFun.GetClassByString("Emptymc") , this);
			maintableCon.y = 864;
			_model.putValue("Position",  [7, 43, 79, 115, 151, 187]);
			for (i = 0; i < 13; i ++ )
			{			
				var mc:MovieClip = utilFun.GetClassByString("mainTable");
				mc.x = i * 36;
				var nod:node = new node();
				nod.data.putValue("current_idx", 0);
				nod.create(mc, maintableCon);
				
				if ( i == 0) 
				{
					_mainTable.setroot(nod);
				}
			    else
				{
					_mainTable.addtail(nod);
				}
			}
			
			//var bigroadtableCon:MovieClip = prepare("bigroadtablecon",  utilFun.GetClassByString("Emptymc") , this);
			//utilFun.scaleXY(bigroadtableCon, 0.5, 0.5);
			//bigroadtableCon.x = 468;
			//bigroadtableCon.y = 864;
			//for (var i = 0; i < 13; i ++ )
			//{			
				//var mc:MovieClip = utilFun.GetClassByString("mainTable");
				//mc.x = i * 36;
				//var nod:node = new node();
				//nod.data.putValue("current_idx", 0);
				//nod.data.putValue("last_idx", 6);
				//nod.data.putValue("result_row",[-1,-1,-1,-1,-1,-1]);
				//nod.create(mc, bigroadtableCon);
				//
				//if ( i == 0) 
				//{
					//_bigroadTable.setroot(nod);
				//}
			    //else
				//{
					//_bigroadTable.addtail(nod);
				//}
			//}
			//_bigroadTable.set_next_empty_Start();
			//_model.putValue("PreResult",  -1);
			//_model.putValue("currntResult",  -1);
			//
		}
		
		
		
		
		
	   
		[MessageHandler(type = "Model.ModelEvent", selector = "round_result")]
		public function round_result():void
		{
			var a:String = _model.getValue(modelName.ROUND_RESULT);
			var syblist:Array =  _model.getValue(modelName.SPLIT_SYMBOL)
			var result:Array = a.split(syblist[0]);
			result.pop();
			
			//TODO get from server
			var clean:Array = [1, 2, 3, 4, 5, 6];
			for ( var i:int = 0; i < result.length ; i++)
			{
				var resultinfo:Array = result[i].split(syblist[1]);
				var zone:int = parseInt( resultinfo[0]);
				var odds:int = parseInt(resultinfo[1]);
				utilFun.Log("zone = " + zone);
				utilFun.Log("odds = " + odds);
				
				if ( clean.indexOf(zone) != -1)
				{
					clean.splice(clean.indexOf(zone), 1);
				}
				//zone handle
				//pa 5 = 0
				if ( odds != 5)
				{
					_regular.Twinkle(GetSingleItem("betzone", zone-1), 3, 10, 2);	
				}
				else
				{
					utilFun.Clear_ItemChildren(GetSingleItem("coinstakeZone", zone-1));
				}
				
			
			}
			
			//hint			
			Get("zone").container.visible = true;
			GetSingleItem("zone", 0).visible = true;
			var point:Array = utilFun.arrFormat(countPoint(_model.getValue(modelName.BANKER_POKER)), 2);
			if ( point[0] == 0 ) point[0] = 10;
			if ( point[1] == 0 ) point[1] = 10;			
			GetSingleItem("zone")["_num0"].gotoAndStop(point[0]);
			GetSingleItem("zone")["_num1"].gotoAndStop(point[1]);
			
			GetSingleItem("zone", 1).visible = true;
			point = utilFun.arrFormat(countPoint(_model.getValue(modelName.PLAYER_POKER)), 2);
			if ( point[0] == 0 ) point[0] = 10;
			if ( point[1] == 0 ) point[1] = 10;
			GetSingleItem("zone", 1)["_num0"].gotoAndStop(point[0]);
			GetSingleItem("zone", 1)["_num1"].gotoAndStop(point[1]);
			
			utilFun.Log("clean =" + clean);
			for ( i = 0; i < clean.length ; i++)
			{
				utilFun.Clear_ItemChildren(GetSingleItem("coinstakeZone", clean[i]-1));
			}
			
			
			//主路單更新
			//var idx:int = _mainTable.current.data.getValue("current_idx");				
			//addBall(betresult,_model.getValue("Position")[idx] , _mainTable.current.Item,"mainball");
			//idx = (idx + 1) % 6;
			//if ( idx == 0) 
			//{
				//_mainTable.Next();
			//}
			//_mainTable.current.data.putValue("current_idx",idx);
			//
			//大路單更新
			//bigRoadupdate();		
									
		}
		
		public function addBall(balltype:int,y:int,contain:MovieClip,objectName:String):void
		{
			var ball:MovieClip = utilFun.GetClassByString(objectName);
			ball.x = 17;
			ball.y = y;			
			ball.gotoAndStop(balltype);
			contain.addChild(ball)			
		}	
		
		public function bigRoadupdate():void
		{
			var result:int = _model.getValue(modelName.ROUND_RESULT);			
			if ( result != CardType.Tie )
			{					
				_model.putValue("PreResult",   _model.getValue("currntResult"));		
				_model.putValue("currntResult",  result);
				
				//與上次不同
			    if (  _model.getValue("PreResult") != -1 )					
				{
					if ( _model.getValue("PreResult") !=  _model.getValue("currntResult") )
					{
						//未超過的換行
						_bigroadTable.Next_empty();
						_bigroadTable.current.data.putValue("current_idx",0);
					}						
				}					
			}
				
				var idx:int = _bigroadTable.current.data.getValue("current_idx");				
				if ( _bigroadTable.current.data.getValue("result_row")[idx] == -1)
				{
				
					//檢查前一列和前一格結果 (第一格不用檢查)
					if ( _bigroadTable.current.pre != null)
					{
						if ( idx !=0 )
						{					  
						   var pre_resutl:int = _bigroadTable.current.pre.data.getValue("result_row")[idx];
						    if ( _bigroadTable.current.data.getValue("result_row")[idx - 1] == pre_resutl && pre_resutl != 3) 
							{
								_bigroadTable.Next();
								idx -=1;
							}
					   }
					  
					}
					
					
					// 前後二格是一樣的 (第五格不用檢查)
					if ( idx != 5 )
					{
						var up_result:int = _bigroadTable.current.data.getValue("result_row")[idx - 1] ;
						if ( up_result != -1 ) 
						{ 
							if (up_result == _bigroadTable.current.data.getValue("result_row")[idx + 1] )
							{
								_bigroadTable.Next();
								idx -= 1;
							}
						}
					}
					
					
					addBall(result, _model.getValue("Position")[idx] , _bigroadTable.current.Item,"bigRoadBall");
				   _bigroadTable.current.data.getValue("result_row")[idx] = result;
					
					idx += 1;
					
					//1.到底 
					//2下一格不是-1,己經有放東西
					if ( idx == 6)
					{
						_bigroadTable.Next();
						idx = 5;
					}
					else if ( _bigroadTable.current.data.getValue("result_row")[idx] != -1) 
					{
					  	_bigroadTable.Next();
						idx -=1;
					}
					
					_bigroadTable.current.data.putValue("current_idx", idx );
				}
		}
		
		private function countPoint(poke:Array):int
		{
			var total:int = 0;
			for (var i:int = 0; i < poke.length ; i++)
			{
				var strin:String =  poke[i];
				var arr:Array = strin.match((/(\w|d)+(\w)+/));					
				var numb:String = arr[1];				
				
				var point:int = 0;
				if ( numb == "i" || numb == "j" || numb == "q" || numb == "k" ) 				
				{
					point = 10;
				}				
				else 	point = parseInt(numb);
				
				total += point;
			}	
			
			return total %= 10;
		}
			
		
		
		private function clearn():void
		{			
			dispatcher(new ModelEvent("clearn"));			
		  
		
				
			//dispatcher(new BoolObject(false, "Msgqueue"));
		}
		
		[MessageHandler(type = "Model.valueObject.Intobject",selector="LeaveView")]
		override public function ExitView(View:Intobject):void
		{
			if (View.Value != modelName.Bet) return;
			super.ExitView(View);
		}		
	}

}