package org.moon.basic
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	
	import org.moon.event.MoonEvent;
	import org.moon.utils.MoonConst;
	import org.moon.utils.NameList;
	
	/**
	 * ...基础按钮
	 * @author vinson
	 */
	public class BasicButton extends BasicContent
	{
		protected var _isButtonModel:Boolean;
		protected var icon:DisplayObject;
		protected var _label:String;
		protected var basicLabel:BasicLabel;
		protected var _currentStatc:String;
		protected var _buttonmc:MovieClip;
		public function BasicButton()
		{
			
		}
		override protected function initialization():void
		{
			addEvent();
			isButtonModel=true;
		}
		/**设置皮肤*/
		override public function setSkin(type:String,skin:Object,param:Object=null):void
		{
			super.setSkin(type,skin,param);
			if(dataSkin[MoonConst.BUTTON_MOVIECLIP]){
				buttonmc=dataSkin[MoonConst.BUTTON_MOVIECLIP] as MovieClip;
				currentStatc=MoonConst.BUTTON_UP;
			}
		}
		/**渲染*/
		override protected function render():void
		{
			if(this.hasSkinData==false){
				for(var model:String in NameList.list){
					if(model==MoonConst.MODEL_BUTTON){
						for(var type:String in NameList.list[model]){
							setSkin(type,NameList.list[model][type]);
						}
						break;
					}
				}
				if(_height!=-1){
					setSize(-1,_height)
				}
				if(_width!=-1){
					setSize(_width,-1)
				}
				autoLabelSeat();
			}
			
		}
		protected function onMouseHanlder(event:MouseEvent):void
		{
			this.removeSkinAll();
			this.removeEventListener(MouseEvent.MOUSE_OVER,onMouseHanlder);
			switch(event.type){
				case MouseEvent.MOUSE_OVER:
					currentStatc=MoonConst.BUTTON_OVER;
					this.newDispatchEvent(MoonEvent.MOUSE_OVER);
					break;
				case MouseEvent.MOUSE_OUT:
					currentStatc=MoonConst.BUTTON_UP;
					this.addEventListener(MouseEvent.MOUSE_OVER,onMouseHanlder);
					this.newDispatchEvent(MoonEvent.MOUSE_OUT);
					break;
				case MouseEvent.MOUSE_DOWN:
					currentStatc=MoonConst.BUTTON_DOWN;
					this.newDispatchEvent(MoonEvent.MOUSE_DOWN);
					break;
				case MouseEvent.MOUSE_UP:
					currentStatc=MoonConst.BUTTON_UP;
					this.addEventListener(MouseEvent.MOUSE_OVER,onMouseHanlder);
					this.newDispatchEvent(MoonEvent.MOUSE_UP);
					break;
			}
		}
		/**不使用mc按钮*/
		protected function addSkin(dis:DisplayObject):void
		{
			if(dis){
				this.addChildAt(dis,0);
			}else{
				this.addChildAt(dataSkin[MoonConst.BUTTON_DEFAULT],0)
			}
		}
		/**不使用mc按钮*/
		protected function removeSkinAll():void
		{
			if(!dataSkin[MoonConst.BUTTON_MOVIECLIP]){
				for each(var dis:DisplayObject in dataSkin){
					if(this.contains(dis)) this.removeChild(dis);
				}
			}
		}
		private function autoLabelSeat():void
		{
			if(basicLabel!=null){
				if(dataSkin[MoonConst.BUTTON_UP]){
					basicLabel.x=(dataSkin[MoonConst.BUTTON_UP].width-basicLabel.width)>>1;
					basicLabel.y=(dataSkin[MoonConst.BUTTON_UP].height-basicLabel.height)>>1;
				}
			}
		}
		/**增加事件*/
		public function addEvent():void
		{
			this.addEventListener(MouseEvent.MOUSE_OVER,onMouseHanlder);
			this.addEventListener(MouseEvent.MOUSE_OUT,onMouseHanlder);
			this.addEventListener(MouseEvent.MOUSE_DOWN,onMouseHanlder);
			this.addEventListener(MouseEvent.MOUSE_UP,onMouseHanlder);
		}
		/**删除事件*/
		public function removeEvent():void
		{
			this.removeEventListener(MouseEvent.MOUSE_OVER,onMouseHanlder);
			this.removeEventListener(MouseEvent.MOUSE_OUT,onMouseHanlder);
			this.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseHanlder);
			this.removeEventListener(MouseEvent.MOUSE_UP,onMouseHanlder);
		}
		/**增加ICON*/
		public function addIcon(icon:DisplayObject,x:int=0,y:int=0):void
		{
			this.icon=icon;
			this.addChild(icon);
			icon.x=x;icon.y=y;
		}
		/**删除ICON*/
		public function removeIcon():void
		{
			if(icon&&this.contains(icon)){
				this.removeChild(icon);
				icon=null;
			}
		}
		public function get isButtonModel():Boolean
		{
			return _isButtonModel;
		}
		
		public function set isButtonModel(value:Boolean):void
		{
			this.useHandCursor=value;
			this.buttonMode=value;
			this.mouseEnabled=value;
			this.mouseChildren=value;
			_isButtonModel = value;
		}
		public function buttonIsEnabled(boo:Boolean):void
		{
			isButtonModel=boo;
			if(boo==true){
				this.filters.length=0;
				this.filters=null;
			}else{
				var matrix:Array=[0.3086, 0.6094, 0.0820, 0, 0,  
					0.3086, 0.6094, 0.0820, 0, 0,  
					0.3086, 0.6094, 0.0820, 0, 0,  
					0,      0,      0,      1, 0];
				var myfilter:ColorMatrixFilter=new ColorMatrixFilter(matrix);
				this.filters=[myfilter];
			}
		}
		/**设置大小*/
		override public function setSize(w:Number=-1,h:Number=-1):void
		{
			for each(var obj:DisplayObject in dataSkin){
				if(w!=-1)	obj.width=w;
				if(h!=-1)	obj.height=h;
			}
			autoLabelSeat()
		}
		
		public function get label():String
		{
			return _label;
		}
		
		public function set label(value:String):void
		{
			if(basicLabel==null){
				basicLabel=new BasicLabel;
				this.addChild(basicLabel);
			}
			basicLabel.text=value;
			_label = value;
		}
		/**如果值是为0则不做变化*/
		public function setLabelSeat(x:Number=0,y:Number=0):void
		{
			if(x!=0) basicLabel.x=x;
			if(y!=0) basicLabel.y=y;
		}
		
		override public function set width(value:Number):void
		{
			_width=value;
			for each(var obj:DisplayObject in dataSkin){
				obj.width=value;
			}
			autoLabelSeat();
		}
		override public function set height(value:Number):void
		{
			_height=value;
			for each(var obj:DisplayObject in dataSkin){
				obj.height=value;
			}
			autoLabelSeat();
		}
		public function set buttonmc(value:MovieClip):void
		{
			_buttonmc = value;
			name=value.name;
			currentStatc=MoonConst.BUTTON_UP;
		}
		
		public function get buttonmc():MovieClip
		{
			return _buttonmc;
		}
		
		protected function set currentFrame(value:int):void
		{
			if(buttonmc){
				this.addChildAt(buttonmc,0);
				if(value<=3){
					if(buttonmc.totalFrames==2){//可能按钮只有两帧
						if(value==3) value=2;
					}
					if(buttonmc.totalFrames==1){//可能按钮只有一帧
						if(value>=2) value=1;
					}
					buttonmc.gotoAndStop(value);
				}
			}
		}
		
		public function get currentStatc():String
		{
			return _currentStatc;
		}
		
		public function set currentStatc(value:String):void
		{
			_currentStatc = value;
			this.removeSkinAll();
			if(value==MoonConst.BUTTON_UP){
				if(buttonmc) currentFrame=1;
				else		this.addSkin(dataSkin[MoonConst.BUTTON_UP]);
			}else if(value==MoonConst.BUTTON_OVER){
				if(buttonmc) currentFrame=2;
				else		this.addSkin(dataSkin[MoonConst.BUTTON_OVER]);
			}else if(value==MoonConst.BUTTON_DOWN){
				if(buttonmc) currentFrame=3;
				else		this.addSkin(dataSkin[MoonConst.BUTTON_DOWN]);
			}
		}
		override public function dispose():void
		{
			removeEvent();
			this.removeChildren();
			dataSkin=null;
			super.dispose();
		}

	}
}