package View.Viewutil 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import util.utilFun;
	/**
	 * tracker mouse coordinator
	 * @author hhg4092
	 */
	public class MouseTracker extends Sprite
	{
		private var _old_x:Number;
		private var _old_y:Number;
		
		private var _new_x:Number;
		private var _new_y:Number;
		
		private var _down:Boolean;
		
		public var mousedown:Function;
		public var mousemove:Function;
		public var mouseup:Function;
		
		public function MouseTracker() 
		{
			mousedown = null;
			mousemove = null;
			mouseup = null;			
			
			_down = false;
		}
		public function init():void
		{
			//utilFun.Log("MouseTracker = "+this.stage);
			this.stage.addEventListener(MouseEvent.MOUSE_DOWN, down);
			this.stage.addEventListener(MouseEvent.MOUSE_MOVE, move);
			this.stage.addEventListener(MouseEvent.MOUSE_UP, myup );
		}
		
		public function down(e:Event):void
		{
			_down =  true;
			_old_x = e.currentTarget.stage.mouseX;
			_old_y = e.currentTarget.stage.mouseY;
			//utilFun.Log("_old_x = "+_old_x);
			//utilFun.Log("_old_y = " + _old_y);
			if (mousedown != null)
			{
				mousedown(e,_old_x,_old_y);
			}
		}
		
		public function move(e:Event):void
		{
			//utilFun.Log("stage.mouseX = "+e.currentTarget.stage.mouseX);
			//utilFun.Log("stage.mousey = "+e.currentTarget.stage.mouseY);
			if ( _down )
			{
				if (mousemove != null)
				{
					mousemove(e,_old_x,_old_y, e.currentTarget.stage.mouseX,e.currentTarget.stage.mouseY);
				}
			}
		}
		
		public function myup(e:Event):void
		{
			_down = false;
			_new_x = e.currentTarget.stage.mouseX;
			_new_y = e.currentTarget.stage.mouseY;
			//utilFun.Log("_new_x = "+_new_x);
			//utilFun.Log("_new_y = " + _new_y);			
			if (mouseup != null)
			{
				mouseup(e,_old_x,_old_y,_new_x,_new_y);
			}
		}
		
	}

}