package Command 
{
	import flash.events.Event;
	import Model.*;
	
	import util.*;
	import View.GameView.*;
	/**
	 * state event
	 * @author hhg4092
	 */
	public class StateCommand 
	{
		[MessageDispatcher]
        public var dispatcher:Function;
		
		[Inject]
		public var _model:Model;
		
		
		public function StateCommand() 
		{
			
		}
		
		[MessageHandler(type = "Model.ModelEvent", selector = "update_state")]
		public function state_update():void
		{
			var state:int = _model.getValue(modelName.GAMES_STATE);		
			if ( state  == gameState.NEW_ROUND)
			{
				dispatcher(new ModelEvent("clearn"));
				dispatcher(new ModelEvent("display"));
				//clearn();
			}
			else if ( state == gameState.END_BET) dispatcher(new ModelEvent("hide"));
			else if ( state == gameState.START_OPEN) { }
			else if ( state == gameState.END_ROUND) { }
		}
	}

}