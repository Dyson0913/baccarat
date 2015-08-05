package Model 
{	
	/**
	 * model值有更新,發送事件
	 * @author hhg4092
	 */
	public class ModelEvent 
	{
		[Selector]
		public var selector:String
		
		public function ModelEvent(select:String) 
		{			
			selector = select;		
		}
		
	}

}