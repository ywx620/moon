package org.moon.sun
{
	import org.moon.PageBar;
	import org.moon.basic.BasicButton;
	import org.moon.event.MoonEvent;
	
	/**
	 * ...
	 * @author vinson
	 */
	public class McPageBar extends PageBar
	{
		public function McPageBar()
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
		/**更新页码*/
		override protected function updatePage():void
		{
			buttonIsEnabled(this.buttonUp,true);
			buttonIsEnabled(this.buttonDown,true);
			if(_totalPage<=1){
				buttonIsEnabled(this.buttonUp,false);
				buttonIsEnabled(this.buttonDown,false);
			}else{
				if(this._currentPage==1)						buttonIsEnabled(this.buttonUp,false);
				else if(this._currentPage==this._totalPage)		buttonIsEnabled(this.buttonDown,false);
			}
		}
		override protected function render():void
		{
			
		}
		override public function set currentPage(value:int):void
		{
			_currentPage = value;
			updatePage();
		}
		override public function dispose():void
		{
			if(buttonUp.buttonmc){
				buttonUp.buttonmc.parent.removeChild(buttonUp.buttonmc);
			}
			if(buttonDown.buttonmc){
				buttonDown.buttonmc.parent.removeChild(buttonDown.buttonmc);
			}
			super.dispose();
		}
	}
}