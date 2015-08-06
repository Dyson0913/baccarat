package View.ViewComponent 
{
	import View.ViewBase.VisualHandler;
	import Model.valueObject.*;
	import Model.*;
	import util.*;
	import Command.*;
	
	import View.Viewutil.*;
	import Res.ResName;
	import caurina.transitions.Tweener;
	
	/**
	 * betzone present way
	 * @author ...
	 */
	public class Visual_betZone  extends VisualHandler
	{
		[Inject]
		public var _regular:RegularSetting;
		
		[Inject]
		public var _betCommand:BetCommand;
		
		[Inject]
		public var _visual_coin:Visual_Coin;
		
		public function Visual_betZone() 
		{
			
		}
		
		public function init():void
		{
			//bet區容器
			//coin
			var coinob:MultiObject = prepare("CoinOb", new MultiObject(), GetSingleItem("_view").parent.parent);
			coinob.container.x = 640;
			coinob.container.y = 800;
			coinob.MouseFrame = utilFun.Frametype(MouseBehavior.Customized,[0,0,3,0]);
			coinob.CustomizedFun = _regular.FrameSetting;
			coinob.CustomizedData = [3, 2, 2, 2, 2];
			coinob.Posi_CustzmiedFun = _regular.Posi_y_Setting;
			coinob.Post_CustomizedData = [0,10,20,10,0];
			coinob.Create_by_list(5,  [ResName.coin1,ResName.coin2,ResName.coin3,ResName.coin4,ResName.coin5], 0 , 0, 5, 130, 0, "Coin_");
			coinob.mousedown = _visual_coin.betSelect;
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