package Model.valueObject 
{
	/**
	 * ...
	 * @author hhg4092
	 */
	public class BoolObject 
	{
		public var Value:Boolean;
		
		[Selector]
		public var selector:String
		
		public function BoolObject(ob:Boolean,selec:String) 
		{
			Value = ob;
			selector = selec;
		}
		
	}

}