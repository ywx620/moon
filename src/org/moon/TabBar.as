package org.moon
{	
	import org.moon.basic.BasicBar;
	import org.moon.basic.BasicButton;
	import org.moon.event.MoonEvent;
	import org.moon.utils.MoonConst;

	/**
	 * ...tabbar可使用两种方式加子按钮
	 * 使用addItem()皮肤必须是分开一个个的
	 * 两种只能二选一
	 * @author vinson
	 */
	public class TabBar extends BasicBar
	{
		public function TabBar()
		{
			super();
		}
		public function addItem(bButton:BasicButton):void
		{
			var button:BasicButton=bButton;
			var len:int=buttons.length;
			button.name="index-"+len;
			this.addChild(button);
			if(len>0) button.x=buttons[len-1].x+buttons[len-1].width+gad;
			button.newAddEventListener(MoonEvent.MOUSE_UP,onHandlerEvent);
			buttons.push(button);
		}
		
		protected function onHandlerEvent(event:MoonEvent):void
		{
			var button:BasicButton=event.currentTarget as BasicButton;
			selectButton(buttons.indexOf(button));
		}
		
		private function selectButton(index:int):void
		{
			if(index>=buttons.length){
				trace("====================索引超过========================");
				return;
			}
			var button:BasicButton=buttons[index];
			var i:int=0;
			for(i=0;i<buttons.length;i++){
				buttons[i].removeEvent();
				buttons[i].addEvent();
				buttons[i].isButtonModel=true;
				buttons[i].currentStatc=MoonConst.BUTTON_UP;
			}
			button.removeEvent();
			button.isButtonModel=false;
			button.currentStatc=MoonConst.BUTTON_DOWN;
			_barIndex=int(button.name.split("-")[1]);
			this.newDispatchEvent(MoonEvent.CHANGE,barIndex);
		}
		override public function set barIndex(value:int):void
		{
			_barIndex = value;
			if(buttons.length>0) selectButton(_barIndex);
			
		}
		
		override public function dispose():void
		{
			var i:int=0;
			if(buttons){
				for(i=0;i<buttons.length;i++){
					buttons[i].newRemoveEventListener(MoonEvent.MOUSE_UP,onHandlerEvent);
					buttons[i].dispose();
					buttons[i]=null;
				}
				buttons.length=0;
				buttons=null;
			}
			super.dispose();
		}

	}
}