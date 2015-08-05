package Model.valueObject 
{
	/**
	 * ...
	 * @author hhg4092
	 */
	public class NumberObject 
	{
		public var Value:Number;
		
		[Selector]
		public var selector:String
		
		public function NumberObject(ob:Number,selec:String) 
		{
			Value = ob;
			selector = selec;
		}
		
	}

}