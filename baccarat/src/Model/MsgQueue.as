package Model 
{
	import caurina.transitions.Tweener;
	import util.utilFun;
	
	/**
	 * queue package msg
	 * @author hhg4092
	 */
	public class MsgQueue 
	{
		[MessageDispatcher]
        public var dispatcher:Function;
		
		private var _queueMsg:Array = [];
		
		private var _isqueueing:Boolean;
		
		//[MessageBinding(type="Model.valueObject.BoolObject",messageProperty="Value",selector="Msgqueue")]
		public function set Isqueueing(value:Boolean):void
		{
			_isqueueing = value;
			
			//打開,再次檢查
			if ( value == false)
			{
				checkqueue();
			}
		}
		
		public function MsgQueue() 
		{			
			_isqueueing = false;			
		}
		
		public function push(msg:Object):void
		{
			_queueMsg.push(msg);
			Tweener.addCaller(this, { time:0.1 , count: 1, onUpdate: this.checkqueue } );
		}
		
		public function getMsg():Object
		{
			var msg:Object = _queueMsg[0]
			_queueMsg.shift();
			return msg;
		}
		
		private function checkqueue():void
		{
			//utilFun.Log("checkqueue" +_queueMsg.length);
			
			if ( _queueMsg.length != 0)
			{
				if (_isqueueing) 
				{
					//utilFun.Log("is queing retu");
					return;
				}
				
				dispatcher(new ModelEvent("popmsg"));
				Tweener.addCaller(this, { time:0.1 , count: 1, onUpdate: this.checkqueue } );
			}
			
		}
		
	}

}