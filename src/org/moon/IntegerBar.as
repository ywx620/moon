package org.moon 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import org.moon.basic.BasicBar;
	import org.moon.utils.MoonConst;
	import org.moon.utils.NameList;
	/**
	 * ...整数字
	 * @author vinson
	 */
	public class IntegerBar extends BasicBar 
	{
		private var _number:Number;
		public var bitmapdatas:Array;
		public function IntegerBar()
		{
			
		}
		override protected function initialization():void
		{
			if (bitmapdatas == null) {
				bitmapdatas = new Array(10);
				for(var model:String in NameList.list){
					if(model==MoonConst.MODEL_INTEGER){
						for(var type:String in NameList.list[model]){
							var skin:BitmapData = NameList.list[model][type];
							if(type==MoonConst.INTEGER_0)		bitmapdatas[0]=skin;
							else if(type==MoonConst.INTEGER_1)	bitmapdatas[1]=skin;
							else if(type==MoonConst.INTEGER_2)	bitmapdatas[2]=skin;
							else if(type==MoonConst.INTEGER_3)	bitmapdatas[3]=skin;
							else if(type==MoonConst.INTEGER_4)	bitmapdatas[4]=skin;
							else if(type==MoonConst.INTEGER_5)	bitmapdatas[5]=skin;
							else if(type==MoonConst.INTEGER_6)	bitmapdatas[6]=skin;
							else if(type==MoonConst.INTEGER_7)	bitmapdatas[7]=skin;
							else if(type==MoonConst.INTEGER_8)	bitmapdatas[8]=skin;
							else if(type==MoonConst.INTEGER_9)	bitmapdatas[9]=skin;
						}
						break;
					}
				}
			}
		}
		public function get number():Number 
		{
			return _number;
		}
		
		public function set number(value:Number):void 
		{
			this.removeChildAll();
			_number = value;
			var numStr:String = value.toString();
			var i:int=0;
			while (i < numStr.length) {
				var num:int=int(numStr.substr(i, 1));
				var bitmap:Bitmap = new Bitmap(bitmapdatas[num]);
				this.addChild(bitmap);
				bitmap.x += (bitmap.width + gad) * i;
				i++;
			}
		}
	}

}