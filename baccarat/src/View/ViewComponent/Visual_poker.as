package View.ViewComponent 
{
	import flash.display.MovieClip;
	import util.math.Path_Generator;
	import View.ViewBase.VisualHandler;
	import Model.valueObject.*;
	import Model.*;
	import util.*;
	
	import View.Viewutil.MultiObject;
	import Res.ResName;
	import caurina.transitions.Tweener;	
	
	/**
	 * poker present way
	 * @author ...
	 */
	public class Visual_poker  extends VisualHandler
	{
		private var pokerpath:Array = [];
		
		[Inject]
		public var _path:Path_Generator;
		
		public function Visual_poker() 
		{
			
		}
		
		public function init():void
		{
			var bankerCon:MultiObject =  prepare(modelName.BANKER_POKER, new MultiObject(), GetSingleItem("_view").parent.parent);
			bankerCon.autoClean = true;
			bankerCon.CleanList();
			bankerCon.CustomizedFun = pokerUtil.hidepoker;
			bankerCon.Create_by_list(3, ["pokerback"], 0 , 0, 3, 0, 0, "Bet_");
			
			var playerCon:MultiObject = prepare(modelName.PLAYER_POKER, new MultiObject(), GetSingleItem("_view").parent.parent);
			playerCon.autoClean = true;
			playerCon.CleanList();
			playerCon.CustomizedFun = pokerUtil.hidepoker;			
			playerCon.Create_by_list(3, ["pokerback"], 0 , 0, 3, 0, 0, "Bet_");
		}
		
		[MessageHandler(type = "Model.ModelEvent", selector = "clearn")]
		public function Clean_poker():void
		{
			var mypoker:MultiObject;
			if ( Get(modelName.PLAYER_POKER) != null) 
			{				
				mypoker= Get(modelName.PLAYER_POKER);
				mypoker.CleanList();
				mypoker.CustomizedFun = pokerUtil.hidepoker;
				mypoker.Create_by_list(3, ["pokerback"], 0 , 0, 3, 0, 0, "Bet_");
			}
			if ( Get(modelName.BANKER_POKER) != null) 
			{				
				mypoker = Get(modelName.BANKER_POKER);
				mypoker.CleanList();
				mypoker.CustomizedFun = pokerUtil.hidepoker;
				mypoker.Create_by_list(3, ["pokerback"], 0 , 0, 3, 0, 0, "Bet_");
			}
			
		}
		
		[MessageHandler(type = "Model.valueObject.Intobject",selector="pokerupdate")]
		public function playerpokerupdate(type:Intobject):void
		{
			var Mypoker:Array =   _model.getValue(type.Value);			
			for ( var pokernum:int = 0; pokernum < Mypoker.length; pokernum++)
			{
				paipathinit(type.Value, pokernum);
				var pokerid:int = pokerUtil.pokerTrans(Mypoker[pokernum])
				paideal(pokerid, type.Value, pokernum,true);
			}			
			
		}
		
		[MessageHandler(type = "Model.valueObject.Intobject",selector="playerpokerAni")]
		public function playerpokerani(type:Intobject):void
		{				
			var mypoker:Array =   _model.getValue(type.Value);			
			//取得第n 張牌路徑			
			paipathinit(type.Value, mypoker.length - 1);
			var pokerid:int = pokerUtil.pokerTrans(mypoker[mypoker.length - 1])
			paideal(pokerid, type.Value, mypoker.length - 1);
			
		}
		
		public function paideal(pokerid:int, cardtype:int, pokernum:int, static_deal:Boolean = false):void
	   {
		   	var mypoker:MovieClip = utilFun.GetClassByString(ResName.Poker);
			mypoker.rotationY = -180			
			mypoker.gotoAndStop(pokerid);			
			
			var pokerbac:MovieClip = GetSingleItem(cardtype, pokernum);			
			mypoker.x = 83;
			mypoker.y = -126;
			pokerbac.visible = true;
			pokerbac.addChild(mypoker)
			
			if ( static_deal )
			{
				pokerbac.scaleX = 0.8;
				pokerbac.scaleY = 0.8;			
				pokerbac.rotationY = -180;
				
				pokerbac.x = pokerpath [pokerpath.length-1].x;
				pokerbac.y = pokerpath [pokerpath.length - 1].y;
			}
			else
			{
				mypoker.visible = false;
				
				pokerbac.rotation = -65;
				pokerbac.scaleX = 0.48;
				pokerbac.scaleY = 0.48;
				
				
				pokerbac.x = pokerpath[0].x;
				pokerbac.y = pokerpath[0].y;
				Tweener.addTween(pokerbac, {
					x:pokerpath [pokerpath.length -1].x,
					y:pokerpath [pokerpath.length -1].y,
					_bezier:_path.makeBesierArray(pokerpath),
					time:0.5, onComplete:ok, onCompleteParams:[pokerbac,mypoker], transition:"linear"});
			
				Tweener.addTween(pokerbac, { scaleX:0.8, scaleY:0.8, rotation: 0, time:0.5, transition:"easeInOutCubic" } )
			}
	   }
		
	   public function ok(pokerbac:MovieClip,mypoker:MovieClip):void
		{		
			//翻牌
			Tweener.addTween(pokerbac, { rotationY:-180, time:0.5, transition:"linear",onUpdate:this.show,onUpdateParams:[pokerbac,mypoker] } )
		}
		
		public function show(pokerbac:MovieClip,mypoker:MovieClip):void
		{			
			if ( pokerbac.rotationY <= -100)
			{
				mypoker.visible = true;
			}
		}
		
		public function paipathinit(cardtype:int ,npoker:int):void
		{
			var path:Array;
			if ( cardtype == modelName.PLAYER_POKER) path = _model.getValue("player_pokerpath")		
			else path = _model.getValue("banker_pokerpath");
			
			pokerpath.length = 0;
			pokerpath = _path.get_Path_isometric(path,npoker);
			
		}
	}

}