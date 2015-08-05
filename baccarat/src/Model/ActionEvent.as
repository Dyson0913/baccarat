package Model 
{
	import util.utilFun;
	/**
	 * valueObject 
	 * @author hhg
	 */
	public class ActionEvent 
	{
		public var Value:*;
		
		[Selector]
		public var selector:*
		
		public function ActionEvent(ob:*,selec:*) 
		{
			Value = ob;
			selector = selec;
		}
		
	}

}