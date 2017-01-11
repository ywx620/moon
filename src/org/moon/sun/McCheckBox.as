package org.moon.sun
{
	import flash.events.MouseEvent;
	
	import org.moon.event.MoonEvent;
	import org.moon.utils.MoonConst;

	/**
	 * ...多选框
	 * @author vinson
	 */
	public class McCheckBox extends McButton
	{
		protected var _index:int=0;
		public function McCheckBox()
		{
			super();
		}
		public function setStatc():void
		{
			if(_index==0)	currentStatc=MoonConst.BUTTON_UP;
			else			currentStatc=MoonConst.BUTTON_DOWN;
		}
		override protected function onMouseHanlder(event:MouseEvent):void
		{
			this.removeSkinAll();
			this.removeEventListener(MouseEvent.MOUSE_OVER,onMouseHanlder);
			switch(event.type){
				case MouseEvent.MOUSE_OVER:
					setStatc();
					this.newDispatchEvent(MoonEvent.MOUSE_OVER);
					break;
				case MouseEvent.MOUSE_OUT:
					setStatc();
					this.addEventListener(MouseEvent.MOUSE_OVER,onMouseHanlder);
					this.newDispatchEvent(MoonEvent.MOUSE_OUT);
					break;
				case MouseEvent.MOUSE_DOWN:
					currentStatc=MoonConst.BUTTON_DOWN;
					_index=_index==0?1:0;
					this.newDispatchEvent(MoonEvent.MOUSE_DOWN);
					break;
				case MouseEvent.MOUSE_UP:
					setStatc();
					this.addEventListener(MouseEvent.MOUSE_OVER,onMouseHanlder);
					this.newDispatchEvent(MoonEvent.MOUSE_UP);
					break;
			}
		}
		
		/**index为0时是未选中，为1时是选中状态*/
		public function get index():int
		{
			return _index;
		}
		
		/**
		 * @private
		 */
		public function set index(value:int):void
		{
			if(value<0){
				value=0;
				
			}else if(value>1){
				value=1;
			}
			_index = value;
			setStatc();
		}

	}
}