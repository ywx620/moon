package org.moon
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	/**
	 * ...
	 * @author vinson
	 */
	public class ScrollTextBar extends ScrollBar
	{
		protected var _scrollTextTarget:TextField;
		/**left,right*/
		public var textSeat:String="left";
		public function ScrollTextBar()
		{
			super();
		}
		/**渲染,如果没给bar设置皮肤,它会使用主题皮肤*/
		override protected function render():void
		{
			super.render();
			//渲染内容
			if(scrollTextTarget){
				if(textSeat=="left")
					scrollTextTarget.x=-1*(scrollTextTarget.width);
				else
					scrollTextTarget.x=(buttonBody.width);
				scrollTextTarget.addEventListener(Event.SCROLL, onScroll);
				scrollTextTarget.addEventListener(Event.CHANGE, onTextChange);
				this.addChild(scrollTextTarget);
			}
			updateButtonBar();
		}
		/**文本有变化*/
		protected function onTextChange(event:Event):void
		{
			updateButtonBar();
		}
		/**文本滚动*/
		protected function onScroll(event:Event):void
		{
			var contentTextMoveHeight:int = scrollTextTarget.maxScrollV;
			var scrollPercent:Number = (scrollTextTarget.scrollV==1?0:scrollTextTarget.scrollV)/(contentTextMoveHeight);
			buttonBar.y = scrollBarMoveHeight * scrollPercent+buttonUp.height;
		}
		/**滚动条移动*/
		override protected function contentMoveFree():void
		{
			var moveHeight:int = scrollTextTarget.maxScrollV;
			var scrollPercent:Number = (buttonBar.y-buttonUp.height) / scrollBarMoveHeight;
			scrollTextTarget.scrollV=int(scrollPercent * moveHeight);
		}
		/**设置显示的范围大小*/
		override public function setSize(w:Number=-1,h:Number=-1):void
		{
			if(scrollTextTarget){
				scrollTextTarget.width=w;
				scrollTextTarget.height=h;
			}
			scrollHeight=h;
		}
		override protected function get scrollTargetHeith():Number
		{
			return scrollTextTarget.textHeight;
		}

		public function get scrollTextTarget():TextField
		{
			return _scrollTextTarget;
		}

		public function set scrollTextTarget(value:TextField):void
		{
			_scrollTextTarget = value;
			_scrollTextTarget.multiline=true;
			_scrollTextTarget.wordWrap=true;
		}
		override public function dispose():void
		{
			if(_scrollTextTarget){
				_scrollTextTarget.removeEventListener(Event.SCROLL, onScroll);
				_scrollTextTarget.removeEventListener(Event.CHANGE, onTextChange);
				this.removeChild(_scrollTextTarget);
				_scrollTextTarget=null;
			}
			super.dispose();
		}
	}
}