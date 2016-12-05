package org.moon.utils.time
{
	import flash.events.TimerEvent;
	/**
	 * ...2016-11-17
	 * @author vinson
	 * 计时器产品
	 */
	public class TimeCountUp extends TimeAbstract
	{
		public function TimeCountUp()
		{
			super();
		}
		override protected function onTimer(event:TimerEvent=null):void
		{
			var value:uint=_time++;
			var show:String=getTimeFormatByNum(value,":",_showNum);
			var data:Object={value:value,show:show}
			if(backfunction!=null)	backfunction(data);
		}
	}
}