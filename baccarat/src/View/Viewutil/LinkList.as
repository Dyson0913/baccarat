package View.Viewutil 
{
	import util.node;
	import util.utilFun;
	/**
	 * ...
	 * @author hhg
	 */
	public class LinkList 
	{
		private var _head:node;
		private var _current:node;
		private var _nextStart:node;
		private var _tial:node
		
		public function get head():node
		{
		    return _head;
		}
		
		public function get current():node
		{
		    return _current;
		}
		
		public function get tail():node
		{
		    return _tial;
		}
		
		public function get nextStart():node
		{
		    return _nextStart;
		}
		
		
		public function LinkList() 
		{
			_head = null;
			_tial = null;
		}
		
		public function setroot(nod:node):void
		{
			_head = nod;
			_tial = nod;
			_current = nod;
			_head.pre = null;
		}
		
		public function addtail(nod:node):void
		{
			_tial.next = nod;
			nod.pre = tail;
			_tial = nod;
		}
		
		public function removehead():void
		{
			if ( _head == null)  return;
			var _pre:node = _head;
			_head = _head.next;
			_pre.next = null;
			_pre.remove();
			_pre = null;
		}
		
		public function Next():void
	    {
			_current = current.next;
		}
		
		
		public function set_next_empty_Start():void
		{
			_nextStart = _current.next;			
		}
		
		public function Next_empty():void
		{
			_current = _nextStart;
			_nextStart = _current.next;
		}
		
	}

}