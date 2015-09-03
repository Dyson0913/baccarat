package View.GameView
{	
	import com.adobe.utils.DictionaryUtil;
	import Command.BetCommand;
	import Command.RegularSetting;
	import Command.ViewCommand;
	import ConnectModule.websocket.WebSoketInternalMsg;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;	
	import flash.text.TextField;
	import Model.valueObject.Intobject;
	import Res.ResName;
	import util.DI;
	import util.node;
	import View.ViewBase.ViewBase;
	import Command.DataOperation;
	import flash.text.TextFormat;
	import View.ViewComponent.*;
	import View.Viewutil.*;
	
	import Model.*;
	import util.utilFun;
	import caurina.transitions.Tweener;	
	
	/**
	 * ...
	 * @author hhg
	 */

	 
	public class LoadingView extends ViewBase
	{	
		private var _mainroad:MultiObject = new MultiObject();
		private var _localDI:DI = new DI();
		
		public var _mainTable:LinkList = new LinkList();
		public var _bigroadTable:LinkList = new LinkList();        
		
		[Inject]
		public var _regular:RegularSetting;	
		
		[Inject]
		public var _visual_test:Visual_testInterface;
		
		
		
		public function LoadingView()  
		{
			
		}
		
			//result:Object
		public function FirstLoad(para:Array ):void
 		{			
			_model.putValue(modelName.LOGIN_INFO, para[0]);
			_model.putValue(modelName.CREDIT, para[1]);
			_model.putValue(modelName.Client_ID, para[2]);
			_model.putValue(modelName.HandShake_chanel, para[3]);
			dispatcher(new Intobject(modelName.Loading, ViewCommand.SWITCH));			
		}
		
		[MessageHandler(type="Model.valueObject.Intobject",selector="EnterView")]
		override public function EnterView (View:Intobject):void
		{
			if (View.Value != modelName.Loading) return;
			super.EnterView(View);
			var view:MultiObject = prepare("_view", new MultiObject() , this);
			view.Create_by_list(1, [ResName.Bet_Scene], 0, 0, 1, 0, 0, "a_");			
			_tool = new AdjustTool();
			//paitest()
			//testroad();		
			
			
			//_regular.strdotloop(view.ItemList[0]["_Text"],20,40);			
			//utilFun.SetTime(connet, 2);
			//
			_visual_test.init();
		}
		
		public function testroad():void
		{
			//main road			
			_model.putValue("Position",  [7, 43, 79, 115, 151, 187]);
			
			//big eye road  (put to big road to judge)
			_model.putValue("add_to_same_col", false);
			
			_model.putValue("bigeyestart_col_cunt", 0);
			_model.putValue("bigeyestart_col_row", 0);
			_model.putValue("bigeyestart_start", false);
			_model.putValue("bigeyes_over_two", 0);
			
			_model.putValue("Result",  1);		
			//var maintableCon:MovieClip = utilFun.prepare("maintablecon",  utilFun.GetClassByString("Emptymc") , _localDI, this);
			//for (var i = 0; i < 13; i ++ )
			//{			
				//var mc:MovieClip = utilFun.GetClassByString("mainTable");
				//mc.x = i * 36;
				//var nod:node = new node();
				//nod.data.putValue("current_idx", 0);
				//
				//big road
				//nod.data.putValue("last_idx", 6);
				//nod.data.putValue("result_row", [ -1, -1, -1, -1, -1, -1]);
				//
				//nod.create(mc, maintableCon);
				//
				//if ( i == 0) 
				//{
					//_mainTable.setroot(nod);
				//}
			    //else
				//{
					//_mainTable.addtail(nod);
				//}
			//}
			_mainTable.set_next_empty_Start();
		
			//var bigroadtableCon:MovieClip = utilFun.prepare("bigroadtablecon",  utilFun.GetClassByString("Emptymc") , _localDI, this);
			//utilFun.scaleXY(bigroadtableCon, 0.5, 0.5);
			//bigroadtableCon.x = 468;
			
			//for (var i = 0; i < 30; i ++ )
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
			//big road
			//_model.putValue("PreResult",  -1);
			//_model.putValue("currntResult",  -1);
			//
			//
			//測試按鈕
			//var maintableCon:MovieClip = utilFun.GetClassByString("MyText");			
			//but.CustomizedFun = TableInfoDisplay;
			//but.CustomizedData =["pop","push","mainR","Broad","banker","player","tie","bigeye"];						
			//but.MouseFrame = utilFun.Frametype(MouseBehavior.ClickBtn);
			//but.Create(but.CustomizedData.length, "OrderBtn", 180.8, 271, 1,100, 50, "Table_", Get("_view"));
			//but.mousedown = choseroom
			//
			//_too.x = 100;
			//_too.SetControlMc(bigroadtableCon);
			//addChild(_too);
			
			
		}
		
		public function TableInfoDisplay(mc:MovieClip, idx:int, data:Array):void
		{
			utilFun.SetText(mc["_Text"], data[idx] );			
		}
		
		private function choseroom(e:Event, idx:int):Boolean 
		{
			if ( idx == 0)
			{
				//一開始pop 再放珠子,有問題
				_mainTable.head.pass(_mainTable.head);
				_mainTable.removehead();
			}
			else  if (idx ==1)
			{
				var mc:MovieClip = utilFun.GetClassByString("mainTable");
				var tail:node = _mainTable.tail;
				mc.x = tail.Item.x + 36 ;
				//utilFun.Log("tail.Item.width" + tail.Item.width);
				var nod:node = new node();
				nod.create(mc, Get("maintablecon"));
				_mainTable.addtail(nod);
			}
			else if ( idx == 2)
			{
				//主路單 
				var rand_result:int = utilFun.Random(3) + 1;
				_model.putValue("Result",  rand_result);
				var idx:int = _mainTable.current.data.getValue("current_idx");				
				add(rand_result, _model.getValue("Position")[idx] , _mainTable.current.Item);
				idx  =  (idx +1 ) % 6;
				if ( idx == 0) 
				{					
					_mainTable.Next();
				}
				_mainTable.current.data.putValue("current_idx",idx);
				
				bigroad();
			}
			else if ( idx == 3)
			{
				bigroad();
			}
			else if ( idx == 4)
			{
			   _model.putValue("Result",  1);
			}
			else if ( idx == 5)
			{
			   _model.putValue("Result",  2);
			}
			else if ( idx == 6)
			{
			   _model.putValue("Result",  3);
			}
			else if ( idx == 7)
			{
				bigeyeroad();
			}
			
			return true;
		}
		
		public function big_eye_road_check():int
		{
			
			
			//前二行,(沒二行不用檢查) 不整濟->藍, 整濟->紅 (合不包含)					
			//沒有第前二行 _mainTable.nextStart.pre = 目前這一行
			var idx:int = _mainTable.current.data.getValue("current_idx");
			var first_cnt:int = 0;
			//換新行才檢查
			if (idx == 0)
			{
				if ( _mainTable.nextStart.pre.pre.pre != null)
				{
					//utilFun.Log("count Cnt");				
					utilFun.Log("firstdata list " + _mainTable.nextStart.pre.pre.data.getValue("result_row"));				
					//var first_cnt:int = type_count(  _mainTable.nextStart.pre.pre.data.getValue("result_row") );
									
					utilFun.Log("data list " + _mainTable.nextStart.pre.pre.pre.data.getValue("result_row"));
					var second_cnt:int = type_count(  _mainTable.nextStart.pre.pre.pre.data.getValue("result_row"));
					utilFun.Log("first_cnt " + first_cnt);
					utilFun.Log("second_cnt " + second_cnt);
					
					if ( first_cnt == second_cnt) return 1;
					else return 2;
				}			
			}
			
			
			//前一行有無結果 ->有畫紅, 無藍
			//var idx:int = _mainTable.current.data.getValue("current_idx");
			var data:Array = _mainTable.current.pre.data.getValue("result_row")
			
			if ( data[idx] != -1)
			{
				//some bug to fix
				utilFun.Log("normal  read" );
				return 1;
			}
			else 
			{
				//超過二個(以上)都紅 (有部份待確認,沒有一直跑over 2
				//_opration.operator("bigeyes_over_two", DataOperation.add, 1);
				if ( _model.getValue("bigeyes_over_two") >= 2) 
				{
					utilFun.Log("over 2 read" );					
					return 1;
				}
				else 
				{
					return 2;
				}
			}
			
		}
		
		public function type_count(data:Array):int
		{			
			var this_row_type:int = data[0];
			var Cnt:int = 0;
			for (var i:int = 0; i < data.length; i++)
			{
				if ( data[i] == this_row_type)
				{
					Cnt++;
				}
			}
			
			return Cnt;
		}
		
		public function add(balltype:int,y:int,contain:MovieClip):void
		{
			var ball:MovieClip = utilFun.GetClassByString("mainball");
			//var ball:MovieClip = utilFun.GetClassByString("bigRoadBall");
			ball.x = 17;
			ball.y = y;
			ball.gotoAndStop(balltype);
			contain.addChild(ball)			
		}
		
		public function bigroad():void
		{
			var result:int = _model.getValue("Result");
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
					
					
					add(result, _model.getValue("Position")[idx] , _bigroadTable.current.Item);
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
				
				//		
				utilFun.Log("row state " + _bigroadTable.current.data.getValue("result_row"));
		}
		
		public function bigeyeroad():void
		{
			 var result:int = _model.getValue("Result");
			   
			   //放置方式一樣,由大路計算出下一步要放那一種
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
							_mainTable.Next_empty();
							_mainTable.current.data.putValue("current_idx", 0);
							_model.putValue("add_to_same_col", false);
							
							//_opration.operator("bigeyestart_col_cunt", DataOperation.add, 1);
							_model.putValue("bigeyestart_col_row", 0);
							_model.putValue("bigeyes_over_two", 0);
							
						}						
					}					
				}
				
				var idx:int = _mainTable.current.data.getValue("current_idx");				
				if ( _mainTable.current.data.getValue("result_row")[idx] == -1)
				{				
					//檢查前一列和前一格結果 (第一格不用檢查)
					if ( _mainTable.current.pre != null)
					{
						if ( idx !=0 )
						{					  
						   var pre_resutl:int = _mainTable.current.pre.data.getValue("result_row")[idx];
						    if ( _mainTable.current.data.getValue("result_row")[idx - 1] == pre_resutl && pre_resutl != 3) 
							{
								_mainTable.Next();
								_model.putValue("add_to_same_col", true);
								idx -=1;
							}
					   }
					  
					}
					
					
					// 前後二格是一樣的 (第五格不用檢查)
					if ( idx != 5 )
					{
						var up_result:int = _mainTable.current.data.getValue("result_row")[idx - 1] ;
						if ( up_result != -1 ) 
						{ 
							if (up_result == _mainTable.current.data.getValue("result_row")[idx + 1] )
							{
								_mainTable.Next();
								_model.putValue("add_to_same_col", true);
								idx -= 1;
							}
						}
					}
					
					
					if ( _model.getValue("add_to_same_col") )
					{
						var totoallist:Array = _mainTable.nextStart.pre.data.getValue("result_row");
						totoallist.push(result);
						_mainTable.nextStart.pre.data.putValue("result_row", totoallist);
					}
					
					add(result, _model.getValue("Position")[idx] , _mainTable.current.Item);
				    _mainTable.current.data.getValue("result_row")[idx] = result;
					
					
					if (  (_model.getValue("bigeyestart_col_cunt") == 1 && _model.getValue("bigeyestart_col_row") == 1) ||
					       (_model.getValue("bigeyestart_col_cunt") == 2 && _model.getValue("bigeyestart_col_row") == 0)  )
					{							
						if ( _model.getValue("bigeyestart_start") == false) _model.putValue("bigeyestart_start", true);
					}
					
					if (  _model.getValue("bigeyestart_start") )
					{
						//和不產生
						if( result != 3) 
						{
							var big_eye:int = big_eye_road_check();
							utilFun.Log("big_eye ="+ big_eye);
						}
						
					}
					
					//_opration.operator("bigeyestart_col_row", DataOperation.add, 1);
					
					idx += 1;
					
					//1.到底 
					//2下一格不是-1,己經有放東西
					if ( idx == 6)
					{
						_mainTable.Next();
						idx = 5;
						_model.putValue("add_to_same_col", true);
					}
					else if ( _mainTable.current.data.getValue("result_row")[idx] != -1) 
					{
					  	_mainTable.Next();
						idx -= 1;
						_model.putValue("add_to_same_col", true);
					}
					
					_mainTable.current.data.putValue("current_idx", idx );
				}
		}
		
		private function connet():void
		{	
			dispatcher( new WebSoketInternalMsg(WebSoketInternalMsg.CONNECT));
		}
		
		[MessageHandler(type = "Model.valueObject.Intobject",selector="LeaveView")]
		override public function ExitView(View:Intobject):void
		{
			if (View.Value != modelName.Loading) return;
			super.ExitView(View);
			utilFun.Log("LoadingView ExitView");
		}
		
		
	}

}