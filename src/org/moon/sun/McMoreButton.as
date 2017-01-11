package org.moon.sun
{
	import org.moon.utils.MoonConst;

	/**
	 * ...2015-8-6
	 * ..按钮影片要求必须是3帧的倍数，前三帧是按钮1后三帧是按钮2以此类推
	 * @author vinson
	 */
	public class McMoreButton extends McTabButton
	{
		public function McMoreButton()
		{
			super();
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
			}
		}
	}
}