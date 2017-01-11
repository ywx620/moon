package org.moon.sun
{
	import flash.events.Event;
	import flash.text.TextField;
	
	import org.moon.NumberBar;
	import org.moon.event.MoonEvent;
	
	/**
	 * ...上下页可以加减数字，文本可以自由输入数字
	 * @author vinson
	 */
	public class McNumberBar extends NumberBar
	{
		public function McNumberBar()
		{
			super();
		}
		override protected function initSkin():void
		{
			
		}
		public function addMcItem(button:McButton,type:String):void
		{
			var len:int=buttons.length;
			button.name="index-"+len;
			button.addEvent();
			button.newAddEventListener(MoonEvent.MOUSE_UP,onMouseHandler);
			buttons.push(button);
			if(type=="add"){
				buttonDown=button;
				buttonDic[DOWN]=buttonDown;
			}else{
				buttonUp=button;
				buttonDic[UP]=buttonUp;
			}
		}
		public function addTextItem(txt:TextField):void
		{
			textField=txt;
			textField.addEventListener(Event.CHANGE,onTextChange);
		}
		
		public function removeButtonmc():void
		{
			if(buttonUp.buttonmc){
				buttonUp.buttonmc.parent.removeChild(buttonUp.buttonmc);
				buttonUp.buttonmc=null;
			}
			if(buttonDown.buttonmc){
				buttonDown.buttonmc.parent.removeChild(buttonDown.buttonmc);
				buttonDown.buttonmc=null;
			}
		}
		override protected function render():void
		{
			
		}
	}
}