package Model 
{
	import Model.ValueObject;
	import util.DI;
	import util.utilFun;
	/**
	 * ...
	 * @author hhg
	 */
	public class Model 
	{
		private var _di:DI = new DI();
		
		public function Model() 
		{
			
		}
		
		[MessageHandler(type = "Model.ValueObject")]
		public function Value(va:ValueObject):void
		{
			putValue(va.selector, va.Value);
		}
		
		public function putValue(name:*,ob:*):void
		{
			_di.putValue(name, ob);
		}
		
		public function getValue(name:*):*
		{
			return _di.getValue(name);
		}
	}

}