package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import org.moon.MoonMain
	/**
	 * ...
	 * @author vinson
	 */
	[SWF(width = "1250", height = "650", backgroundColor = "#999998", frameRate = "30")]
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			this.addChild(new MoonMain)
			// entry point
		}
		
	}
	
}