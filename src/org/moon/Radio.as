package org.moon
{
	import org.moon.utils.MoonConst;
	/**
	 * ...
	 * @author vinson
	 */
	public class Radio extends CheckBox
	{
		public function Radio()
		{
			myTypeDefault=MoonConst.RADIO_DEFAULT;
			myTypeOver=MoonConst.RADIO_OVER;
			myTypeSelect=MoonConst.RADIO_SELECT;
			myModel=MoonConst.MODEL_RADIO;
		}
		override public function setStatc():void
		{
			if(_index==0){
				currentStatc=MoonConst.BUTTON_UP;
				isButtonModel=true;
			}else{
				currentStatc=MoonConst.BUTTON_DOWN;
				isButtonModel=false;
			}
		}
	}
}