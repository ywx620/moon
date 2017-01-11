package org.moon.sun
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	import modules.utils.CreateComponent;
	
	import org.moon.ProgressBar;
	
	/**
	 * ...带Mc开头的组件都表示组件是按UI设置好的位置而不需要代码变动与再加载
	 * @author vinson
	 */
	public class McProgressBar extends ProgressBar
	{
		protected var _progressmc:MovieClip;
		protected var txt:TextField;
		public function McProgressBar()
		{
			super();
		}
		override protected function render():void
		{
			//不让父级渲染
		}
		override public function set value(v:Number):void
		{
			if(v>1) v=1;
			else if(v<0) v=0;
			_value = v;
			_progressmc.gotoAndStop(int(v*_progressmc.totalFrames));
		}

		public function get progressmc():MovieClip
		{
			return _progressmc;
		}

		public function set progressmc(value:MovieClip):void
		{
			_progressmc = value;
		}
		public function setText(str:String,x:int,y:int,w:int):void
		{
			if(txt==null){
				txt=CreateComponent.createTextField(x,y,w,23,"center",16);
				_progressmc.parent.addChild(txt);
			}
			txt.text=str;
		}
	}
}