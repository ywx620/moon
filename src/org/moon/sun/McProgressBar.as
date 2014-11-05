package org.moon.sun
{
	import flash.display.MovieClip;
	
	import org.moon.ProgressBar;
	
	/**
	 * ...带Mc开头的组件都表示组件是按UI设置好的位置而不需要代码变动与再加载
	 * @author vinson
	 */
	public class McProgressBar extends ProgressBar
	{
		protected var _progressmc:MovieClip;
		public function McProgressBar()
		{
			super();
		}
		override public function set value(v:Number):void
		{
			if(v>1) v=1;
			else if(v<0) v=0;
			_value = v;
			_progressmc.gotoAndStop(v*_progressmc.totalFrames);
		}

		public function get progressmc():MovieClip
		{
			return _progressmc;
		}

		public function set progressmc(value:MovieClip):void
		{
			_progressmc = value;
		}

	}
}