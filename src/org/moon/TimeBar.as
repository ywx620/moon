package org.moon 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import org.moon.basic.BasicBar;
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
			var array:Array = getTimeArray(value);
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
		private function getTimeArray(str:*):Array
		{
			var value:int=getTimeNumber(str);
			if(value<=0) return [];
			var day:int=int(value/(24*60*60));
			var hours:int=int((value-(day*24*60*60))/3600);
			var minute:int=int((value-(day*24*60*60)-(hours*3600))/60);
			var second:int=int((value-(day*24*60*60)-(hours*3600)-minute*60));
			return [hours, minute, second];
		}
		private function getTimeNumber(str:*):int
		{
			var array:Array=String(str).split("-")
			if(array.length==2){
				str=array[0]+" "+array[1];
			}else if(array.length==3){
				str=array[0]+"/"+array[1]+"/"+array[2];
			}
			var currentData:Date=new Date();
			var endDate:Date=new Date(str);
			var value:int=(endDate.getTime()-currentData.getTime())/1000;
			return value
		}
	}
}