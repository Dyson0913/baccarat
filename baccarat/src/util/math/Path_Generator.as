package util.math 
{
	import Model.Model;
	import caurina.transitions.properties.CurveModifiers;
	import Model.valueObject.*;
	
	/**
	 * handle about Path
	 * @author hhg4092
	 */
	public class Path_Generator 
	{
		[Inject]
		public var _model:Model;		
		
		public function Path_Generator() 
		{
			
		}
		
		public function init():void
		{
			CurveModifiers.init();
			_model.putValue("path",[]);
			_model.putValue("player_pokerpath", [[1458.45, 154.15], [1097.2, 429.45], [766.25, 301.75]]);
			_model.putValue("banker_pokerpath", [[1458.45, 154.15], [1097.2, 429.45], [1077.25, 301.75]]);
		}
		
		[MessageHandler(type="Model.valueObject.ArrayObject",selector="recode_path")]
		public function path_update(arrob:ArrayObject):void
		{			
			_model.getValue("path").push(arrob.Value);			
		}
		
		public function get_recoder_path():Array
		{
			var path:Array = _model.getValue("path");
			//utilFun.Log("arr = " + path.length);
			var resultPath:Array = [];
			for (var i:int = 0; i < path.length; i++)
			{
				var arr:Array = path[i];
				var obj:Object = { x: arr[0], y: arr[1] };
				resultPath.push (obj);               
				
			}
			resultPath.unshift (resultPath [0]); 
			resultPath.push (resultPath [resultPath.length -1]);
			
			return resultPath;
		}
		
		public function get_Path_isometric(pathPoint:Array,xdiff:int):Array
		{
			var path:Array = [];
			for (var i:int = 0; i < pathPoint.length; i++)
			{
				var arr:Array = pathPoint[i];
				var obj:Object = { x: arr[0] + 30 * xdiff, y: arr[1] };
				path.push (obj);
			}       
			
		    //first and last point need to tweener
			path.unshift (path [0]); 
			path.push (path [path.length -1]);
			return path;
		}
		
		public function makeBesierArray (p:Array):Array
        {
            var bezier:Array = [];
            // convert all points between p[0] and p[last]
            for (var i:int = 1; i < p.length -2; i++)
            {
                var b1:Object = {}, b2:Object = {};
                // use p[0] properties to fill bezier array
                for (var prop:String in p[0])
                {
                    b1[prop] = -p[i -1][prop]/6 +p[i][prop] +p[i +1][prop]/6;
                    b2[prop] = +p[i][prop]/6 +p[i +1][prop] -p[i +2][prop]/6;
                }
                bezier.push (b1); bezier.push (b2);
            }			
            return bezier;
        }
	}

}