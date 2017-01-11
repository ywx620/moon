package org.moon.sun
{
	import org.moon.event.MoonEvent;
	
	/**
	 * ...2015-6-19
	 * @author vinson
	 */
	public class McRLPageBar extends McNumberBar
	{
		public function McRLPageBar()
		{
			super();
		}
		override public function addMcItem(button:McButton,type:String):void
		{
			var len:int=buttons.length;
			button.name="index-"+len;
			button.addEvent();
			button.isButtonModel=true;
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
			this.newDispatchEvent(CHANGE,this._currentPage);
		}
		/**初始化左右页按钮*/
		public function initBtnRight():void
		{
			if(this._currentPage==1){//如果当前页是第一页,左按钮不能点
				buttonIsEnabled(this.buttonUp,false);
			}
			if(this._totalPage<2||this._totalPage==this._currentPage){//如果总页数小于2或等于当前页数,右按钮不能点
				buttonIsEnabled(this.buttonDown,false);
			}
		}
	}
}