package org.moon 
{
	import flash.display.BitmapData;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	import org.moon.basic.BasicBar;
	import org.moon.basic.BasicButton;
	import org.moon.event.MoonEvent;
	import org.moon.utils.MoonConst;
	import org.moon.utils.NameList;
	import org.moon.utils.Scale9Image;
	/**
	 * ...提醒完后自动关闭
	 * @author vinson
	 */
	public class AutoWarnBar extends BasicBar
	{
		protected var text:TextField;
		protected var timeText:TextField;
		protected var timeNum:int;
		protected var _barWidth:int=200;//默认宽度
		protected var _barHeight:int = 100;//默认宽度
		protected var timer:Timer;
		public function AutoWarnBar() 
		{
			modelType = 'autowarn';
			initSkin();
		}
		/**初始化皮肤*/
		private function initSkin():void
		{
			text=new TextField;
			timeText = new TextField;
			text.autoSize="center";
			timeText.autoSize="center";
		}
		/**设置皮肤*/
		override public function setSkin(type:String, skin:Object,param:Object=null):void
		{
			super.setSkin(type,skin,param);
			if(type==MoonConst.AUTOWARN_BACKGROUND){
				setBackground(skin,param);
			}
		}
		/**渲染,如果没给bar设置皮肤,它会使用主题皮肤*/
		override protected function render():void
		{
			//渲染按钮
			for(var model:String in NameList.list){
				if(model==MoonConst.MODEL_AUTOWARN){
					for(var type:String in NameList.list[model]){
						if(type.split("-")[1]=="background"){
							var skin:Object=NameList.list[model][type];
							setBackground(skin,NameList.param[model][type]);
						}
					}
					break;
				}
			}
			background.width=_barWidth;
			background.height=_barHeight;
			this.addChild(background);
			this.addChild(text);
			this.addChild(timeText);
			text.x=(background.width-text.width)>>1;
			text.y = 20;
			timeText.x =(background.width-timeText.width)>>1;
			timeText.y = text.y + text.height + 20;
		}
		public function set label(value:String):void
		{
			text.multiline=true;
			text.htmlText=value;
			if(_barWidth<text.width){
				_barWidth=text.width+60;
			}
			if(_barHeight<text.height){
				_barHeight=text.height+100;
			}
		}
		public function start(value:int = 3):void
		{
			timeNum = value;
			timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			timer.start();
			updateTime();
		}
		private function updateTime():void
		{
			timeText.text = timeNum + "秒";
			if (timeNum > 0) timeNum--;
			else this.removeFromParent(true);
		}
		private function onTimer(e:TimerEvent):void
		{
			updateTime();
		}
		override public function dispose():void
		{
			super.dispose();
			if (timer) {
				timer.removeEventListener(TimerEvent.TIMER, onTimer);
				timer = null;
			}
			text=null;
			background=null;
		}
	}

}