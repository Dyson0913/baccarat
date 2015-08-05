package Model 
{
	import util.utilFun;
	/**
	 * valueObject 
	 * @author hhg
	 */
	public class ValueObject 
	{
		public var Value:*;
		
		[Selector]
		public var selector:*
		
		public function ValueObject(ob:*,selec:*) 
		{
			Value = ob;
			selector = selec;
		}
		
	}

}