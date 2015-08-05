package util 
{
	import flash.utils.Dictionary;
	import Interface.CollectionsInterface;
	/**
	 * DI
	 * @author hhg
	 */
	public class DI implements CollectionsInterface
	{
		private var _dic:Dictionary = new Dictionary();
		
		public function DI() 
		{
			
		}
		
		public function putValue(name:*,ob:*):void
		{
			_dic[name] = ob;
		}
		
		public function getValue(name:*):*
		{
			if (_dic[name] != null)
			{
				return _dic[name];
			}
			return null;
		}
		
		public function Del(name:*):void
		{
			if ( _dic[name] != null)
			{
				delete _dic[name] 
			}			
		}
		
		public function clean():void
		{
			_dic = new Dictionary();
		}
		
		public function length():int
		{
			var n:int = 0;
			for (var ke:* in _dic)
			{
			    n++;
			}
			return n;
		}
		
	}

}