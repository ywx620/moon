package org.moon.basic
{
	import flash.utils.Dictionary;
	
	import org.moon.utils.MoonConst;

	/**
	 * ...
	 * @author vinson
	 */
	public class BasicBar extends BasicContent
	{
		protected var buttonDic:Dictionary=new Dictionary;
		protected var buttons:Vector.<BasicButton>=new Vector.<BasicButton>;
		protected var _gad:int=5;
		protected var modelType:String="";
		protected var _barIndex:int;
		protected var _data:Array;
		public function BasicBar()
		{
			_width=80;
			_height=20;
			super();
		}
		/**设置间隔*/
		public function get gad():int
		{
			return _gad;
		}
		
		public function set gad(value:int):void
		{
			_gad = value;
		}
		/**设置皮肤*/
		override public function setSkin(type:String, skin:Object,param:Object=null):void
		{
			var types:Array=type.split("-");
			var buttonType:String=types[1];
			var statcType:String=types[2];
			var bButton:BasicButton=buttonDic[buttonType];
			if(types[0]==modelType){
				if(statcType=="up"){
					bButton.setSkin(MoonConst.BUTTON_UP,skin,param);
				}else if(statcType=="down"){
					bButton.setSkin(MoonConst.BUTTON_DOWN,skin,param);
				}else if(statcType=="over"){
					bButton.setSkin(MoonConst.BUTTON_OVER,skin,param);
				}else if(statcType=="movieclip"){
					bButton.setSkin(MoonConst.BUTTON_MOVIECLIP,skin,param);
				}
			}
		}
		override public function dispose():void
		{
			var i:int=0;
			if(buttons){
				for(i=0;i<buttons.length;i++){
					buttons[i].dispose();
					buttons[i]=null;
				}
				buttons.length=0;
				buttons=null;
			}
			super.dispose();
		}

		/**单个选中的值*/
		public function get barIndex():int
		{
			return _barIndex;
		}

		/**
		 * @private
		 */
		public function set barIndex(value:int):void
		{
			_barIndex = value;
		}

		/**类型["list1","list2","list3","list4"]*/
		public function get data():Array
		{
			return _data;
		}
		
		/**
		 * @private
		 */
		public function set data(value:Array):void
		{
			_data = value;
		}
	}
}