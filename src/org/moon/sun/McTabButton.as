package org.moon.sun
{
	import org.moon.utils.MoonConst;

	/**
	 * ...按钮影片要求必须是六帧，前三帧是按钮1后三帧是按钮2。
	 * @author vinson
	 */
	public class McTabButton extends McButton
	{
		protected var _currentPage:int=0;
		public function McTabButton()
		{
			super();
		}
		override protected function set currentFrame(value:int):void
		{
			buttonmc.gotoAndStop(value);
		}
		override public function set currentStatc(value:String):void
		{
			_currentStatc = value;
			if(value==MoonConst.BUTTON_UP){
				currentFrame=1+_currentPage*3;
			}else if(value==MoonConst.BUTTON_OVER){
				if(isGray==false)	currentFrame=2+_currentPage*3;
			}else if(value==MoonConst.BUTTON_DOWN){
				if(isGray==false)	currentFrame=3+_currentPage*3;
				_currentPage=_currentPage==0?1:0;
			}
		}

		public function get currentPage():int
		{
			return _currentPage;
		}

	}
}