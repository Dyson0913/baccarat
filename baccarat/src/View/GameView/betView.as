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
	import util.math.Path_Generator;
	import util.node;
	import View.Viewutil.*;
	import View.ViewBase.ViewBase;
	import util.*;
	import View.ViewComponent.*;
	
	import Command.*;
	
	import caurina.transitions.Tweener;
	
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
		public var _poker:Visual_poker;
		
		[Inject]
		public var _timer:Visual_timer;
		
		[Inject]
		public var _hint:Visual_Hintmsg;
		
		[Inject]
		public var _betzone:Visual_betZone;
		
		[Inject]
		public var _coin:Visual_Coin;
		
		[Inject]
		public var _settle:Visual_Settle;
		
		[Inject]
		public var _path:Path_Generator;
		
		private var _mainroad:MultiObject = new MultiObject();
				
		public var _mainTable:LinkList = new LinkList();
		public var _bigroadTable:LinkList = new LinkList();
				
		
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
			
			_path.init();
			
			_poker.init();
			_settle.init();
			
			//var info:MultiObject = prepare(modelName.CREDIT, new MultiObject() , this);
			//info.container.x = 11.3;
			//info.container.y = 910.5;
			//info.Create_by_list(1, [ResName.playerInfo], 0, 0, 1, 0, 0, "info_");			
			//utilFun.SetText(info.ItemList[0]["_Account"], _model.getValue(modelName.UUID) );
			//utilFun.SetText(info.ItemList[0]["nickname"], _model.getValue(modelName.NICKNAME) );			
			//utilFun.SetText(info.ItemList[0]["credit"], _model.getValue(modelName.CREDIT).toString());
			
			_timer.init();		
			_hint.init();			
			_betzone.init();
			_coin.init();
		
			
			//_tool.SetControlMc(coinstack.ItemList[0]);
			//addChild(_tool);		
			
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
		
		
		
		[MessageHandler(type = "Model.valueObject.Intobject",selector="LeaveView")]
		override public function ExitView(View:Intobject):void
		{
			if (View.Value != modelName.Bet) return;
			super.ExitView(View);
		}		
	}

}