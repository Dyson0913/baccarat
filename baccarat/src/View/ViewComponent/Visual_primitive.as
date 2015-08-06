package View.ViewComponent 
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import View.ViewBase.VisualHandler;
	import Model.valueObject.*;
	import Model.*;
	import util.*;
	import Command.*;
	
	import View.Viewutil.MultiObject;
	import Res.ResName;
	import caurina.transitions.Tweener;
	
	/**
	 * primitive present way
	 * @author ...
	 */
	public class Visual_primitive  extends VisualHandler
	{	
		public var recoderEvent:Boolean = false;
		
		public var spr:Sprite;
		private var g_temp:Graphics;
		
		//line
		public var g_line:Graphics;
		
		
		public function Visual_primitive() 
		{
			
		}
		
		public function init():void
		{			
			spr = new Sprite();
			add(spr);
			g_temp = spr.graphics;
		}
		
		/**
		 * draw line
		 * @param	oldx
		 * @param	oldy
		 * @param	Newx
		 * @param	newy
		 */
		public function g_line_mouse_move(e:Event,oldx:Number,oldy:Number,newx:Number,newy:Number):void
		{
			g_temp.clear();
			g_temp.lineStyle (0, 0xdd2222, 1);
			
			g_temp.moveTo (oldx, oldy);
			g_temp.lineTo (newx, newy);
		}
		
		public function g_line_mouse_up(e:Event,oldx:Number,oldy:Number,newx:Number,newy:Number):void
		{
			g_temp.clear();
			g_line.lineStyle (0, 0xdd2222, 1);
			
			g_line.moveTo (oldx, oldy);
			g_line.lineTo (newx, newy);
			
			//if( recoderEvent) dispatcher(new ArrayObject([newx, newy],"recode_line"));
		}
		
		//===========================================================================================
		
		
		public function g_point_mouse_down(e:Event,oldx:Number,oldy:Number,newx:Number,newy:Number):void
		{
			
			
		}
		
		public function g_point_mouse_up(e:Event,oldx:Number, oldy:Number, newx:Number, newy:Number):void
		{
			var mc:Sprite = new Sprite;
			mc.graphics.beginFill (0xFF00);
            mc.graphics.drawCircle (0, 0, 3);
            mc.graphics.endFill ();
			mc.x = newx;
			mc.y = newy;
            add(mc);
            var t:TextField = new TextField;			
            t.text = _model.getValue("path").length.toString();
			mc.addChild (t);
			
			if( recoderEvent) dispatcher(new ArrayObject([newx, newy],"recode_path"));
			utilFun.Log("([newx, newy] "+newx + " newy ="+ newy);
			
		}
		
	}

}