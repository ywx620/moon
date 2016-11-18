package org.moon.utils.time
{
	import flash.events.Event;
	import flash.utils.Dictionary;

	/**
	 * ...2016-11-17
	 * @author vinson
	 * 时间的简单工厂模式(生产倒计时和计时器两种产品)
	 * 可根据产品标签名和类型的不同生产各种独立的产品,各产品独立运行相互不干扰
	 * 在UI层上的表示,UI关闭后,产品依然在继续运行.
	 * 重新打开UI后,只要判断一下产品时间是否为0,不为0则不需要重新赋直,产品会继续运行
	 * 如果是倒计时,当时间为0时会自动销毁,如果是计时器则需要手动
	 */
	public class TimeFactory
	{
		private static var _instance:TimeFactory;
		private var content:Dictionary;
		public static const COUNT_DOWN:String="down";
		public static const COUNT_UP:String="up";
		public function TimeFactory(parameter:SingletonEnforcer) {
			content = new Dictionary();
		}
		public static function getIns():TimeFactory {
			if(_instance == null) {
				_instance = new TimeFactory(new SingletonEnforcer());
			}
			return _instance;
		}
		/**在工厂中创建时间产品*/
		public function createTime(name:String,type:String="down"):ITime
		{
			if(content[name]==null){//如果工厂仓库中没有找到同标签的产品,那么生产新产品
				var time:ITime;
				if(type==COUNT_DOWN){//创建倒计时产品
					time=new TimeCountDown();
					TimeCountDown(time).addEventListener(Event.COMPLETE,onComplete);
				}else{//创建计时器产品
					time=new TimeCountUp();
				}
				time.name=name;//给产品标个签名
				content[name]=time;//把产品放入工厂仓库中
			}
			return content[name];
		}
		/**找到时间产品然后销毁掉(倒计时的时间到了是可以自动销毁,不过计时器是不能自动销毁的)*/
		public function removeTime(name:String):void
		{
			var time:ITime=content[name];
			if(time){
				dispose(time);
			}
		}
		/**当倒计时产品时间为0时表示此产品已经过期,时间工厂会自动把它销毁掉*/
		protected function onComplete(event:Event):void
		{
			var time:ITime=event.currentTarget as ITime;
			dispose(time)
		}
		/**消毁时间产品*/
		private function dispose(time:ITime):void
		{
			time.dispose();
			delete content[time.name];
		}
	}
}
class SingletonEnforcer {
	
}