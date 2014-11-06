package org.moon.basic
{
	import flash.display.Sprite;
	import flash.text.TextField;

	/**
	 * ...
	 * @author vinson
	 */
	public class BasicLabel extends Sprite
	{
		private var textField:TextField;
		private var _text:String;
		public function BasicLabel()
		{
			textField=new TextField();
			textField.selectable=false;
			textField.mouseEnabled = false;
			textField.autoSize = "left";
			this.addChild(textField);
		}

		public function get text():String
		{
			return _text;
		}

		public function set text(value:String):void
		{
			_text = value;
			textField.text=value;
		}
	}
}