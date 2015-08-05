package Model.valueObject 
{
	/**
	 * ...
	 * @author hhg
	 */
	public class ArrayObject 
	{
		public var Value:Array;
		
		[Selector]
		public var selector:String
		
		public function ArrayObject(ob:Array,selec:String) 
		{
			Value = ob;
			selector = selec;
		}
		
	}

}