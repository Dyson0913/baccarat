package View.ViewComponent 
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import util.math.Path_Generator;
	import View.ViewBase.VisualHandler;
	import Model.valueObject.*;
	import Model.*;
	import util.*;
	import Command.*;
	import View.Viewutil.*;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import View.GameView.*;
	import Res.ResName;
	import caurina.transitions.Tweener;
	import flash.events.MouseEvent;
	
	
	/**
	 * testinterface to fun quick test
	 * @author ...
	 */
	public class Visual_testInterface  extends VisualHandler
	{
		public var mouse:MouseTracker;
		
		[Inject]
		public var _primitvie:Visual_primitive;	
		
		[Inject]
		public var _path:Path_Generator;
		
		public function Visual_testInterface() 
		{
			
		}
		
		public function init():void
		{
			
			var btn:MultiObject = prepare("aa", new MultiObject() ,GetSingleItem("_view").parent.parent );			
			btn.MouseFrame = utilFun.Frametype(MouseBehavior.ClickBtn);			
			btn.stop_Propagation = true;
			btn.mousedown = test;			
			btn.mouseup = up;			
			btn.Create_by_list(4, ["betcomfirmbtn"], 0, 0, 4, 110, 0, "Btn_");
			
		
			
			//point test
			mouse = new MouseTracker();
			add(mouse);
			mouse.init();			
			mouse.mousemove = _primitvie.g_point_mouse_down;
			mouse.mouseup = _primitvie.g_point_mouse_up;
			
			_primitvie.init();
			_primitvie.recoderEvent = true;
			
			//_primitvie.g_line =  mouse.graphics;
			_path.init();		
			
		
		}		
		
		public function getCoin():void
		{
			_model.putValue("coin_list", [100, 500, 1000, 5000, 10000]);
			
			//先收再吐
			
			
			var betzone:Array = [0, 1, 2, 3, 4, 5];// , 6, 7, 8];
			var betzone_name:Array = ["BetPAEvil", "BetPAAngel", "BetPABigEvil", "BetPABigAngel", "BetPAUnbeatenEvil", "BetPAPerfectAngel"];// , 6, 7, 8];
			
		    var bet_name_to_idx:DI = new DI();
			var bet_idx_to_name:DI = new DI();
			for ( var i:int = 0; i < betzone.length ; i++)
			{
				bet_name_to_idx.putValue(betzone_name[i], i);
				bet_idx_to_name.putValue(i, betzone_name[i]);
			}		  
			
			_model.putValue("Bet_name_to_idx", bet_name_to_idx);		
			_model.putValue("Bet_idx_to_name", bet_idx_to_name);
			
			var clean:Array = [ 0, 1, 2, 3, 4, 5, 6];
			//TODO rever zone
			
			//  get zone coin by clean[i]
			var one_zone_coin:Array = [100, 100, 100, 200, 500, 1000];
			
			var name_to_idx:DI = _model.getValue("Bet_name_to_idx");
			var idx_to_name:DI = _model.getValue("Bet_idx_to_name");
			
			var str:String =  idx_to_name[0];
			var path:Object = { "BetPAEvil":[[1427, 889], [962.4, 457]],
											"BetPAAngel":[[504, 857], [959,393]],
											"BetPABigEvil": [[1316, 759], [966,409]],
											"BetPABigAngel":[[574, 762], [954,398]],
											"BetPAUnbeatenEvil":[[1169, 795], [952, 396]],
											"BetPAPerfectAngel":[[780, 777], [954, 397]]
			};			
										
			_model.putValue("coin_path ",path);		
									
			
			
			
			
		}
		
		public function test(e:Event, idx:int):Boolean
		{
			utilFun.Log("aa=" + idx);	
			
			if ( idx == 0) 
			{				
				var path:Array = _path.get_recoder_path();
				var coin:MovieClip = utilFun.GetClassByString("Bet_coin");
				
				add(coin);
				follew_path(coin, path);
            }
			  else if (idx == 1)
			  {
				_model.putValue("path",[]);
				  
			  }
			   else if (idx == 2)
			  {
				
			  }
            else if (idx == 3)
			{				
				
			}
				
			
			
			
			return true;
		}			
		
		
		//sock in coin
		public function follew_path(mc:DisplayObjectContainer, path):void
		{
			mc.x = path[0].x;
				mc.y = path[0].y;
				Tweener.addTween(mc, {
					x:path [path.length -1].x,
					y:path [path.length -1].y,
			       _bezier:_path.makeBesierArray(path),
			time:1, transition:"easeInOutQuad",onComplete:ok, onCompleteParams:[mc,GetSingleItem("_view").parent.parent]});				
		}
		
		public function ok(mc:DisplayObjectContainer,contain:Sprite):void
		{
			contain.removeChild(mc);		
		}
		
		public function up(e:Event, idx:int):Boolean
		{			
			return true;
		}	
		
	}

}