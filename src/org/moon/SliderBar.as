package org.moon
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
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
	public class SliderBar extends BasicBar
	{
		protected var progress:Scale9Image;
		protected var bar:BasicButton;
		protected var _value:Number=0;
		private var maskQuad:Sprite;
		private var totalLength:Number;
		public function SliderBar()
		{
			modelType="slider";
			initSkin();
			_width=100;
			_height=8;
			setSize(_width,_height)
		}
		/**初始化皮肤*/
		private function initSkin():void
		{
			bar=new BasicButton;
			buttonDic["bar"]=bar;
		}
		/**设置皮肤*/
		override public function setSkin(type:String, skin:Object,param:Object=null):void
		{
			super.setSkin(type,skin,param);
			if(type==MoonConst.SLIDER_BACKGROUND){
				setBackground(skin,param);
			}else if(type==MoonConst.SLIDER_PROGRESS){
				if(!progress) progress=new Scale9Image(skin.clone());
			}
		}
		/**渲染,如果没给bar设置皮肤,它会使用主题皮肤*/
		override protected function render():void
		{
			for(var model:String in NameList.list){
				if(model==MoonConst.MODEL_SLIDER){
					for(var type:String in NameList.list[model]){
						if(type.split("-")[1]=="background"){
							var skin:Object=NameList.list[model][type];
							setBackground(skin,NameList.param[model][type]);
						}else if(type.split("-")[1]=="progress"){
							var image:BitmapData=NameList.list[model][type];
							if(!progress)	progress=new Scale9Image(image.clone());
						}else{
							setSkin(type,NameList.list[model][type],NameList.param[model][type]);
						}
					}
					break;
				}
			}
			if(progress&&background){
				totalLength=background.width-bar.width;
				progress.width=background.width=_width;
				progress.height=background.height=_height;
				this.addChild(background);
				this.addChild(progress);
				this.addChild(bar);
				bar.y=(background.height-bar.height)>>1;
				progress.mask=maskQuad;
				this.addChild(maskQuad);
				bar.x=value*totalLength;
				bar.label=int(value*50).toString();
				var point:Point=bar.getLabelWH();
				bar.setLabelSeat(point.x/-2,-1*point.y);
				bar.newAddEventListener(MoonEvent.MOUSE_DOWN,onStart);
			}
		}
		
		private function onStart(e:MoonEvent):void
		{
			bar.startDrag(false,new Rectangle(0,bar.y,totalLength,0));
			bar.stage.addEventListener(MouseEvent.MOUSE_MOVE,onMove);
			bar.stage.addEventListener(MouseEvent.MOUSE_UP,onStop);
		}
		
		private function onMove(e:MouseEvent):void
		{
			value=bar.x/totalLength;
		}
		
		private function onStop(e:MouseEvent):void
		{
			bar.stopDrag();
			bar.stage.removeEventListener(MouseEvent.MOUSE_MOVE,onMove);
			bar.stage.removeEventListener(MouseEvent.MOUSE_UP,onStop);
		}
		/**设置显示的范围大小*/
		override public function setSize(w:Number=-1,h:Number=-1):void
		{
			if(maskQuad){
				maskQuad=null;
			}
			maskQuad=new Sprite;
			maskQuad.graphics.beginFill(0);
			maskQuad.graphics.drawRect(0,0,w,h);
			maskQuad.graphics.endFill();
			_width=w
			_height=h
		}

		public function get value():Number
		{
			return _value;
		}

		public function set value(v:Number):void
		{
			if(v>1) v=1;
			else if(v<0) v=0;
			_value = v;
			maskQuad.scaleX = _value;
			bar.x = value * totalLength;
			bar.label=int(value*100).toString();
			this.newDispatchEvent(MoonEvent.CHANGE,_value);
		}
	}
}
