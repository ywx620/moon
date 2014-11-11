package org.moon
{
	import flash.display.BitmapData;
	import flash.text.TextField;
	
	import org.moon.basic.BasicBar;
	import org.moon.basic.BasicButton;
	import org.moon.event.MoonEvent;
	import org.moon.utils.MoonConst;
	import org.moon.utils.NameList;
	import org.moon.utils.Scale9Image;
	
	/**
	 * ...
	 * @author vinson
	 */
	public class WarnBar extends BasicBar
	{
		protected var buttonCancel:BasicButton;
		protected var buttonSure:BasicButton;
		protected var _barWidth:int=200;//默认宽度
		protected var _barHeight:int=100;//默认宽度
		protected var text:TextField;
		public static const CANCEL:String="cancel";
		public static const SURE:String="sure";
		public function WarnBar()
		{
			modelType="warn";
			initSkin();
		}
		/**初始化皮肤*/
		private function initSkin():void
		{
			text=new TextField;
			buttonCancel=new BasicButton;
			buttonCancel.name=CANCEL;
			buttonSure=new BasicButton;
			buttonSure.name=SURE;
			buttonDic[CANCEL]=buttonCancel;
			buttonDic[SURE]=buttonSure;
			buttons.push(buttonSure,buttonCancel);
		}
		/**设置皮肤*/
		override public function setSkin(type:String, skin:Object,param:Object=null):void
		{
			super.setSkin(type,skin,param);
			if(type==MoonConst.WARN_BACKGROUND){
				setBackground(skin,param);
			}
		}
		/**渲染,如果没给bar设置皮肤,它会使用主题皮肤*/
		override protected function render():void
		{
			//渲染按钮
			if(buttonCancel.hasSkinData==false){
				for(var model:String in NameList.list){
					if(model==MoonConst.MODEL_WARN){
						for(var type:String in NameList.list[model]){
							if(type.split("-")[1]=="background"){
								var skin:Object=NameList.list[model][type];
								setBackground(skin,NameList.param[model][type]);
							}else{
								setSkin(type,NameList.list[model][type],NameList.param[model][type]);
							}
						}
						break;
					}
				}
			}
			this.addChild(background);
			this.addChild(text);
			background.width=_barWidth;
			background.height=_barHeight;
			text.x=(background.width-text.width)>>1;
			text.y=10;
			var i:int=0;
			var half:Number=background.width>>1;
			for each(var button:BasicButton in buttons){
				this.addChild(button);
				button.x=(half-button.width)/2+(half*i++);
				button.y=_barHeight-button.height-10;
				button.newAddEventListener(MoonEvent.MOUSE_UP,onMouseHandler);
			}
			
		}
		
		private function onMouseHandler(e:MoonEvent):void
		{
			var btn:BasicButton=e.currentTarget as BasicButton;
			if(btn.name==CANCEL){
				this.newDispatchEvent(CANCEL);
			}else{
				this.newDispatchEvent(SURE);
			}
			this.removeFromParent(true);
		}
		public function set label(value:String):void
		{
			text.multiline=true;
			text.autoSize="center";
			text.htmlText=value;
			if(_barWidth<text.width){
				_barWidth=text.width+20;
			}
			if(_barHeight<text.height){
				_barHeight=text.height+100;
			}
		}
		override public function dispose():void
		{
			var i:int=0;
			if(buttons){
				for(i=0;i<buttons.length;i++){
					buttons[i].newRemoveEventListener(MoonEvent.MOUSE_UP,onMouseHandler);
					buttons[i].dispose();
					buttons[i]=null;
				}
				buttons.length=0;
				buttons=null;
			}
			super.dispose();
			text=null;
			background=null;
		}
	}
}