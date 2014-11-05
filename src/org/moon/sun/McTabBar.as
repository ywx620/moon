package org.moon.sun
{
	import org.moon.TabBar;
	import org.moon.event.MoonEvent;
	
	/**
	 * ...带Mc开头的组件都表示组件是按UI设置好的位置而不需要代码变动与再加载
	 * @author vinson
	 */
	public class McTabBar extends TabBar
	{
		public function McTabBar()
		{
			super();
		}
		public function addMcItem(button:McButton):void
		{
			var len:int=buttons.length;
			button.name="index-"+len;
			this.addChild(button);
			if(len>0) button.x=buttons[len-1].x+buttons[len-1].width+gad;
			button.newAddEventListener(MoonEvent.MOUSE_UP,onHandlerEvent);
			buttons.push(button);
		}
	}
}