package org.moon.utils.time
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...2016-11-18
	 * @author vinson
	 * 抽象时间产品
	 */
	public class TimeAbstract extends EventDispatcher implements ITime
	{
		protected var _time:uint=0;
		protected var _name:String;
		protected var _showNum:uint=1;
		protected var backfunction:Function;
		protected var timer:Timer;
		public function TimeAbstract(target:IEventDispatcher=null)
		{
			super(target);
		}
		private function removeTime():void
		{
			if(timer){
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER,onTimer);
				timer=null;
			}
		}
		private function createTime():void
		{
			removeTime();
			timer=new Timer(1000,_time);
			timer.addEventListener(TimerEvent.TIMER,onTimer);
		}
		/**把数字转换成时间格式,showNum为3时00:00:00,为2时00:00,为1时00*/
		protected function getTimeFormatByNum(num:Number,type:String=":",showNum:int=3):String
		{
			var s:String;
			var hour:String;
			var minute:String;
			var second:String;
			if(showNum==1){
				second = numberFormat(num);
				return second;
			}else if(showNum==2){
				minute = numberFormat((num/60));
				second = numberFormat(num%60);
				return minute+type+second;
			}else{
				hour = numberFormat(num/60/60>>0);
				minute = numberFormat((num/60) % 60);
				second = numberFormat(num%60);
				return hour+type+minute+type+second;
			}
		}
		/**数字格式，把小于10的数在前面加个0*/
		protected function numberFormat(num:int):String
		{
			if(num>=10)			return String(num);
			else				return "0"+num;
		}
		protected function onTimer(event:TimerEvent=null):void
		{
			throw new Error("抽像类不能实例化,必须使用子类实例化")
		}
		/**设置开始计时并且开始计时*/
		public function setTimeStart(vaule:uint):void
		{
			time=10;
			start();
		}
		/**开始计时*/
		public function start():void
		{
			timer.start();
			onTimer();
		}
		
		public function get time():uint
		{
			return _time;
		}
		/**设置开始计时*/
		public function set time(value:uint):void
		{
			_time = value;
			createTime();
		}
		/**表示显示几组数,1(00),2(00:00),3(00:00:00)*/
		public function get showNum():uint
		{
			return _showNum;
		}
		
		public function set showNum(value:uint):void
		{
			_showNum = value;
		}
		public function setBackFunction(value:Function):void
		{
			backfunction=value;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function set name(value:String):void
		{
			_name = value;
		}
		
		public function dispose():void
		{
			removeTime();
		}
	}
}

