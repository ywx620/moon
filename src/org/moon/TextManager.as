package org.moon
{
	import flash.filters.GlowFilter;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;

	/**
	 * ...
	 * @author vinson
	 */
	public class TextManager
	{
		public static function white(str:String):String{return "<font color='#ffffff'>"+str+"</font>";}
		public static function red(str:String):String{return "<font color='#ff0000'>"+str+"</font>";}
		public static function green(str:String):String{return "<font color='#00ff00'>"+str+"</font>";}
		public static function bule(str:String):String{return "<font color='#000ff'>"+str+"</font>";}
		public static function yellow(str:String):String{return "<font color='#ffff00'>"+str+"</font>";}
		public static function line(str:String,size:int=0):String{return "<textformat leading='"+size+"'>"+str+"</textformat>";}//行间距离
		public static var fonts:Dictionary=new Dictionary;
		public static var fontName:String="Font1";
		/**创建输入文本
		 * numTxt.restrict="0-9"//只能输入数字
		 * */
		public static function createInputTextField(x:int,y:int,w:int,h:int,auto:String="none",size:int=14,color:uint=0XFFFFFF,isGlowFilter:Boolean=true,glowColor:uint=0):TextField
		{
			var text:TextField=createTextField(x,y,w,h,auto,size,color,isGlowFilter,glowColor);
			text.selectable=true;
			text.mouseEnabled=true;
			text.type=TextFieldType.INPUT;
			return text
		}
		/**创建多行的输入文本*/
		public static function createInputTextMultiline(x:int,y:int,w:int,h:int,size:int=14,color:uint=0XFFFFFF,isGlowFilter:Boolean=true,glowColor:uint=0):TextField
		{
			var text:TextField=createInputTextField(x,y,w,h,"none",size,color,isGlowFilter,glowColor);
			text.wordWrap=true;
			return text
		}
		/**注册字体
		 * 请特别注意看这条：在控制面板FlashPlayer或者Flash插件上右键->全局设置->高级->开发人员工具->受信任的位置设置->添加： 
		 * 被调用的swf文件(fonts.swf)所在目录(这里是d:/) 
		 * 如果没有设置将会报 exception, information=ArgumentError: Error #1508: 为参数 font 指定的值无效。 
		 * */
		public static function setFont(f:Class):void
		{
			Font.registerFont(f);
		}
		/**创建动态文本*/
		public static function createTextField(x:int,y:int,w:int,h:int,auto:String="center",size:int=14,color:uint=0XFFFFFF,isGlowFilter:Boolean=true,glowColor:uint=0):TextField
		{
			var _textField:TextField=new TextField();
			_textField.selectable=false;	_textField.mouseEnabled=false;
			_textField.autoSize=auto;
			_textField.x=x;					_textField.y=y;
			_textField.width=w;				_textField.height=h;
			var tf:TextFormat=new TextFormat;
			if(TextManager.fonts[fontName]){
				_textField.embedFonts=true;
				tf.font=TextManager.fonts[fontName];
			}
			tf.letterSpacing=2;
			tf.size=size;		tf.color=color;
			_textField.defaultTextFormat=tf;
			if(isGlowFilter){
				var filer:GlowFilter=new GlowFilter(glowColor,1,3,3,4);
				_textField.filters=[filer];
			}
			return _textField;
		}
		/**创建多行文本*/
		public static function createTextMultiline(x:int,y:int,w:int,h:int,size:int=14,color:uint=0XFFFFFF,isGlowFilter:Boolean=true,glowColor:uint=0):TextField
		{
			var _textField:TextField=createTextField(x,y,w,h,"none",size,color,isGlowFilter,glowColor)
			_textField.autoSize="none";
			_textField.multiline=true;
			_textField.wordWrap=true;
			return _textField
		}
	}
}