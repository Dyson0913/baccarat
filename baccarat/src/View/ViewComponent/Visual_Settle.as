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
	public class Visual_Settle  extends VisualHandler
	{
		[Inject]
		public var _regular:RegularSetting;
		
		public function Visual_Settle() 
		{
			
		}
		
		public function init():void
		{
			var zoneCon:MultiObject = prepare("zone", new MultiObject(), GetSingleItem("_view").parent.parent);
			zoneCon.Create_by_list(2, [ResName.bankerScore, ResName.playerScore], 0 , 0, 2, -770, 0, "Bet_");
			zoneCon.container.visible = false;
			zoneCon.container.x = 1290;
			zoneCon.container.y = 150;
		}
		
		[MessageHandler(type = "Model.ModelEvent", selector = "clearn")]
		public function Clean():void
		{
			Get("zone").container.visible = false;			
			GetSingleItem("zone",0).visible = false;
			GetSingleItem("zone", 1).visible = false;		
		}
		
		[MessageHandler(type = "Model.ModelEvent", selector = "round_result")]
		public function round_result():void
		{
			var a:String = _model.getValue(modelName.ROUND_RESULT);
			var syblist:Array =  _model.getValue(modelName.SPLIT_SYMBOL)
			var result:Array = a.split(syblist[0]);
			result.pop();
			
			//TODO get from server
			var clean:Array = [1, 2, 3, 4, 5, 6];
			for ( var i:int = 0; i < result.length ; i++)
			{
				var resultinfo:Array = result[i].split(syblist[1]);
				var zone:int = parseInt( resultinfo[0]);
				var odds:int = parseInt(resultinfo[1]);
				utilFun.Log("zone = " + zone);
				utilFun.Log("odds = " + odds);
				
				if ( clean.indexOf(zone) != -1)
				{
					clean.splice(clean.indexOf(zone), 1);
				}
				//zone handle
				//pa 5 = 0
				if ( odds != 5)
				{
					_regular.Twinkle(GetSingleItem("betzone", zone-1), 3, 10, 2);	
				}
				else
				{
					utilFun.Clear_ItemChildren(GetSingleItem("coinstakeZone", zone-1));
				}
				
			
			}
			
			//hint			
			Get("zone").container.visible = true;
			GetSingleItem("zone", 0).visible = true;
			var point:Array = utilFun.arrFormat(countPoint(_model.getValue(modelName.BANKER_POKER)), 2);
			if ( point[0] == 0 ) point[0] = 10;
			if ( point[1] == 0 ) point[1] = 10;			
			GetSingleItem("zone")["_num0"].gotoAndStop(point[0]);
			GetSingleItem("zone")["_num1"].gotoAndStop(point[1]);
			
			GetSingleItem("zone", 1).visible = true;
			point = utilFun.arrFormat(countPoint(_model.getValue(modelName.PLAYER_POKER)), 2);
			if ( point[0] == 0 ) point[0] = 10;
			if ( point[1] == 0 ) point[1] = 10;
			GetSingleItem("zone", 1)["_num0"].gotoAndStop(point[0]);
			GetSingleItem("zone", 1)["_num1"].gotoAndStop(point[1]);
			
			utilFun.Log("clean =" + clean);
			for ( i = 0; i < clean.length ; i++)
			{
				utilFun.Clear_ItemChildren(GetSingleItem("coinstakeZone", clean[i]-1));
			}
			
			
			//主路單更新
			//var idx:int = _mainTable.current.data.getValue("current_idx");				
			//addBall(betresult,_model.getValue("Position")[idx] , _mainTable.current.Item,"mainball");
			//idx = (idx + 1) % 6;
			//if ( idx == 0) 
			//{
				//_mainTable.Next();
			//}
			//_mainTable.current.data.putValue("current_idx",idx);
			//
			//大路單更新
			//bigRoadupdate();		
									
		}
		
		
		private function countPoint(poke:Array):int
		{
			var total:int = 0;
			for (var i:int = 0; i < poke.length ; i++)
			{
				var strin:String =  poke[i];
				var arr:Array = strin.match((/(\w|d)+(\w)+/));					
				var numb:String = arr[1];				
				
				var point:int = 0;
				if ( numb == "i" || numb == "j" || numb == "q" || numb == "k" ) 				
				{
					point = 10;
				}				
				else 	point = parseInt(numb);
				
				total += point;
			}	
			
			return total %= 10;
		}		
	}

}