package Model.valueObject 
{
	/**
	 * ...
	 * @author hhg
	 */
	public class Intobject 
	{
		public var Value:int;
		
		[Selector]
		public var selector:String
		
		public function Intobject(ob:int,selec:String) 
		{
			Value = ob;
			selector = selec;
		}
		
	}

}