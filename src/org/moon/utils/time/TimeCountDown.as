package org.moon.utils.time
{
	import flash.events.Event;
	import flash.events.TimerEvent;

	/**
	 * ...2016-11-17
	 * @author vinson
	 * 倒计时产品
	 */
	public class TimeCountDown extends TimeAbstract
	{
		public function TimeCountDown()
		{
			super();
		}
		override protected function onTimer(event:TimerEvent=null):void
		{
			var value:uint=_time--;
			var show:String=getTimeFormatByNum(value,":",_showNum);
			var data:Object={value:value,show:show}
			backfunction(data);
			if(value==0){
				this.dispatchEvent(new Event(Event.COMPLETE));
			}
		}
	}
}