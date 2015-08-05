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
	 * betzone present way
	 * @author ...
	 */
	public class Visual_betZone  extends VisualHandler
	{
		
		[Inject]
		public var _betCommand:BetCommand;
		
		public function Visual_betZone() 
		{
			
		}
		
		[MessageHandler(type = "Model.ModelEvent", selector = "clearn")]
		public function Clean():void
		{
			Get("zone").container.visible = false;
			//TODO move to good place
			GetSingleItem("zone",0).visible = false;
			GetSingleItem("zone", 1).visible = false;
				
			var a:MultiObject = Get("coinstakeZone");
			for ( var i:int = 0; i <  a.ItemList.length; i++)
			{
				utilFun.Clear_ItemChildren(GetSingleItem("coinstakeZone",i));
			}
		}
		
		[MessageHandler(type = "Model.ModelEvent", selector = "display")]
		public function display():void
		{
			var betzone:MultiObject = Get("betzone");
			betzone.mousedown = _betCommand.betTypeMain;
			betzone.mouseup = _betCommand.empty_reaction;
		}
		
		[MessageHandler(type = "Model.ModelEvent", selector = "hide")]
		public function timer_hide():void
		{
			var betzone:MultiObject = Get("betzone");
			betzone.mousedown = null;
		}
		
		
	}

}