package View.ViewComponent 
{
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
		
		private var fwd:Array = [];
		
		public var mouse:MouseTracker;
		
		[Inject]
		public var _primitvie:Visual_primitive;
		
		[Inject]
		public var _poker:Visual_poker;
		
		[Inject]
		public var _path:Path_Generator;
		
		public function Visual_testInterface() 
		{
			
		}
		
		public function init():void
		{			
			var playerCon:MultiObject = prepare(modelName.PLAYER_POKER, new MultiObject(), GetSingleItem("_view").parent.parent);
			playerCon.autoClean = true;
			playerCon.CleanList();
			//playerCon.CustomizedFun = pokerUtil.hidepoker;			
			playerCon.Create_by_list(3, ["pokerback"], 0 , 0, 3, 30, 0, "Bet_");
			
			var bankerCon:MultiObject =  prepare(modelName.BANKER_POKER, new MultiObject(), GetSingleItem("_view").parent.parent);
			bankerCon.autoClean = true;
			bankerCon.CleanList();
			//bankerCon.CustomizedFun = pokerUtil.hidepoker;
			bankerCon.Create_by_list(3, ["pokerback"], 0 , 0, 3, 30, 123, "Bet_");
			
			var btn:MultiObject = prepare("aa", new MultiObject() ,GetSingleItem("_view").parent.parent );			
			btn.MouseFrame = utilFun.Frametype(MouseBehavior.ClickBtn);			
			btn.stop_Propagation = true;
			btn.mousedown = test;			
			btn.mouseup = up;			
			btn.Create_by_list(4, ["betcomfirmbtn"], 0, 0, 4, 110, 0, "Btn_");
			
			_primitvie.init();
			_primitvie.recoderEvent = true;
			
			//point test
			//mouse = new MouseTracker();
			//add(mouse);
			//mouse.init();			
			//mouse.mousemove = _primitvie.g_point_mouse_down;
			//mouse.mouseup = _primitvie.g_point_mouse_up;
			
			//_primitvie.g_line =  mouse.graphics;
			_path.init();		
			
			_model.putValue(modelName.PLAYER_POKER,["1d"]);
			_model.putValue(modelName.BANKER_POKER,["2d","3d"]);
		}		
		
		public function test(e:Event, idx:int):Boolean
		{
			utilFun.Log("aa=" + idx);	
			
			if ( idx == 0) 
			{				
				//var path:Array = _model.getValue("pokerpath");
				//utilFun.Log("arr = " + path.length);
				//fwd.length = 0;
				//for (var i:int = 0; i < path.length; i++)
				//{
					//var arr:Array = path[i];
					//var obj:Object = { x: arr[0], y: arr[1] };
					//fwd.push (obj);               
					//
				//}
				//fwd.unshift (fwd [0]); 
				//fwd.push (fwd [fwd.length -1]);
				//
				//for (var i:int = 0; i < fwd.length; i++)
				//{
					//utilFun.Log("fwd x= "+i +" " + fwd[i].x);
					//utilFun.Log("fwd y= "+i+" " + fwd[i].y);
				//}
				//_poker.fwd.length = 0;
				//_poker.fwd = fwd.concat(); 
				_model.putValue(modelName.PLAYER_POKER,["1d","2d"]);
            }
			  else if (idx == 1)
			  {
				  _model.putValue(modelName.PLAYER_POKER,["1d","2d","3d"]);
				  
			  }
			   else if (idx == 2)
			  {
				dispatcher(new Intobject(modelName.PLAYER_POKER, "pokerupdate"));
				dispatcher(new Intobject(modelName.BANKER_POKER, "pokerupdate"));
				  
			  }
            else if (idx == 3)
			{
				_poker.playerpokerani();
			}
				
			
			
			
			return true;
		}			
		
		[MessageHandler(type="Model.valueObject.ArrayObject",selector="recode_path")]
		public function paht_update(arrob:ArrayObject):void
		{			
			_model.getValue("pokerpath").push(arrob.Value);			
		}
		
		public function up(e:Event, idx:int):Boolean
		{			
			return true;
		}	
		
	}

}