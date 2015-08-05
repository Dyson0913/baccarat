package Model.valueObject 
{
	/**
	 * ...
	 * @author hhg
	 */
	public class StringObject 
	{
		public var Value:String;
		
		[Selector]
		public var selector:String
		
		public function StringObject(ob:String,selec:String) 
		{
			Value = ob;
			selector = selec;
		}
		
	}

}