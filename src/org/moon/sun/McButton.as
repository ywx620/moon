package org.moon.sun
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	
	import org.moon.basic.BasicButton;
	import org.moon.utils.MoonConst;
	
	/**
	 * ...带Mc开头的组件都表示组件是按UI设置好的位置而不需要代码变动与再加载
	 * @author vinson
	 */
	public class McButton extends BasicButton
	{
		public function McButton()
		{
			super();
		}
		override protected function initialization():void
		{
			//必须空的复写在这里
		}
		override protected function set currentFrame(value:int):void
		{
			if(buttonmc){
				if(value<=3){
					if(buttonmc.totalFrames==2){//可能按钮只有两帧
						if(value==3) value=2;
					}
					if(buttonmc.totalFrames==1){//可能按钮只有一帧
						if(value>=2) value=1;
					}
					buttonmc.gotoAndStop(value);
				}
			}
		}
		/**增加事件*/
		override public function addEvent():void
		{
			buttonmc.addEventListener(MouseEvent.MOUSE_OVER,onMouseHanlder);
			buttonmc.addEventListener(MouseEvent.MOUSE_OUT,onMouseHanlder);
			buttonmc.addEventListener(MouseEvent.MOUSE_DOWN,onMouseHanlder);
			buttonmc.addEventListener(MouseEvent.MOUSE_UP,onMouseHanlder);
		}
		/**删除事件*/
		override public function removeEvent():void
		{
			if(buttonmc){
				buttonmc.removeEventListener(MouseEvent.MOUSE_OVER,onMouseHanlder);
				buttonmc.removeEventListener(MouseEvent.MOUSE_OUT,onMouseHanlder);
				buttonmc.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseHanlder);
				buttonmc.removeEventListener(MouseEvent.MOUSE_UP,onMouseHanlder);
			}
		}
		/**增加ICON*/
		override public function addIcon(icon:DisplayObject,x:int=0,y:int=0):void
		{
			this.icon=icon;
			buttonmc.addChild(icon);
			icon.x=x;icon.y=y;
		}
		/**删除ICON*/
		override public function removeIcon():void
		{
			if(icon&&buttonmc.contains(icon)){
				buttonmc.removeChild(icon);
				icon=null;
			}
		}
		override public function get isButtonModel():Boolean
		{
			return _isButtonModel;
		}
		
		override public function set isButtonModel(value:Boolean):void
		{
			buttonmc.useHandCursor=value;
			buttonmc.buttonMode=value;
			buttonmc.mouseEnabled=value;
			buttonmc.mouseChildren=value;
			_isButtonModel = value;
		}
		override public function buttonIsEnabled(boo:Boolean):void
		{
			isButtonModel=boo;
			if(boo==true){
				buttonmc.filters.length=0;
				buttonmc.filters=null;
			}else{
				var matrix:Array=[0.3086, 0.6094, 0.0820, 0, 0,  
					0.3086, 0.6094, 0.0820, 0, 0,  
					0.3086, 0.6094, 0.0820, 0, 0,  
					0,      0,      0,      1, 0];
				var myfilter:ColorMatrixFilter=new ColorMatrixFilter(matrix);
				buttonmc.filters=[myfilter];
			}
		}
		override public function set currentStatc(value:String):void
		{
			_currentStatc = value;
			if(value==MoonConst.BUTTON_UP){
				currentFrame=1;
			}else if(value==MoonConst.BUTTON_OVER){
				currentFrame=2;
			}else if(value==MoonConst.BUTTON_DOWN){
				currentFrame=3;
			}
		}
	}
}