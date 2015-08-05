package util 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.getDefinitionByName;
	import flash.utils.setTimeout;
	import Interface.ViewComponentInterface;
	
	import com.hexagonstar.util.debug.Debug;
	import View.Viewutil.MouseBehavior;
	import Res.ResName;	
	/**
	 * 常用功能
	 * @author hhg
	 */
	public class utilFun
	{		
		
		public function utilFun() 
		{
			
		}
		
		//由link名取得類別
		public static function GetClassByString(sClassName:String):MovieClip 
		{			
			var Temp:Class = getDefinitionByName(sClassName) as Class;
			var mc:MovieClip = new Temp();	
			mc.name = sClassName;
			return mc;
		}
		
		public static function prepare(name:*, ob:ViewComponentInterface,di:DI, container:DisplayObjectContainer = null):*
		{
			if (di.getValue(name)== null) 
			{
				if ( container != null) container.addChild(ob.getContainer());
				di.putValue(name, ob);
			}
			else
			{
				return di.getValue(name);
			}
			
			return ob;
		}
		
		public	static function Createitem(text:String,color:uint,align:String = TextFieldAutoSize.LEFT):TextField
		{
			var tx:TextField = new TextField();
			tx.background = true;
			tx.backgroundColor  = color;
			tx.text = text;
			tx.width = tx.textWidth;
			tx.height = tx.height;
			tx.selectable = false;
			tx.autoSize = align;
			return tx;
		}
		
		/**
		 * log Facade
		 * @param	msg
		 * @param	Level 用原本列舉有run time comiler error,用mapping方式
		 */
		public static function Log(msg:String):void
		{			
			Debug.trace(msg);			
		}
		
		/******************** 元件操作功能 ********************/
		
		//縮放
		public static function scaleXY(mc:MovieClip,x:Number = 1.0, y:Number = 1.0):void
		{
			mc.scaleX = x;
			mc.scaleY = y;
		}	
		
		//清空容器標記
		public static function ClearContainerChildren(Container:ViewComponentInterface):void
		{	
			Container.OnExit();			
		}		
		
		public static function Clear_ItemChildren(Container:DisplayObjectContainer):void
		{
			while (Container.numChildren > 0)
			{	
				Container.removeChildAt(0);
			}		
		}	
		
		public static function SetText(Container:TextField,Text:String):void
		{			
			Container.text = Text;
		}	
		
		//TODO move to time object
		public static function Set(Container:MovieClip,Text:Array):void
		{			
			Container.text = Text;
		}	
		
		public static function SetTime(listen:Function,sec:int):void
		{			
			setTimeout(listen, sec*1000);
		}	
		
		//滑鼠監聽
		public static function AddMouseListen(mc:DisplayObject,listen:Function):void
		{			
			mc.addEventListener(MouseEvent.ROLL_OUT,listen);
			mc.addEventListener(MouseEvent.ROLL_OVER, listen);
			mc.addEventListener(MouseEvent.MOUSE_DOWN, listen);
			mc.addEventListener(MouseEvent.MOUSE_UP,listen);
		}
		
		//list滑鼠監聽
		public static function AddMultiMouseListen(Itemlist:Array,listen:Function,mouseFrame:Array):void
		{
			var N:int =  Itemlist.length;
			for (var i:int = 0 ;  i < N ;  i++)
			{
				if ( mouseFrame[0] != 0) Itemlist[i].addEventListener(MouseEvent.ROLL_OUT, listen);
				if ( mouseFrame[1] != 0) Itemlist[i].addEventListener(MouseEvent.ROLL_OVER, listen);
				if ( mouseFrame[2] != 0) Itemlist[i].addEventListener(MouseEvent.MOUSE_DOWN, listen);
				if ( mouseFrame[3] != 0) Itemlist[i].addEventListener(MouseEvent.MOUSE_UP, listen);
			}			
		}
		
		//移除滑鼠監聽
		public static function ReMoveMouseListen(mc:DisplayObject,listen:Function):void
		{			
			mc.removeEventListener(MouseEvent.ROLL_OUT,listen);
			mc.removeEventListener(MouseEvent.ROLL_OVER, listen);
			mc.removeEventListener(MouseEvent.MOUSE_DOWN, listen);
			mc.removeEventListener(MouseEvent.MOUSE_UP,listen);
		}
		
		//list移除滑鼠監聽
		public static function ReMoveMultiMouseListen(Itemlist:Array,listen:Function,mouseFrame:Array):void
		{			
			var N:int =  Itemlist.length;
			for (var i:int = 0 ;  i < N ;  i++)
			{				
				if ( mouseFrame[0] != 0) Itemlist[i].removeEventListener(MouseEvent.ROLL_OUT,listen);
				if ( mouseFrame[1] != 0) Itemlist[i].removeEventListener(MouseEvent.ROLL_OVER, listen);
				if ( mouseFrame[2] != 0) Itemlist[i].removeEventListener(MouseEvent.MOUSE_DOWN,listen);
				if ( mouseFrame[3] != 0) Itemlist[i].removeEventListener(MouseEvent.MOUSE_UP, listen);
			}			
		}
		
		public static function GotoAndStop(e:Event,frame:int):void
		{			
			if ( frame == 0 )
			{				
				return;
			}			
			e.currentTarget.gotoAndStop(frame);		
		}
		
		public static function Frametype(type:int,customized:Array = null):Array
		{
			var BtnMouseFrame:Array;
			if ( type == MouseBehavior.ClickBtn) BtnMouseFrame = [0, 0, 2, 1];
			if ( type == MouseBehavior.SencetiveBtn) BtnMouseFrame = [1, 2, 2, 1];
			if (type == MouseBehavior.Customized ) BtnMouseFrame = customized;
			
			return BtnMouseFrame;
		}
		
		public static function easy_combination(list:Array, lenght:int):Array
		{
			var result:Array = [];
			var n:int = lenght -1;
			var fixelemnt:Array = [];
			for ( var i:int = 0; i < n; i++)
			{
				fixelemnt.push(list[i]);
			}
			
			var rest:Array = Get_restItem(list, fixelemnt);
			while (fixelemnt[0] != list[list.length - lenght])
			{
				
				//one set conbination
				for (i = 0; i < rest.length; i++)
				{
					var temp:Array = [];
					temp = fixelemnt.concat();
					if ( rest[i] <= fixelemnt[fixelemnt.length - 1]) continue;
					temp.push (rest[i]);
					result.push(temp);
				}
				rest.shift();
				
				//bound judge
				fixelemnt[fixelemnt.length - 1] ++;
				if ( fixelemnt[fixelemnt.length - 1] == list.length -1)
				{
					fixelemnt[fixelemnt.length - 1] --;
					averagedistance(fixelemnt);
					rest = Get_restItem(list, fixelemnt);					
				}
			}
			
			//last combi
			for (i = 0; i < rest.length; i++)
			{
				temp.length = 0;
				temp = fixelemnt.concat();
				if ( rest[i] <= fixelemnt[fixelemnt.length - 1]) continue;
				temp.push (rest[i]);
				result.push(temp);
			}
			
			return result;
		}
		
		/**
		 * 
		 * @param	arr [0,2,3,5]  -> [0,2,4,5] -> [0,3,4,5]-> [1,2,3,4]
		 */
		public static function averagedistance(arr:Array):void
		{			
			for ( var i:int = arr.length; i > 0 ; i --)
			{
				if ( parseInt(arr[i]) - parseInt(arr[i - 1] ) >= 2)
				{
					var k:int = parseInt( arr[i - 1]);
					k++;
					
					arr[i - 1] = k.toString();
					
					if ( i - 1 == 0)
					{
						for ( var j:int = 0; j < arr.length ; j++ ) arr[j] = k++;	
					}
					return;
				}				
			}
		}
		
		/**
		 * @param	origi [10,11,12,13,14]
		 * @param	own  [0,1,3]
		 * @return   [12,14]
		 */
		public static function Get_restItem(origi:Array,own:Array):Array
		{
			var rest_item:Array = [];
			var n:int = origi.length;
		  	for (var i:int = 0; i < n; i++)
			{				
				if (  own.indexOf(origi[i]) == -1 )  rest_item.push(origi[i]);
			}
			
			return rest_item;
		}
		
		//條件 0 base (flash為1base 影格 , CurFrame -1和 Frame + 1在於調整為0 base 
		//FrameCycle = 有幾格在循環
		//
		//複合按鍵用法 : click時還原成cycleFrame影格,做完後再shift到對應的RollOver
		public static function cycleFrame(CurFrame:int,FrameCycle:int):int
		{
			var Frame:int = CurFrame -1;
			Frame = ( Frame +1 ) % FrameCycle;
			return Frame + 1;
		}
		
		
		//回傳match完patten後的字串
		public static function Regex_CutPatten(str:String, pattern:RegExp):String
		{
			var sName:String = str;
			var pattern:RegExp = pattern;
			sName = sName.replace(pattern, "");
			return sName;
		}
		
		//檢查字串是否match 條件
		public static function Regex_MatchPatten(str:String, pattern:RegExp):Boolean
		{
			return pattern.test(str);
		}
		
		public static function Regex_Match(str:String, pattern:RegExp):Array
		{
			return str.match(pattern);			
		}
		
		//n個字後變...
		public static function SubString_len(str:String,len:Number):String
		{
			var newstr:String = str;
			if ( newstr.length > len)
			{
				newstr = newstr.substr(0, len) + "...";
			}
			return newstr;
		}
		
		//隨機亂數
		public static function Random(Range:int):int
		{
			return Math.random() * Range;
		}
		
		//補零到幾位數
		public static function Format(digit:int,lenth:int):String
		{
			var str:String = "";
			var digLenth:int = digit.toString().length;
			var len:int = lenth - digLenth;
			for ( var i:int = 0 ; i < len; i++)
			{
				str += "0";
			}
			return str + digit.toString();
		}
		
		//補零回傳陣列
		public static function arrFormat(digit:int,lenth:int):Array
		{
			var str:String = utilFun.Format(digit, lenth)
			// or string.charAt(index)
			return str.split("");
		}
		
		//將數字轉成會計符號計法  12345 -> 12,345
		public static function Accounting_Num(digit:int):String
		{
			var str:String = "";
			var arr:Array = [];
			
			var num:int = 0; 
			while (digit >= 10)
			{
				num = digit % 10;
				arr.push(num);
				digit /= 10;
			}
			arr.push(digit);
			
			for (var i:int = 0 ; i< arr.length ;  i++)
			{
				if ( i>0 &&  i  % 3 == 0) str = "," + str;
				
				str = arr[i] + str;
			}
			arr.length = 0;
			return str;
		}				
		
		/**
		 * 線性內插等距N個點
		 * @param	amount 第N個點的位置
		 * @param	start
		 * @param	end
		 * @return
		 */
		public static function NPointInterpolate( amount:Number , start:Number, end:Number ):Number 
		{
			if ( start == end ) 
			{
				return start ;
			}
			//return ( ( 1 - amount ) * start ) + ( amount * end ) ;
			return start + amount * (end - start)
		}
		
		
		public static function NPointInterpolateDistance( N:int , start:Number, end:Number ):Number
		{
			//正常版
			//var N1:Number =  NPointInterpolate(0/N, start, end);
			//var N2:Number =  NPointInterpolate(1/N, start, end);
			//return N2 - N1;
			
			//簡化版
			var N1:Number =  start + (1 / N) * (end - start)			
			return N1;
		}
		
	}

}