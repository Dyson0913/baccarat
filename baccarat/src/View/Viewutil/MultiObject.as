package View.Viewutil 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.DisplayObjectContainer;
	import Interface.ViewComponentInterface;
	
	import util.utilFun;
	
	
	/**
	 * 一次生成多個有規則排列的元件 
	 * @author hhg4092
	 */
	public class MultiObject implements ViewComponentInterface
	{
		private var _Container:DisplayObjectContainer;
		
		private var _autoClean:Boolean;
		
		//元件列表
		private var _ItemList:Array = [];		
		
		public function get ItemList():Array
		{
			return _ItemList;
		}
		
		public var stop_Propagation:Boolean = false;
		
		//客制化功能
		public var CustomizedFun:Function = null;
		public var CustomizedData:Array = null;
		public var MouseFrame:Array = [];
		
		public var Posi_CustzmiedFun:Function = null;
		public var Post_CustomizedData:Array = null;
		//各事件接口
		public var rollout:Function;
		public var rollover:Function;
		public var mousedown:Function;
		public var mouseup:Function;
		
		//元件命名
		private var _ItemName:String;		
		private var _contido:Boolean;
		
		
		
		public function MultiObject() 
		{
			_autoClean =  false;
		}
		
		public function set autoClean(value:Boolean):void
		{
			_autoClean =  value;
		}
		
		
		public function get container():DisplayObjectContainer
		{
			return _Container;
		}
		
		public function getContainer():DisplayObjectContainer
		{
			return _Container;
		}
		
		public function setContainer(contain:DisplayObjectContainer):void
		{
			_Container = contain;
		}
		
		/**
		 * 生成N個物件 			E.X BetPointList.Create(12, "OrderBtn",1397.35 ,131.75 , 1, 0, 50.55, "BetPoint_", betView);
		 * @param	ItemNum  	總數量
		 * @param	LinkName 	fla裡的link名
		 * @param	StartX			起始X
		 * @param	StartY			起始Y
		 * @param	RowCnt		一列數量
		 * @param	Xdiff			X間隔
		 * @param	Ydiff			Y間隔
		 * @param	ItemName	元件命名 XXX_id(判定事件為那個元件觸發,會取其ID做判斷)
		 * @param	Container		父節點
		 */
		public function Create(ItemNum:int,LinkName:String,StartX:Number,StartY:Number,RowCnt:int,Xdiff:Number,Ydiff:Number,ItemName:String,Container:DisplayObjectContainer):void
		{
			CleanList();
			_Container = Container;			
			for (var i:int = 0 ; i < ItemNum; i++)
			{
				var mc:MovieClip = utilFun.GetClassByString(LinkName);
				mc.x = StartX + (i % RowCnt * Xdiff);
				mc.y = StartY + ( Math.floor(i / RowCnt) * Ydiff);	
				
				mc.name = ItemName + i;
				_ItemName = ItemName;
				ItemList.push(mc);
				_Container.addChild(mc);
			}		
			customized();
			_Container = Container;
			Listen();
		}
		
		public function Create_by_list(ItemNum:int,ItemNameList:Array,StartX:Number,StartY:Number,RowCnt:int,Xdiff:Number,Ydiff:Number,ItemName:String):void
		{
			CleanList();
			var diff:int = ItemNum - ItemNameList.length;
			if ( diff >0)
			{
				var lastItem:String = ItemNameList[ ItemNameList.length - 1];
				for ( var j:int = 0; j < diff ;j++) ItemNameList.push(lastItem);
			}
			
			for (var i:int = 0 ; i < ItemNum; i++)
			{
				var mc:MovieClip = utilFun.GetClassByString(ItemNameList[i]);
				
				//TODO position customized
				mc.x = StartX + (i % RowCnt * Xdiff);
				mc.y = StartY + ( Math.floor(i / RowCnt) * Ydiff);			
				
				mc.name = ItemName + i;
				_ItemName = ItemName;
				ItemList.push(mc);
				_Container.addChild(mc);
			}
			
			//customized area		
			customized();			
			Listen();
		}		
		
		private function customized():void
		{
			var ItemNum:int = ItemList.length;
			for (var i:int = 0 ; i < ItemNum; i++)
			{			
				if (CustomizedFun != null)
				{
					CustomizedFun(ItemList[i], i,CustomizedData);
				}
				
				if (Posi_CustzmiedFun != null)
				{
					Posi_CustzmiedFun(ItemList[i], i,Post_CustomizedData);
				}
				
			}
		}
		
		public function FlushObject():void
		{
			var ItemNum:int = ItemList.length;
			for (var i:int = 0 ; i < ItemNum; i++)
			{			
				if (CustomizedFun != null)
				{
					CustomizedFun(ItemList[i], i,CustomizedData);
				}
			}
		}
		
		public function exclusive(idx:int,gotoFrame:int):void
		{
			for (var i:int = 0; i < _ItemList.length; i++)
			{
				if ( i == idx ) continue;
				else _ItemList[i].gotoAndStop(gotoFrame);
			}
		}
		
		public function CleanList():void
		{
			//removeListen();
			var cnt:int = ItemList.length;
			for ( var i:int = 0; i < cnt; i++)
			{
				_Container.removeChild(ItemList[i]);
			}
			
			ItemList.length = 0;
		}
		
		public function OnExit():void
		{
			if( _autoClean ) CleanList();
		}
		
		public function Clear_ItemChildren():void
		{
			//removeListen();
			var cnt:int = ItemList.length;
			utilFun.Log("cnt[i] = "+cnt);
			for ( var i:int = 0; i < cnt; i++)
			{
			
				utilFun.Clear_ItemChildren(ItemList[i]);
			}			
		}
		
		public function Getidx(name:String):int 
		{
			var s:String = utilFun.Regex_CutPatten(name, new RegExp(_ItemName, "i"));
			return parseInt(s);
		}
		
		private function Listen():void
		{
			var N:int =  ItemList.length;
			for (var i:int = 0 ;  i < N ;  i++)
			{
				if ( MouseFrame[0] != 0) ItemList[i].addEventListener(MouseEvent.ROLL_OUT, eventListen);
				if ( MouseFrame[1] != 0) ItemList[i].addEventListener(MouseEvent.ROLL_OVER, eventListen);
				if ( MouseFrame[2] != 0) ItemList[i].addEventListener(MouseEvent.MOUSE_DOWN, eventListen);
				if ( MouseFrame[3] != 0) ItemList[i].addEventListener(MouseEvent.MOUSE_UP, eventListen);
			}
		}
		
		public function removeListen():void
		{
			if ( MouseFrame.length == 0 ) return;
			
			var N:int =  ItemList.length;
			for (var i:int = 0 ;  i < N ;  i++)
			{
				if ( MouseFrame[0] != 0) ItemList[i].removeEventListener(MouseEvent.ROLL_OUT, eventListen);
				if ( MouseFrame[1] != 0) ItemList[i].removeEventListener(MouseEvent.ROLL_OVER, eventListen);
				if ( MouseFrame[2] != 0) ItemList[i].removeEventListener(MouseEvent.MOUSE_DOWN, eventListen);
				if ( MouseFrame[3] != 0) ItemList[i].removeEventListener(MouseEvent.MOUSE_UP, eventListen);
			}
		}
		
		public function eventListen(e:Event):void
		{
			var idx:int = Getidx(e.currentTarget.name);
			switch (e.type)
			{
				case MouseEvent.ROLL_OUT:
				{
					if ( rollout != null) 
					{
						_contido = rollout(e,idx);
					    if( _contido ) utilFun.GotoAndStop(e, MouseFrame[0]);					
					}
				}
				break;
				case MouseEvent.ROLL_OVER:
				{
					if ( rollover != null)
					{
						_contido = rollover(e, idx);
						if( _contido ) utilFun.GotoAndStop(e, MouseFrame[1]);
					}
					
				}
				break;
				case MouseEvent.MOUSE_DOWN:
				{
					if ( mousedown != null) 
					{
						_contido = mousedown(e, idx);
						if ( _contido ) utilFun.GotoAndStop(e, MouseFrame[2]);
						
						if( stop_Propagation) e.stopPropagation();
					}
				}
				break;
				case MouseEvent.MOUSE_UP:
				{
					if ( mouseup != null) 
					{
						_contido = mouseup(e, idx);
						if ( _contido ) utilFun.GotoAndStop(e, MouseFrame[3]);
						
						if( stop_Propagation) e.stopPropagation();
					}
					
				}
				break;
			}
		}
		
	}

}