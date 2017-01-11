package org.moon.sun
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import org.moon.SliderBar;
	import org.moon.event.MoonEvent;
	
	/**
	 * ...2016-12-30
	 * @author vinson
	 */
	public class McSliderBar extends SliderBar
	{
		private var _progressmc:MovieClip;
		private var _barmc:MovieClip;
		public function McSliderBar()
		{
			super();
		}
		
		override protected function render():void
		{
			//不让父级渲染
		}

		public function get progressmc():MovieClip
		{
			return _progressmc;
		}

		public function set progressmc(value:MovieClip):void
		{
			_progressmc = value;
			totalLength=value.width;
			setSize(value.width,value.height);
			maskQuad.x=value.x;
			maskQuad.y=value.y;
			value.parent.addChild(maskQuad);
			value.mask=maskQuad;
		}
		
		public function get barmc():MovieClip
		{
			return _barmc;
		}
		
		public function set barmc(value:MovieClip):void
		{
			_barmc = value;
			_barmc.buttonMode=true;
			_barmc.addEventListener(MouseEvent.MOUSE_DOWN,start);
		}
		
		protected function start(e:MouseEvent):void
		{
			_barmc.startDrag(false,new Rectangle(0,bar.y,totalLength,0));
			_barmc.stage.addEventListener(MouseEvent.MOUSE_MOVE,onMove);
			_barmc.stage.addEventListener(MouseEvent.MOUSE_UP,onStop);
		}
		
		override protected function onMove(e:MouseEvent):void
		{
			value=_barmc.x/totalLength;
		}
		
		override protected function onStop(e:MouseEvent):void
		{
			_barmc.stopDrag();
			_barmc.stage.removeEventListener(MouseEvent.MOUSE_MOVE,onMove);
			_barmc.stage.removeEventListener(MouseEvent.MOUSE_UP,onStop);
			this.newDispatchEvent(MoonEvent.MOUSE_UP,_value);
		}
		override public function resetBar():void
		{
			_barmc.x=value*totalLength;
		}
		
		override public function dispose():void
		{
			onStop(null);
			_barmc.removeEventListener(MouseEvent.MOUSE_DOWN,start);
		}
	}
}