package org.moon.basic
{
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import org.moon.event.MoonEvent;
	import org.moon.utils.Scale9Image;
	
	/**
	 * ...基础容器
	 * @author vinson
	 */
	public class BasicContent extends Sprite
	{
		private var dataEvent:Dictionary=new Dictionary;
		protected var dataSkin:Dictionary=new Dictionary;
		protected var _width:Number=-1;
		protected var _height:Number=-1;
		public function BasicContent()
		{
			initialization()
			this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		protected function initialization():void
		{
			// TODO Auto Generated method stub
			
		}
		
		protected function init(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,init);
			render();
		}
		/**渲染*/
		protected function render():void
		{
			
		}
		/**设置位置*/
		public function move(x:Number,y:Number):void
		{
			this.x=x;
			this.y=y;
		}
		/**设置大小*/
		public function setSize(w:Number=-1,h:Number=-1):void
		{
			_width=w;_height=h;
		}
		/**设置皮肤*/
		public function setSkin(type:String,skin:Object,param:Object=null):void
		{
			if(skin is BitmapData){
				var image:Scale9Image=new Scale9Image(skin.clone());
				if(param){
					if(param["rect"]) image.scale9Grid=param["rect"];
				}
				dataSkin[type]=image;
			}else if(skin is Class){
				dataSkin[type]=new skin;
			}else{
				dataSkin[type]=skin;
			}
			var types:Array=type.split("-");
			if(types[types.length-1]=="up"){
				this.addChildAt(dataSkin[type],0);
			}else if(types[types.length-1]=="movieclip"){
				if(param==null){
					dataSkin[type].x=dataSkin[type].y=0;
					this.addChild(dataSkin[type]);
				}
			}
		}
		/**发布事件*/
		protected function newDispatchEvent(type:String,data:Object=null):void
		{
			var fun:Function=dataEvent[type] as Function;
			if(fun!=null){
				var moonEvent:MoonEvent=new MoonEvent;
				moonEvent.currentTarget=this;
				moonEvent.data=data;
				moonEvent.type=type;
				fun(moonEvent);
			}
		}
		/**帧听事件*/
		public function newAddEventListener(type:String, listener:Function):void
		{
			if(dataEvent[type]==null){
				dataEvent[type]=listener;
			}
		}
		/**删除事件*/
		public function newRemoveEventListener(type:String, listener:Function):void
		{
			if(dataEvent[type]){
				delete dataEvent[type];
			}
		}
		/**把自己从父级删除*/
		public function removeFromParent(dispose:Boolean=false):void
		{
			var _parent:DisplayObjectContainer=this.parent as DisplayObjectContainer;
			if (_parent) {
				if(dispose) this.dispose();
				_parent.removeChild(this);
			}
			_parent=null;
		}
		/**删除所有的*/
		public function removeChildAll(beginIndex:int=0, endIndex:int=2147483647,dispose:Boolean=false):void
		{
			if (endIndex < 0 || endIndex >= numChildren) 
				endIndex = numChildren - 1;
			
			for (var i:int=beginIndex; i<=endIndex; ++i)
				removeChildIndex(beginIndex, dispose);
		}
		/**删除index层的*/
		public function removeChildIndex(beginIndex:int, dispose:Boolean):void
		{
			if (beginIndex >= 0 || beginIndex < numChildren){ 
				var basicContent:BasicContent=this.getChildAt(beginIndex) as BasicContent;
				if(basicContent) basicContent.removeFromParent(dispose);
			}
		}
		
		/**消耗*/
		public function dispose():void
		{
			this.removeChildAll(0,-1,true);
			dataEvent=null;
			dataSkin=null;
		}
		
		/**是否有皮肤数据*/
		public function get hasSkinData():Boolean
		{
			var i:int=0;
			for each(var s:String in dataSkin) i++;
			return i>0;
		}
		
	}
}