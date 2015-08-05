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
	import caurina.transitions.properties.CurveModifiers;
	
	/**
	 * poker present way
	 * @author ...
	 */
	public class Visual_poker  extends VisualHandler
	{
		private var pokerpath:Array = [];
		private var dynamicpoker:Array = [];
		
		[Inject]
		public var _path:Path_Generator;
		
		public function Visual_poker() 
		{
			
		}
		
		[MessageHandler(type = "Model.ModelEvent", selector = "clearn")]
		public function Clean_poker():void
		{
			if ( Get(modelName.PLAYER_POKER) != null) Get(modelName.PLAYER_POKER).CleanList();
			if ( Get(modelName.BANKER_POKER) != null) Get(modelName.BANKER_POKER).CleanList();			
			
			for ( var i:int = 0; i <  dynamicpoker.length ; i++)
		  {
			   removie(dynamicpoker[i])			
			}
		   dynamicpoker.length = 0;
			
		}
		
		[MessageHandler(type = "Model.valueObject.Intobject",selector="pokerupdate")]
		public function playerpokerupdate(type:Intobject):void
		{
			var Mypoker:Array =   _model.getValue(type.Value);
			var pokerlist:MultiObject = Get(type.Value)
			utilFun.Log("Mypoker[0].x = "+Mypoker);			
			for ( var i:int = 0; i < Mypoker.length; i++)
			{
				paipathinit(type.Value,i);								
				var pokerid:int = pokerUtil.pokerTrans(Mypoker[i])
				static_deal(pokerid, type.Value, i);
			}			
			
		}
		
		[MessageHandler(type= "Model.ModelEvent",selector = "playerpokerAni")]
		public function playerpokerani():void
		{				
			var playerpoker:Array =   _model.getValue(modelName.PLAYER_POKER);
			
			//取得第n 張牌路徑
			
			paipathinit(modelName.PLAYER_POKER,playerpoker.length-1);
			utilFun.Log("pokerpath[0].2 =");
			var pokerid:int = pokerUtil.pokerTrans(playerpoker[playerpoker.length - 1])
			paideal(pokerid, modelName.PLAYER_POKER, playerpoker.length - 1);
			
		}
		
		[MessageHandler(type= "Model.ModelEvent",selector = "playerpokerAni2")]
		public function playerpokerani2():void
		{			
			var bank:Array =   _model.getValue(modelName.BANKER_POKER);
			//取得第n 張牌路徑
			paipathinit(modelName.BANKER_POKER,bank.length-1);
			
			var pokerid:int = pokerUtil.pokerTrans(bank[bank.length - 1])		
			paideal(pokerid,modelName.BANKER_POKER,bank.length - 1);
		}
		
		
		[MessageHandler(type = "Model.ModelEvent", selector = "round_result")]
		public function round_effect():void
		{
			//var playerpoker:Array =   _model.getValue(modelName.PLAYER_POKER);
			//var best3:Array = pokerUtil.newnew_judge( playerpoker);
			//utilFun.Log("best 3 = "+best3);
			//var pokerlist:MultiObject = Get(modelName.PLAYER_POKER)
			//pokerUtil.poer_shift(pokerlist.ItemList.concat(), best3);
			//
			//var banker:Array =   _model.getValue(modelName.BANKER_POKER);
			//var best2:Array = pokerUtil.newnew_judge( banker);
			//var bpokerlist:MultiObject = Get(modelName.BANKER_POKER)
			//pokerUtil.poer_shift(bpokerlist.ItemList.concat(), best2);
		}
		
		public function static_deal(pokerid:int,cardtype:int,pokernum:int):void
		{
			var mypoker:MovieClip = utilFun.GetClassByString(ResName.Poker);
			mypoker.rotationY = -180			
			mypoker.gotoAndStop(pokerid);
									
			//var playerCon:MultiObject  = Get(modelName.PLAYER_POKER);
			var pokerbac:MovieClip;
			if ( cardtype == modelName.PLAYER_POKER) pokerbac = GetSingleItem(modelName.PLAYER_POKER, pokernum);
			else pokerbac = GetSingleItem(modelName.BANKER_POKER, pokernum);
					
			
			mypoker.x = 83;
			mypoker.y = -126;				
			pokerbac.addChild(mypoker)			
			
			//位移 
			pokerbac.x = pokerpath [pokerpath.length-1].x;
            pokerbac.y = pokerpath [pokerpath.length-1].y;
			utilFun.Log("pokerbac.x = "+pokerbac.x);
			utilFun.Log("pokerbac.y = "+pokerbac.y);
			pokerbac.scaleX = 0.8;
			pokerbac.scaleY = 0.8;			
			pokerbac.rotationY = -180;			
		}
		
		public function paideal(pokerid:int,cardtype:int,pokernum:int):void
	   {
		   	var mypoker:MovieClip = utilFun.GetClassByString(ResName.Poker);
			mypoker.rotationY = -180
			mypoker.visible = false;
			mypoker.gotoAndStop(pokerid);
						
			//TODO 用Get(modelName.BANKER_POKER) ,不要再自己產生
			var playerCon:MultiObject  = Get(modelName.PLAYER_POKER);
			utilFun.Log("pokerpath[0].pokerbac="+playerCon.ItemList.length);
			
			
			var pokerbac:MovieClip;
			if ( cardtype == modelName.PLAYER_POKER) pokerbac = GetSingleItem(modelName.PLAYER_POKER, 1);
			else pokerbac = GetSingleItem(modelName.BANKER_POKER, pokernum);
			
		//	var pokerbac:MovieClip = utilFun.GetClassByString("pokerback");
			mypoker.x = 83;
			mypoker.y = -126;	
			utilFun.Log("pokerpath[0].paideal 2=");
			pokerbac.addChild(mypoker)
			
			pokerbac.rotation = -65;
			pokerbac.scaleX = 0.48;
			pokerbac.scaleY = 0.48;
			
			//add(pokerbac);
			//dynamicpoker.push(pokerbac);
			utilFun.Log("paideal[0].aa =");
			utilFun.Log("pokerpath[0].x = "+pokerpath[0].x);
			utilFun.Log("pokerpath[0].y = "+pokerpath[0].y);		
			
			//位移 by path
			pokerbac.x = pokerpath[0].x;
            pokerbac.y = pokerpath[0].y;
            Tweener.addTween(pokerbac, {
                x:pokerpath [pokerpath.length -1].x,
                y:pokerpath [pokerpath.length -1].y,
                _bezier:_path.makeBesierArray(pokerpath),
                time:0.5, onComplete:ok, onCompleteParams:[pokerbac,mypoker,cardtype], transition:"linear"});
        
			Tweener.addTween(pokerbac, { scaleX:0.8,scaleY:0.8, rotation: 0,time:0.5, transition:"easeInOutCubic" } )
	   }
		
	   public function ok(pokerbac:MovieClip,mypoker:MovieClip,cardtype:int):void
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
			if ( cardtype == modelName.PLAYER_POKER) var path:Array = _model.getValue("player_pokerpath")		
			else var path:Array = _model.getValue("banker_pokerpath");
			
			pokerpath.length = 0;
			pokerpath = _path.getPath(path,npoker);
			
		}
	}

}