package util 
{
	import caurina.transitions.Tweener;
	import flash.display.MovieClip;
	
	/**
	 * poker regular function
	 * @author hhg4092
	 */
	public class pokerUtil 
	{
		
		public function pokerUtil() 
		{
			
		}
		
		public static function hidepoker(mc:MovieClip, idx:int, data:Array):void
		{			
			mc.visible = false;
		}	
		
		public static function showPoker(mc:MovieClip, idx:int, data:Array):void
		{			
			var idx:int = pokerUtil.pokerTrans(data[idx])			
			utilFun.scaleXY(mc, 0.8, 0.8);
			mc.gotoAndStop(idx);
		}	
		
		public static function pokerTrans(strpoker:String):int
		{			
			var point:String = strpoker.substr(0, 1);
			var color:String = strpoker.substr(1, 1);
			
			var myidx:int = 0;
			
			if ( color == "d") myidx = 1;
			if ( color == "h") myidx = 2;
			if ( color == "s") myidx = 3;
			if ( color == "c") myidx = 4;
				
			if ( point == "i") myidx += (9*4);
			else if ( point == "j") myidx += (10*4);
			else if ( point == "q") myidx += (11*4);
			else if ( point == "k") myidx += (12*4);
			else 	myidx +=  (parseInt(point) - 1) * 4;
			
			return myidx;
		}
		
		public static function newnew_judge(pok:Array):Array
		{		
			//var pok:Array = ["kc", "1h", "jd", "9h", "jh"];
			//var pok:Array = ["3c", "4h", "kd", "3h", "1h"];
			var po:Array = ["0", "1", "2", "3", "4"];
			
			var point:Array = pokerUtil.get_Point(pok);
			var totalPoint:int = pokerUtil.Get_Mapping_Value(po, pok);			
			
			var arr:Array = utilFun.easy_combination(po, 3);
			var answer:Array = [];
			var restmax:int = 0;
			for (var i:int = 0; i < arr.length; i++)
			{
				var total:int = 0;
				var rest:int = 0;
				var cobination:Array = arr[i];
				//utilFun.Log("conbi=" + cobination) ;
				total = Get_Mapping_Value(cobination, point);
				rest = totalPoint - total;
                //utilFun.Log( "list:" + cobination + " = " + total  +" rest ="+ rest);
				total %= 10;
				rest %= 10;
				if ( total == 0)
				{
					if ( rest >= restmax )
					{
						restmax = rest;
						answer.length = 0;
						answer.push.apply(answer, cobination);						
					}
				}
			}
			
			//utilFun.Log( "answer:" + answer);
			
			if ( answer.length !=0)
			{				
				answer.push.apply(answer, pokerUtil.Get_restItem(po, answer));
			}
			else answer = ["0", "1", "2", "3", "4"];
			
			//utilFun.Log( "final answer:" + answer);
			return answer;
		}
		
		public static function poer_shift(pokerlist:Array,best3:Array):void
		{
			var position:Array = [];
			for (var i:int = 0; i < pokerlist.length; i++)
			{
				var shift:int= 0;
				if ( i == 1 ) shift = 20;
				if ( i == 2) shift = 40;
				if ( i == 3) shift = 20;
				if ( i == 4) shift = 40;
				position.push(pokerlist[i].x -shift);
			}
			
			for (var k:int = 0; k < pokerlist.length; k++)
			{
				Tweener.addTween(pokerlist[best3[k]], { x:position[k], transition:"easeOutQuint", time:1 } );
			}
		}
		
		/**
		 * @param	idxList  = [1,2,3]
		 * @param	mapping = [10,11,12,13,14] 
		 * @return   11+12+13
		 */
		public static function Get_Mapping_Value(idxList:Array,mapping:Array):int
		{
			var n:int = idxList.length;
			var total:int = 0;
			for (var i:int = 0;  i < n; i++)
			{
				total += mapping[idxList[i]];
			}
			return total;
		}
		
		/**
		 * @param	origi [10,11,12,13,14]
		 * @param	own  [0,1,3]
		 * @return   [12,14]
		 */
		public static function Get_restItem(origi:Array,own:Array):Array
		{
			var rest_item:Array = [];
			var n:int = origi.length
		  	for (var i:int = 0; i < n; i++)
			{
				if (  own.indexOf(origi[i]) == -1 ) rest_item.push(i);
			}
			
			return rest_item;
		}
		
		public static function get_Point(poke:Array):Array
		{
			var point:Array = [];
			var n:int = poke.length;
			for (var i:int = 0; i < n; i++)
			{
				point.push( pokerUtil.get_Baccarat_Point(poke[i]) );				
			}
			return point;
		}
		
		public static function get_Baccarat_Point(poke:String):int
		{
			var point:String = poke.substr(0, 1);
			
			if ( point == "i" ||  point == "j" || point == "q" || point == "k") return 10;			
			return parseInt(point);			
		}
		
		public static function countPoint(poke:Array):int
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