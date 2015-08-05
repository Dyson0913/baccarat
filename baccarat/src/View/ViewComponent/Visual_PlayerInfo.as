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
	 * playerinfo present way
	 * @author ...
	 */
	public class Visual_PlayerInfo  extends VisualHandler
	{
		
		public function Visual_PlayerInfo() 
		{
			
		}
		
		[MessageHandler(type = "Model.ModelEvent", selector = "updateCredit")]
		public function updateCredit():void
		{							
			var s:int = _model.getValue("after_bet_credit");	
			if ( _model.getValue(modelName.HandShake_chanel) != null )
			{
				var response:Function = _model.getValue(modelName.HandShake_chanel);
				response(_model.getValue(modelName.Client_ID), ["HandShake_updateCredit", s]);
				utilFun.Log("Hand_she asking "+ _model.getValue(modelName.Client_ID));
			}
			else 
			{
				utilFun.SetText(GetSingleItem(modelName.CREDIT)["credit"], _model.getValue("after_bet_credit").toString());
			}
		}		
		
		[MessageHandler(type = "Model.ModelEvent", selector = "update_result_Credit")]
		public function update_result_Credit():void
		{	
				var s:int = _model.getValue(modelName.CREDIT);
			if ( _model.getValue(modelName.HandShake_chanel) != null )
			{
				var response:Function = _model.getValue(modelName.HandShake_chanel);
				response(_model.getValue(modelName.Client_ID), ["HandShake_updateCredit", s]);				
			}
			else
			{
				utilFun.SetText(GetSingleItem(modelName.CREDIT)["credit"], _model.getValue(modelName.CREDIT).toString());
			}
		}
		
	}

}