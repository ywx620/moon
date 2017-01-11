package org.moon.sun
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import org.moon.ScrollBar;
	import org.moon.ScrollTextBar;
	import org.moon.basic.BasicButton;
	import org.moon.event.MoonEvent;
	import org.moon.utils.MoonConst;
	import org.moon.utils.NameList;
	import org.moon.utils.Scale9Image;

	/**
	 * ...
	 * @author vinson
	 */
	public class McScrollTextBar extends ScrollTextBar
	{
		private var isStartDrag:Boolean=false;
		public function McScrollTextBar()
		{
			super();
		}
		public function addMcItem(button:McButton,type:String):void
		{
			button.addChild(button.buttonmc);
			switch(type){
				case ScrollBar.UP:
					buttonUp=button;
					break;
				case ScrollBar.DOWN:
					buttonDown=button;
					break;
				case ScrollBar.BAR:
					buttonBar=button;
					break;
			}
		}
		public function addBody(s9i:Scale9Image):void
		{
			buttonBody.setSkin(MoonConst.SCROLL_BODY_OVER,s9i);
			buttonBody.setSkin(MoonConst.SCROLL_BODY_DOWN,s9i);
			buttonBody.setSkin(MoonConst.SCROLL_BODY_UP,s9i);
		}
		override protected function render():void
		{
			//渲染按钮
			if(buttonBar.hasSkinData==false){
				for(var model:String in NameList.list){
					if(model==MoonConst.MODEL_SCROLL){
						for(var type:String in NameList.list[model]){
							setSkin(type,NameList.list[model][type],NameList.param[model][type]);
						}
						break;
					}
				}
			}
			var bodyHeight:Number=_scrollHeight-buttonUp.height*2;
			buttonBody.setSize(-1,bodyHeight);
			
			buttonBar.y=buttonBody.y=buttonUp.height;
			buttonDown.y=buttonBody.y+buttonBody.height;
			for each(var button:BasicButton in buttons){
				this.addChild(button);
				button.newAddEventListener(MoonEvent.MOUSE_UP,onMouseHandler);
				button.newAddEventListener(MoonEvent.MOUSE_DOWN,onMouseHandler);
			}
			scrollBarHeight=buttonUp.height+buttonBody.height+buttonDown.height;
			scrollBarMoveHeight=buttonBody.height - buttonBar.height;
			
			scrollTextTarget.addEventListener(Event.SCROLL, onScroll);
			updateButtonBar();
		}
		public function resetSize(h:int):void
		{
			scrollHeight=h;
			var bodyHeight:Number=_scrollHeight-buttonUp.height*2;
			buttonBody.setSize(-1,bodyHeight);
			
			buttonDown.y=buttonBody.y+buttonBody.height;
			
			updateButtonBar();
			if((buttonBar.y+buttonBar.height)>buttonDown.y){
				//如果重新设置滚动条的大小，bar跑歪了，需要强制拉回来。
				buttonBar.y=buttonDown.y-buttonBar.height;
			}
		}
		override public function set scrollTextTarget(value:TextField):void
		{
			_scrollTextTarget = value;
		}
		override protected function onMouseUp(event:MouseEvent):void
		{
			isStartDrag=false;
			super.onMouseUp(event);
		}
		/**滚动条移动*/
		override protected function contentMoveFree():void
		{
			isStartDrag=true;
			super.contentMoveFree();
		}
		/**文本滚动*/
		private var txtNum:int=0;
		override protected function onScroll(event:Event):void
		{
			if(isStartDrag==false){
				super.onScroll(event)
			}
			if(scrollTextTarget.length!=txtNum){
				txtNum=scrollTextTarget.length
				updateButtonBar();
			}
			
		}
	}
}