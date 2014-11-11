package org.moon
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	import org.moon.basic.BasicBar;
	import org.moon.utils.MoonConst;
	import org.moon.utils.NameList;
	import org.moon.utils.Scale9Image;
	
	/**
	 * ...
	 * @author vinson
	 */
	public class ProgressBar extends BasicBar
	{
		protected var bar:Scale9Image;
		protected var _value:Number;
		private var maskQuad:Sprite;
		public function ProgressBar()
		{
			modelType="progress";
			_width=100;
			_height=18;
			setSize(_width,_height)
		}
		/**设置皮肤*/
		override public function setSkin(type:String, skin:Object,param:Object=null):void
		{
			if(type==MoonConst.PROGRESS_BACKGROUND){
				setBackground(skin,param);
			}else if(type==MoonConst.PROGRESS_BAR){
				bar=new Scale9Image(skin.clone());
			}
		}
		/**渲染,如果没给bar设置皮肤,它会使用主题皮肤*/
		override protected function render():void
		{
			for(var model:String in NameList.list){
				if(model==MoonConst.MODEL_PROGRESS){
					for(var type:String in NameList.list[model]){
						if(type.split("-")[1]=="background"){
							var skin:Object=NameList.list[model][type];
							setBackground(skin,NameList.param[model][type]);
						}else{
							var image:BitmapData=NameList.list[model][type];
							if(!bar)	bar=new Scale9Image(image.clone());
						}
					}
					break;
				}
			}
			if(bar&&background){
				bar.width=background.width=_width;
				bar.height=background.height=_height;
				this.addChild(background);
				this.addChild(bar);
				bar.mask=maskQuad;
				this.addChild(maskQuad);
			}
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
			maskQuad.scaleX=value;
		}

		
	}
}