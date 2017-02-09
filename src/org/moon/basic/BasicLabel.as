package org.moon.basic
{
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import org.moon.TextManager;

	/**
	 * ...
	 * @author vinson
	 */
	public class BasicLabel extends Sprite
	{
		private var _textField:TextField;
		private var _text:String;
		public static var size:int=16;
		public static var color:int=0XFFFFFF;
		public static var isGlowFilter:Boolean=true;
		public static var glowColor:int=0;
		public function BasicLabel()
		{
			createTextField(size,color,isGlowFilter,glowColor);
		}
		public function createTextField(size:int=14,color:uint=0XFFFFFF,isGlowFilter:Boolean=true,glowColor:uint=0):TextField
		{
			_textField=new TextField();
			_textField.selectable=false;	_textField.mouseEnabled=false;
			_textField.autoSize="left";
			var tf:TextFormat=new TextFormat;
			if(TextManager.fonts[TextManager.fontName]){
				_textField.embedFonts=true;
				tf.font=TextManager.fonts[TextManager.fontName];
			}
			tf.letterSpacing=2;
			tf.size=size;		tf.color=color;
			_textField.defaultTextFormat=tf;
			if(isGlowFilter){
				var filer:GlowFilter=new GlowFilter(glowColor,1,3,3,4);
				_textField.filters=[filer];
			}
			this.addChild(_textField);
			return _textField;
		}

		public function get text():String
		{
			return _text;
		}

		public function set text(value:String):void
		{
			_text = value;
			_textField.text=value;
		}
		
		public function get textField():TextField
		{
			return _textField;
		}
	}
}