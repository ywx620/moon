package org.moon.utils
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;

	/**
	 * ...
	 * @author vinson
	 */
	public class NameList
	{
		private static var _list:Dictionary=new Dictionary;
		private static var _param:Dictionary=new Dictionary;
		public static function add(moduleName:String,skinName:String,skinImage:BitmapData,param:Object=null):void
		{
			if(_list[moduleName]==null){
				_list[moduleName]=new Dictionary;
				_param[moduleName]=new Dictionary;
			}
			_list[moduleName][skinName]=skinImage;
			_param[moduleName][skinName]=param;
		}

		public static function get list():Dictionary
		{
			return _list;
		}

		public static function get param():Dictionary
		{
			return _param;
		}


	}
}