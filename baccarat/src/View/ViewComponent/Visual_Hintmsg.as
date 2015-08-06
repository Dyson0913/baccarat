package View.ViewComponent 
{
	import View.ViewBase.VisualHandler;
	import Model.valueObject.*;
	import Model.*;
	import util.*;
	import Command.*;
	
	import View.Viewutil.MultiObject;
	import Res.ResName;
	import caurina.transitions.Tweener;
	
	/**
	 * hintmsg present way
	 * @author ...
	 */
	public class Visual_Hintmsg  extends VisualHandler
	{
		[Inject]
		public var _regular:RegularSetting;
		
		public function Visual_Hintmsg() 
		{
			
		}
		
		public function init():void
		{
			var hintmsg:MultiObject = prepare(modelName.HINT_MSG, new MultiObject()  , GetSingleItem("_view").parent.parent);
			hintmsg.Create_by_list(1, [ResName.Hint], 0, 0, 1, 0, 0, "time_");
			hintmsg.container.x = 627.3;
			hintmsg.container.y = 459.3;
		}
		
		[MessageHandler(type = "Model.ModelEvent", selector = "display")]
		public function display():void
		{
			GetSingleItem(modelName.HINT_MSG).gotoAndStop(1);	
			_regular.FadeIn( GetSingleItem(modelName.HINT_MSG), 2, 2, _regular.Fadeout);		
		}
		
		[MessageHandler(type = "Model.ModelEvent", selector = "hide")]
		public function timer_hide():void
		{
			var mypoker:Array =   _model.getValue(modelName.PLAYER_POKER);
			if (mypoker.length > 0) GetSingleItem(modelName.HINT_MSG).gotoAndStop(6);
			else GetSingleItem(modelName.HINT_MSG).gotoAndStop(2);
			_regular.FadeIn( GetSingleItem(modelName.HINT_MSG), 2, 2, _regular.Fadeout);			
		}
		
		[MessageHandler(type = "ConnectModule.websocket.WebSoketInternalMsg", selector = "CreditNotEnough")]
		public function no_credit():void
		{
			GetSingleItem(modelName.HINT_MSG).gotoAndStop(3);
			_regular.FadeIn( GetSingleItem(modelName.HINT_MSG), 2, 2, _regular.Fadeout);
		}
		
	}

}