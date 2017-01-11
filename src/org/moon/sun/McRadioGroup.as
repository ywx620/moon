package org.moon.sun
{
	import org.moon.basic.BasicBar;
	import org.moon.event.MoonEvent;

	/**
	 * ...单选框
	 * @author vinson
	 */
	public class McRadioGroup extends BasicBar
	{
		private var mcCheckBoxs:Vector.<McCheckBox>=new Vector.<McCheckBox>;
		public function McRadioGroup()
		{
			super();
		}
		public function addMcCheckBox(mcCheckBox:McCheckBox):void
		{
			mcCheckBoxs.push(mcCheckBox);
		}
		override protected function render():void
		{
			for(var i:int=0;i<mcCheckBoxs.length;i++){
				var mcCheckBox:McCheckBox=mcCheckBoxs[i];
				mcCheckBox.buttonmc.y=(mcCheckBox.buttonmc.height+gad)*i;
				mcCheckBox.addEvent();
				mcCheckBox.isButtonModel=true;
				mcCheckBox.newAddEventListener(MoonEvent.MOUSE_DOWN,onMoonHandler);
				this.addChild(mcCheckBox.buttonmc);
			}
			
		}
		
		private function onMoonHandler(e:MoonEvent):void
		{
			var mcCheckBox:McCheckBox=e.currentTarget as McCheckBox;
			for(var i:int=0;i<mcCheckBoxs.length;i++){
				mcCheckBoxs[i].index=0;
				mcCheckBoxs[i].setStatc();
				if(mcCheckBoxs[i]==mcCheckBox) _barIndex=i;
			}
			mcCheckBox.index=1;
			mcCheckBox.setStatc();
			this.newDispatchEvent(MoonEvent.CHANGE,barIndex);
		}
		public function init():void
		{
			for(var i:int=0;i<mcCheckBoxs.length;i++){
				mcCheckBoxs[i].index=0;
				mcCheckBoxs[i].setStatc();
			}
		}
		
		override public function set barIndex(value:int):void
		{
			_barIndex = value;
			mcCheckBoxs[value].index=1;
			mcCheckBoxs[value].setStatc();
		}
		
		public function getMcCheckBoxByIndex(index:int):McCheckBox
		{
			return mcCheckBoxs[index];
		}

		override public function dispose():void
		{
			for(var i:int=0;i<mcCheckBoxs.length;i++){
				var mcCheckBox:McCheckBox=mcCheckBoxs[i];
				mcCheckBox.removeEvent();
				mcCheckBox.newRemoveEventListener(MoonEvent.MOUSE_DOWN,onMoonHandler);
				mcCheckBox.removeFromParent(true);
			}
			mcCheckBoxs.length=0;
			mcCheckBoxs=null;
			super.dispose();
		}
		
	}
}