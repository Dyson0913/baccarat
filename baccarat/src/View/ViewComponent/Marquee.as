package View.ViewComponent 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	
	import View.componentLib.util.utilFun;
	import caurina.transitions.Tweener;
	import flash.text.TextFormat;	
	

	/**
	 * 跑馬燈元件 
	 * 平時播:定時訊息
	 * 插播:插播訊息進來等平時播完,才切回定時訊息
	 * @author hhg
	 */
	public class Marquee extends MovieClip
	{		
		//跑馬元件
		protected var _mcDisplay:MovieClip;
		
		//定時訊息
		private var _arrPeriodMsg:Array =[];
		private var _PeriodIdx:int;
		
		//插播訊息
		private var  _arrRealTimeMsg:Array =[];
		private var _bPlayRealTime:Boolean;
		
		private var _msgInitPo:Number = 0;
		private var _Xdistance:Number = -350;
		private var _marqueeTime:int = 10;
		
		public function Marquee(mc:MovieClip)
		{	
			_mcDisplay = mc;
		}		
		
		public function init():void
		{	
			_PeriodIdx = 0;
			_bPlayRealTime = false;	
		}		
		
		//設定定時訊息 設定訊息後,跑馬燈才會開始輪播
		public function SetPeriodMsg(PeriodMsg:Array):void
		{
			_arrPeriodMsg = PeriodMsg;			
			SetText(_arrPeriodMsg[_PeriodIdx]);
			
			_msgInitPo = _mcDisplay["marquee_text"].x;
			
			Tweener.addTween( _mcDisplay["marquee_text"], { x:_Xdistance, time:_marqueeTime , onComplete:complet, transition:"linear" } );			
		}	
		
		private function complet():void
		{			
			_mcDisplay["marquee_text"].x = _msgInitPo;	
			if ( _bPlayRealTime)
			{
				//即時訊息,播完就丟 最後一個播完再切回定時訊息
				SetText(_arrRealTimeMsg[0]);
				_arrRealTimeMsg.shift();
				
				if ( _arrRealTimeMsg.length == 0)	
					_bPlayRealTime = false;
			}
			else
			{
				_PeriodIdx++;
				_PeriodIdx %= _arrPeriodMsg.length;
				SetText(_arrPeriodMsg[_PeriodIdx]);
			}
			Tweener.addTween( _mcDisplay["marquee_text"], {x:_Xdistance, time:_marqueeTime  ,onComplete:complet, transition:"linear" });			
		}
		
		//設定即時訊息
		public function SetRealTimeMsg(RealMsg:Array):void
		{
			_arrRealTimeMsg = RealMsg;
			_bPlayRealTime = true;
		}
		
		//跑馬文字
		private function SetText(marquee_text:String):void
		{
			utilFun.SetText(_mcDisplay["marquee_text"], marquee_text);
		}
		
	}

}