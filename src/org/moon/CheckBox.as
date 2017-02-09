package org.moon
{
	import flash.events.MouseEvent;
	
	import org.moon.basic.BasicButton;
	import org.moon.event.MoonEvent;
	import org.moon.utils.MoonConst;
	import org.moon.utils.NameList;
	import org.moon.utils.Scale9Image;

	/**
	 * ...
	 * @author vinson
	 */
	public class CheckBox extends BasicButton
	{
		protected var _index:int=0;
		protected var myTypeDefault:String;
		protected var myTypeOver:String;
		protected var myTypeSelect:String;
		protected var myModel:String;
		public function CheckBox()
		{
			myModel=MoonConst.MODEL_CHECKBOX;
			super();
		}
		/**设置皮肤*/
		override public function setSkin(type:String, skin:Object,param:Object=null):void
		{
			if (myModel == MoonConst.MODEL_CHECKBOX) {//复选框
				dataSkin[type] = new Scale9Image(skin.clone());
				if(type==MoonConst.CHECKBOX_DEFAULT_0){
					currentStatc = MoonConst.BUTTON_UP;
				}
			}else{//单选框
				if(type==myTypeDefault){
					dataSkin[MoonConst.BUTTON_UP]=new Scale9Image(skin.clone());
					currentStatc=MoonConst.BUTTON_UP;
				}else if(type==myTypeOver){
					dataSkin[MoonConst.BUTTON_OVER]=new Scale9Image(skin.clone());
				}else if(type==myTypeSelect){
					dataSkin[MoonConst.BUTTON_DOWN]=new Scale9Image(skin.clone());
				}
			}
			
		}
		override public function set currentStatc(value:String):void
		{
			if (myModel == MoonConst.MODEL_CHECKBOX) {//复选框
				_currentStatc = value;
				this.removeSkinAll();
				if(_index==0){//没有钩选
					if(value==MoonConst.BUTTON_UP){
						this.addSkin(dataSkin[MoonConst.CHECKBOX_DEFAULT_0]);
					}else if(value==MoonConst.BUTTON_OVER){
						this.addSkin(dataSkin[MoonConst.CHECKBOX_OVER_0]);
					}else if(value==MoonConst.BUTTON_DOWN){
						this.addSkin(dataSkin[MoonConst.CHECKBOX_SELECT_0]);
					}
				}else {//钩选上
					if(value==MoonConst.BUTTON_UP){
						this.addSkin(dataSkin[MoonConst.CHECKBOX_DEFAULT_1]);
					}else if(value==MoonConst.BUTTON_OVER){
						this.addSkin(dataSkin[MoonConst.CHECKBOX_OVER_1]);
					}else if(value==MoonConst.BUTTON_DOWN){
						this.addSkin(dataSkin[MoonConst.CHECKBOX_SELECT_1]);
					}
				}
			}else{//单选框
				super.currentStatc = value;
			}
		}
		/**渲染,如果没给bar设置皮肤,它会使用主题皮肤*/
		override protected function render():void
		{
			for(var model:String in NameList.list){
				if(model==myModel){
					for(var type:String in NameList.list[model]){
						setSkin(type,NameList.list[model][type],NameList.param[model][type]);
					}
					break;
				}
			}
		}
		public function setStatc():void
		{
			if(_index==0)	currentStatc=MoonConst.BUTTON_UP;
			else			currentStatc=MoonConst.BUTTON_DOWN;
		}
		override protected function onMouseHanlder(event:MouseEvent):void
		{
			this.removeSkinAll();
			this.removeEventListener(MouseEvent.MOUSE_OVER, onMouseHanlder);
			switch(event.type){
				case MouseEvent.MOUSE_OVER:
					setStatc();
					currentStatc=MoonConst.BUTTON_OVER;
					this.newDispatchEvent(MoonEvent.MOUSE_OVER);
					break;
				case MouseEvent.MOUSE_OUT:
					setStatc();
					this.addEventListener(MouseEvent.MOUSE_OVER,onMouseHanlder);
					this.newDispatchEvent(MoonEvent.MOUSE_OUT);
					break;
				case MouseEvent.MOUSE_DOWN:
					currentStatc=MoonConst.BUTTON_DOWN;
					_index=_index==0?1:0;
					this.newDispatchEvent(MoonEvent.MOUSE_DOWN);
					break;
				case MouseEvent.MOUSE_UP:
					setStatc();
					this.addEventListener(MouseEvent.MOUSE_OVER,onMouseHanlder);
					this.newDispatchEvent(MoonEvent.MOUSE_UP);
					break;
			}
		}

		/**index为0时是未选中，为1时是选中状态*/
		public function get index():int
		{
			return _index;
		}

		/**
		 * @private
		 */
		public function set index(value:int):void
		{
			if(value<0){
				value=0;
				
			}else if(value>1){
				value=1;
			}
			_index = value;
		}

	}
}