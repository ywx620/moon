package org.moon.event
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author vinson
	 */
	public class MoonEvent extends EventDispatcher
	{
		//button event
		public static const MOUSE_OVER:String="event-over";
		public static const MOUSE_OUT:String="event-out";
		public static const MOUSE_DOWN:String="event-down";
		public static const MOUSE_UP:String="event-up";
		
		//tabbar event
		public static const CHANGE:String="change";
		
		public var currentTarget:Object;
		public var type:String;
		public var data:Object;
		public function MoonEvent(target:IEventDispatcher=null)
		{
			super(target);
		}
	}
}