package util 
{
	import flash.display.MovieClip;
	/**
	 * node for linkobject
	 * @author hhg
	 */
	public class node 
	{
		private var _Container:MovieClip;
		
		private var _item:MovieClip;
		public function get Item():MovieClip
		{
		   return _item;
		}
		
		private var _next:node;
		public function set next(value:node):void
		{
		    _next = value;
		}
		
		public function get next():node
		{
		    return _next;
		}
		
		private var _pre:node;
		public function set pre(value:node):void
		{
		    _pre = value;
		}
		
		public function get pre():node
		{
		    return _pre;
		}
		
		public var _data:DI;
		public function get data():DI
		{
		    return _data;
		}
		
		public function node() 
		{
			_next = null;
			_pre = null;
			_data = new DI();
		}
		
		public function create(item:MovieClip, contain:MovieClip):void
		{
			_item = item;
			contain.addChild(item);
			_Container = contain;
		}
		
		public function remove():void
		{
			_Container.removeChild(_item);
			_item = null;
		}
		
		public function pass(nod:node):void
		{
			if ( _next != null) _next.pass(this)
			_item.x = nod.Item.x;
		}
		
	}

}