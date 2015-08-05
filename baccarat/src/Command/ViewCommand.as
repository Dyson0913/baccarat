package Command 
{
	import Model.valueObject.Intobject;
	import Model.valueObject.StringObject;
	import util.DI;
	import util.utilFun;
	/**
	 * view control
	 * @author hhg4092
	 */
	public class ViewCommand 
	{
		[MessageDispatcher]
        public var dispatcher:Function;
			
		public static const SWITCH:String = "Switch";
		public static const ADD:String = "add";
		public static const HIDE:String = "hide";
		
		public static const VIEW_ENTER:String = "EnterView";
		public static const VIEW_LEAVE:String  = "LeaveView";
		
		public var _preViewDi:DI = new DI();
		public var _curViewDi:DI = new DI();
		public var _nextViewDi:DI = new DI();
		
		public var _HudViewDi:DI = new DI();
		
		public var preViewDI:DI;
		public var currentViewDI:DI;
		public var nextViewDI:DI;		
		public var HudViewDI:DI = new DI();
		
		public var _preView:int = -1;
		public function get preview():int
		{
			return _preView;
		}
		
		public var _CurrentView:int = -1;
		public function get CurrentView():int
		{
			return _CurrentView;
		}
		
		public function ViewCommand() 
		{
			preViewDI = _preViewDi;
		    currentViewDI = _curViewDi;
			nextViewDI = _nextViewDi;	
			HudViewDI = _HudViewDi
		}		
		
		public function all_clean():void
		{
			preViewDI.clean();
			currentViewDI.clean();
			nextViewDI.clean();
			HudViewDI.clean();
			_preView = -1;
			_CurrentView = -1;
		}
		
		[MessageHandler(type = "Model.valueObject.Intobject",selector="Switch")]
		public function ViewSwitch(enterView:Intobject):void
		{
			if ( _preView == -1 ) _preView = enterView.Value;
			else _preView = _CurrentView;
			_CurrentView = enterView.Value;
			
			viewDISwitch();
			dispatcher(new Intobject(_CurrentView,VIEW_ENTER));
			utilFun.Log("enter vew = " +_CurrentView);
			if ( _preView != _CurrentView) 
			{
				utilFun.Log("leave preivew = " + _preView);
				preView_clean();
				dispatcher(new Intobject(_preView,VIEW_LEAVE ));
			}			
		}
		
		[MessageHandler(type = "Model.valueObject.Intobject",selector="add")]
		public function Viewadd(enterView:Intobject):void
		{
			dispatcher(new Intobject(enterView.Value,VIEW_ENTER));
		//	utilFun.Log("view add = " +enterView.Value);			
		}
		
		[MessageHandler(type = "Model.valueObject.Intobject",selector="hide")]
		public function ViewHide(enterView:Intobject):void
		{
			dispatcher(new Intobject(enterView.Value,VIEW_LEAVE));
			hudView_clean();
			//utilFun.Log("view hide = " +enterView.Value);
		}	
		
		private function viewDISwitch():void
		{
			nextViewDI.clean();
			
			//switch ptr
			var temp:DI;
			temp = currentViewDI;
			currentViewDI = nextViewDI;			
			nextViewDI = preViewDI;
			preViewDI = temp;			
		}
		
		public function Get(name:*):*
		{
			return currentViewDI.getValue(name);
		}
		
		private function preView_clean():void
		{			
			preViewDI.clean();
		}
		
		public function GetHud(name:*):*
		{
			return HudViewDI.getValue(name);
		}
		
		private function hudView_clean():void
		{			
			HudViewDI.clean();
		}
		
	}

}