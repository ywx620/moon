package org.moon.utils.time
{
	public interface ITime
	{
		function start():void;
		function set time(value:uint):void;
		function get time():uint;
		function set name(value:String):void;
		function get name():String;
		function set showNum(value:uint):void;
		function get showNum():uint;
		function setTimeStart(value:uint):void;
		function setBackFunction(value:Function):void
		function dispose():void
	}
}