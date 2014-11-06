package org.moon
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import org.moon.basic.BasicBar;
	import org.moon.basic.BasicButton;
	import org.moon.event.MoonEvent;
	import org.moon.utils.MoonConst;
	import org.moon.utils.NameList;
	import org.moon.utils.Scale9Image;
	
	public class ListBar extends BasicBar
	{
		private var _index:int=0;
		private var openButton:BasicButton;
		private var openBackground:Scale9Image;
		private var listBackground:Scale9Image;
		private var _openText:TextField;
		public function ListBar()
		{
			super();
			modelType="list";
			initSkin();
		}
		/**初始化皮肤*/
		private function initSkin():void
		{
			_openText=new TextField;
			_openText.autoSize="left";
			openButton=new BasicButton;
			buttonDic["open"]=openButton;
		}
		/**渲染,如果没给bar设置皮肤,它会使用主题皮肤*/
		override protected function render():void
		{
			//渲染按钮
			if(openButton.hasSkinData==false){
				for(var model:String in NameList.list){
					if(model==MoonConst.MODEL_LIST){
						for(var type:String in NameList.list[model]){
							if(type.split("-")[1]=="background"){
								var image:BitmapData=NameList.list[model][type];
								listBackground=new Scale9Image(image.clone());
								openBackground=new Scale9Image(image.clone());
							}else{
								setSkin(type,NameList.list[model][type],NameList.param[model][type]);
							}
						}
						break;
					}
				}
			}
			if(openBackground){
				this.addChild(openBackground);
				openButton.x=openBackground.width;
			}else{
				openButton.x=_width;
			}
			this.addChild(openButton);
			this.addChild(_openText);
			_openText.text=data[index];
			openButton.newAddEventListener(MoonEvent.MOUSE_UP,onMouseHandler);
		}
		
		private function removeButtons():void
		{
			var i:int=0;
			var btn:BasicButton;
			for(i=0;i<buttons.length;i++){
				btn=buttons[i];
				btn.newRemoveEventListener(MoonEvent.MOUSE_UP,onSelectIndex);
				btn.removeFromParent(true);
				btn=null;
			}
			buttons.length=0;
			this.stage.removeEventListener(MouseEvent.MOUSE_MOVE,onFollowMouse);
		}
		
		private function onMouseHandler(e:MoonEvent):void
		{
			var j:int=0;
			var i:int=0;
			var btn:BasicButton;
			removeButtons();
			for(i=0;i<data.length;i++){
				if(i!=index){
					btn=new BasicButton();
					btn.label=data[i];
					btn.name=String(i);
					this.addChild(btn);
					btn.width=120;
					btn.y=openHeight+2+(btn.height+2)*(j++);
					btn.newAddEventListener(MoonEvent.MOUSE_UP,onSelectIndex);
					buttons.push(btn);
					btn.setLabelSeat(1,0);
				}
			}
			this.stage.addEventListener(MouseEvent.MOUSE_MOVE,onFollowMouse);
		}
		private function get openHeight():Number
		{
			if(openBackground)	return openBackground.height;
			else				return _height;
		}
		protected function onFollowMouse(event:MouseEvent):void
		{
			if(!checkIsOutSide(this)){
				removeButtons();
			}
		}
		
		protected function checkIsOutSide(host:DisplayObject):Boolean
		{
			if(host.mouseX>0&&host.mouseX<host.width){
				if(host.mouseY>0&&host.mouseY<host.height){
					return true;
				}
			}
			return false;
		}
		protected function onSelectIndex(e:MoonEvent):void
		{
			var btn:BasicButton=e.currentTarget as BasicButton;
			index=int(btn.name);
			_openText.text=data[index];
			removeButtons();
		}
		
		public function get index():int
		{
			return _index;
		}
		
		public function set index(value:int):void
		{
			_index = value;
		}
		
		
		public function get openText():TextField
		{
			return _openText;
		}
		
		public function set openText(value:TextField):void
		{
			_openText = value;
		}
		
		override public function dispose():void
		{
			if(buttons){
				removeButtons();
				buttons=null;
			}
			openButton.newRemoveEventListener(MoonEvent.MOUSE_UP,onMouseHandler);
			super.dispose();
			_data=null;
			openButton=null;
			openBackground=null;
			listBackground=null;
			_openText=null;
		}
		
		
		
	}
}