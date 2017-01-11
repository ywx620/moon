package org.moon.sun
{
	import flash.display.MovieClip;
	
	import org.moon.TabBar;
	import org.moon.basic.BasicButton;
	import org.moon.event.MoonEvent;
	
	/**
	 * ...带Mc开头的组件都表示组件是按UI设置好的位置而不需要代码变动与再加载
	 * @author vinson
	 */
	public class McTabBar extends TabBar
	{
		private var btnWidth:int=0;
		public function McTabBar()
		{
			super();
		}
		public function addMcItem(button:McButton):void
		{
			var len:int=buttons.length;
			button.name="index-"+len;
			button.newAddEventListener(MoonEvent.MOUSE_UP,onHandlerEvent);
			buttons.push(button);
		}
		/**数字按钮tabbar*/
		public function addClassItem(btnClass:Class,btnIcon:Class,btnNum:int=2):void
		{
			if(btnNum>1){
				for(var i:int=0;i<btnNum;i++){
					var button:McButton=new McButton();
					var btnmc:MovieClip=new btnClass;
					var iconmc:MovieClip=new btnIcon;
					iconmc.gotoAndStop(i+1);
					button.buttonmc=btnmc;
					button.addIcon(iconmc);
					button.name="index-"+i;
					btnWidth=btnmc.width+gad;
					btnmc.x=btnWidth*i;
					button.newAddEventListener(MoonEvent.MOUSE_UP,onHandlerEvent);
					buttons.push(button);
					this.addChild(btnmc);
				}
			}
		}
		public function removeBtnEvent(index:int):void
		{
			var mcBtn:McButton=getMcButtonByIndex(index);
			mcBtn.newRemoveEventListener(MoonEvent.MOUSE_UP,onHandlerEvent);
		}
		/**设置组件中心位置*/
		public function setCenterMove(x:int,y:int):void
		{
			var wid:int=btnWidth*buttons.length;
			this.x=x-(wid>>1);
			this.y=y;
		}
		public function getButtons():Vector.<BasicButton>
		{
			return buttons;
		}
		public function getMcButtonByIndex(index:int):McButton
		{
			return buttons[index] as McButton;
		}
		public function get totalPage():int
		{
			return buttons.length;
		}
	}
}