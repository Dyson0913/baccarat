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
		
		public function test(e:Event, idx:int):Boolean
		{
			utilFun.Log("aa=" + idx);	
			
			if ( idx == 0) 
			{				
				var path:Array = _path.get_recoder_path();
				var coin:MovieClip = new coin_1;
				add(coin);
				follew_path(coin, path);
            }
			  else if (idx == 1)
			  {
				
				  
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