package org.moon
{
	import org.moon.basic.BasicContent;
	import org.moon.basic.BasicMcButton;
	import org.moon.event.MoonEvent;
	/**
	 * ...
	 * @author vinson
	 */
	public class TabMcBar extends BasicContent
	{
		private var buttons:Vector.<BasicMcButton>=new Vector.<BasicMcButton>;
		private var _tabbarIndex:int;
		private var _gad:int=5;
		public var isAdd:Boolean=false;
		public function TabMcBar()
		{
			super();
		}
		public function addMcItem(button:BasicMcButton):void
		{
			var len:int=buttons.length;
			button.name="index-"+len;
			if(isAdd){
				this.addChild(button);
				if(len>0) button.x=buttons[len-1].x+buttons[len-1].width+gad;
			}
			button.newAddEventListener(MoonEvent.MOUSE_UP,onHandlerEvent);
			button.addEvent();
			button.isButtonModel=true;
			buttons.push(button);
		}
		/**事件*/
		protected function onHandlerEvent(event:MoonEvent):void
		{
			var button:BasicMcButton=event.currentTarget as BasicMcButton;
			selectButton(buttons.indexOf(button));
		}
		/**选择哪个按钮*/
		protected function selectButton(index:int):void
		{
			if(index>=buttons.length){
				trace("====================索引超过========================");
				return;
			}
			var button:BasicMcButton=buttons[index];
			var i:int=0;
			for(i=0;i<buttons.length;i++){
				buttons[i].removeEvent();
				buttons[i].addEvent();
				buttons[i].isButtonModel=true;
				buttons[i].buttonmc.gotoAndStop(1);
			}
			button.removeEvent();
			button.isButtonModel=false;
			buttons[index].buttonmc.gotoAndStop(2);
			_tabbarIndex=int(button.name.split("-")[1]);
			this.newDispatchEvent(MoonEvent.CHANGE,this.tabbarIndex);
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
		/**设置选择第几个*/
		public function get tabbarIndex():int
		{
			return _tabbarIndex;
		}
		
		public function set tabbarIndex(value:int):void
		{
			_tabbarIndex = value;
			if(buttons.length>0) selectButton(_tabbarIndex);
		}
		
		override public function dispose():void
		{
			var i:int=0;
			for(i=0;i<buttons.length;i++){
				buttons[i].dispose();
				buttons[i]=null;
			}
			buttons.length=0;
			buttons=null;
		}
		
	}
}