package View.ViewComponent 
{
	import flash.events.Event;
	import View.ViewBase.VisualHandler;
	import Model.valueObject.*;
	import Model.*;
	import util.*;
	import Command.*;
	
	import View.Viewutil.MultiObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import View.GameView.*;
	import Res.ResName;
	import caurina.transitions.Tweener;
	
	/**
	 * coin present way
	 * @author ...
	 */
	public class Visual_Coin  extends VisualHandler
	{
		[Inject]
		public var _betCommand:BetCommand;
		
		
		public function Visual_Coin() 
		{
			
		}
		
		[MessageHandler(type = "Model.ModelEvent", selector = "clearn")]
		public function Clean_poker():void
		{
			//TODO why not 
			//Get("coinstakeZone").Clear_itemChildren();		
			if ( GetSingleItem("coinstakeZone") != null)  utilFun.Clear_ItemChildren(GetSingleItem("coinstakeZone"));
			if ( GetSingleItem("coinstakeZone",1) != null) utilFun.Clear_ItemChildren(GetSingleItem("coinstakeZone",1));
			if ( GetSingleItem("coinstakeZone",2) != null) utilFun.Clear_ItemChildren(GetSingleItem("coinstakeZone",2));
		}
		
		[MessageHandler(type = "Model.ModelEvent", selector = "updateCoin")]
		public function updateCredit():void
		{			
			//coin動畫
			if (_betCommand.has_Bet_type(CardType.BANKER ))
			{				
				stack(_betCommand.Bet_type_betlist(CardType.BANKER), GetSingleItem("coinstakeZone"));
			}
			
			if ( _betCommand.has_Bet_type(CardType.PLAYER ) )
			{			
				stack(_betCommand.Bet_type_betlist(CardType.PLAYER), GetSingleItem("coinstakeZone",1));
			}			
			
			if ( _betCommand.has_Bet_type(CardType.Tie))
			{			
				stack(_betCommand.Bet_type_betlist(CardType.Tie), GetSingleItem("coinstakeZone",2));
			}			
		}		
		
		public function stack(coinarr:Array,contain:DisplayObjectContainer):void
		{
			utilFun.Clear_ItemChildren(contain);
			var coin:Array = [];
			var shY:int = 0;
			var shX:int = 0;
			var coinshY:int = -10;
			var p:Array = [0, 40, 70, 90, 105];
			var b:Array = [0, 10, 20, 35, 60];
			var t:Array = [0, 5, 10, 5, 0];
			for (var i:int = 0; i < 5; i++)
			{
				if ( contain == GetSingleItem("coinstakeZone",2))
				{					
					shY = t[i];
					shX = 60;
					coinshY = -5;
				}
				else if ( contain == GetSingleItem("coinstakeZone",1))
				{				
					shY = p[i];
					shX = 106;
				}
				else if ( contain == GetSingleItem("coinstakeZone"))
				{				
					shY = -b[i];
					shX = 106;
				}
				
				coin.length = 0;
				//每疊coin 的multiobject
				createcoin(i, coin, coinarr.concat(), contain,shY,shX,coinshY);
			}			
		}	
		
		public function createcoin(cointype:int, coin:Array, coinstack:Array, contain:DisplayObjectContainer ,shY:int,shX:int,coinshY:int):void
		{			
			coin.length = 0;
			while (coinstack.indexOf(_model.getValue("coin_list")[cointype]) != -1)
			{
				var idx:int = coinstack.indexOf( _model.getValue("coin_list")[cointype]);
				coin.push(coinstack[idx]);
				coinstack.splice(idx, 1);
			}
			
			
			var shifty:int = 0;
			var shiftx:int = 0;
			
			var secoin:MultiObject = new MultiObject()
			secoin.CleanList();
			if ( contain == GetSingleItem("coinstakeZone",2))
			{				
				secoin.CustomizedFun = coinput;
				secoin.CustomizedData = coin;
			}
			
			secoin.Create( coin.length, "coin_" + (cointype + 1), 0 +shiftx+ (cointype * shX) , 0+shifty +shY, 1, 0, coinshY, "Bet_",  contain);			
		}
		
		public function coinput(mc:MovieClip, idx:int, coinstack:Array):void
		{
			utilFun.scaleXY(mc, 0.5, 0.5);
		}	
		
		public function betSelect(e:Event, idx:int):Boolean
		{			
			var coinob:MultiObject = Get("CoinOb");
			coinob.exclusive(idx,2);
			
			_model.putValue("coin_selectIdx", idx);
			return true;
		}
	}

}