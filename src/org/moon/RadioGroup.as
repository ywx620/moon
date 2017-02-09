package org.moon
{
	import org.moon.basic.BasicBar;
	import org.moon.event.MoonEvent;
	
	/**
	 * ...
	 * @author vinson
	 */
	public class RadioGroup extends BasicBar
	{
		private var radios:Vector.<Radio>=new Vector.<Radio>;
		public function RadioGroup()
		{
			super();
		}
		/**渲染*/
		override protected function render():void
		{
			for(var i:int=0;i<data.length;i++){
				var radio:Radio=new Radio;
				this.addChild(radio);
				var ww:Number=radio.width+5;
				radio.label=data[i];
				radio.autoLabelSeat();
				radio.setLabelSeat(ww);
				radio.y=(radio.height+gad)*i;
				radio.newAddEventListener(MoonEvent.MOUSE_DOWN,onMouseHandler);
				radios.push(radio);
			}
		}
		
		private function onMouseHandler(e:MoonEvent):void
		{
			var radio:Radio=e.currentTarget as Radio;
			for(var i:int=0;i<radios.length;i++){
				radios[i].index=0;
				radios[i].setStatc();
				if(radios[i]==radio) barIndex=i;
			}
			radio.index=1;
			radio.setStatc();
			this.newDispatchEvent(MoonEvent.CHANGE,barIndex);
		}
	}
}