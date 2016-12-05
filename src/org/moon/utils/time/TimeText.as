package org.moon.utils.time
{
	import flash.text.TextField;

	/**
	 * ...2016-11-30
	 * @author vinson
	 */
	public class TimeText
	{
		private var  time:ITime;
		private var _name:String
		private var _text:TextField;
		private var _number:int;
		private var _describe:String;
		public function TimeText(name:String,text:TextField,number:int,describe:String)
		{
			_name=name;
			_text=text;
			_number=number;
			_describe=describe;
		}
		public function get downTime():int
		{
			if(time) return time.time;
			return 0;
		}
		public function checkTime():void
		{
			time=TimeFactory.getIns().getContentTime(_name);
			if(time){
				time.setBackFunction(onLoop);
				time.start();
			}
		}
		private function onLoop(data:Object):void
		{
			_text.text=_describe+"("+data.show+")";
			if(data.value==0){
				_text.text=_describe;
				time=null;
			}
		}
		public function setTime():void
		{
			time=TimeFactory.getIns().createTime(_name);
			time.setBackFunction(onLoop)
			if(time.time==0){
				time.time=_number;
				time.start();
			}
		}

		public function get name():String
		{
			return _name;
		}

		public function get text():TextField
		{
			return _text;
		}

		public function set text(value:TextField):void
		{
			_text = value;
		}
	}
}