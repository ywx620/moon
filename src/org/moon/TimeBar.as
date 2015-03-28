package org.moon 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import org.moon.basic.BasicBar;
	import org.moon.utils.Unify;
	import org.moon.utils.MoonConst;
	import org.moon.utils.NameList;
	/**
	 * ...目前只是个倒计时显示
	 * @author vinson
	 */
	public class TimeBar extends BasicBar 
	{
		private var colons:Vector.<Bitmap>;
		private var nums:Vector.<IntegerBar>;
		private var _number:Number;
		public var type:int = 0;
		/**00:00:00 时:分:秒*/
		public static const HMS:int = 0;
		/**00:00 时:分*/
		public static const HM:int = 1;
		/**00:00 分:秒*/
		public static const MS:int = 2;
		public function TimeBar() 
		{
			
		}
		override protected function initialization():void
		{
			nums = new Vector.<IntegerBar>;
			colons = new Vector.<Bitmap>;
			for(var model:String in NameList.list){
				if(model==MoonConst.MODEL_TIME){
					for(var type:String in NameList.list[model]){
						var skin:BitmapData = NameList.list[model][type];
						colons.push(new Bitmap(skin),new Bitmap(skin));
					}
					break;
				}
			}
			for (var i:int = 0; i < 3; i++ ) {
				var num:IntegerBar = new IntegerBar;
				num.digit = 2;
				nums.push(num)
			}
		}
		public function set number(value:Number):void
		{
			_number = value;
			var array:Array = Unify.getTimeArray(value);
			switch(type) {
				case HMS:
					break;
				case HM:
					array.splice(2, 1);
					colons.shift();
					nums.shift();
					break;
				case MS:
					array.shift();
					colons.shift();
					nums.shift();
					break;
			}
			showTime(array);
		}
		private function showTime(array:Array):void
		{
			var w:int = 0;
			for (var i:int = 0; i < array.length; i++ ) {
				var num:IntegerBar = nums[i];
				this.addChild(num);
				num.number = array[i];
				num.x = w;
				if (i < colons.length ) {
					w += num.width+2;
					var colon:Bitmap = colons[i];
					this.addChild(colon);
					colon.x = w;
					colon.y = 10;
					w += colon.width+2;
				}
			}
		}
	}
}