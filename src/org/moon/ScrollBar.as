package org.moon
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import org.moon.basic.BasicBar;
	import org.moon.basic.BasicButton;
	import org.moon.event.MoonEvent;
	import org.moon.utils.MoonConst;
	import org.moon.utils.NameList;

	/**
	 * ...滚动条
	 * @author vinson
	 */
	public class ScrollBar extends BasicBar
	{
		protected var buttonUp:BasicButton;
		protected var buttonDown:BasicButton;
		protected var buttonBody:BasicButton;
		protected var buttonBar:BasicButton;
		protected static const UP:String="up";
		protected static const DOWN:String="down";
		protected static const BODY:String="body";
		protected static const BAR:String="bar";
		protected var _scrollTarget:DisplayObject;//滚动的对象
		protected var maskQuad:Sprite;//遮罩
		protected var scrollBarHeight:Number;//组件的高度
		protected var scrollBarMoveHeight:Number;//bar能移动的范围高度
		protected var _moveDistance:int=10;//移动的距离
		protected var waitTimer:int;//鼠标按钮下后等待时间,用来表示一直按住就可以一直滚动
		protected var timer:Timer;//鼠标按钮下后等待时间控制器
		protected var moveStatc:String;//上下移动状态
		protected var _scrollHeight:int=100;//滚动条默认高度
		protected var lineBar:Bitmap;//滚动条的拉把中间的三条杆
		public var isUpdateBarHeight:Boolean=true;//是否更新滚动条中间的拉把长短
		public function ScrollBar()
		{
			modelType="scroll";
			initSkin();
		}
		/**初始化皮肤*/
		private function initSkin():void
		{
			buttonUp=new BasicButton;
			buttonDown=new BasicButton;
			buttonBody=new BasicButton;
			buttonBar=new BasicButton;
			buttonUp.name=UP;
			buttonDown.name=DOWN;
			buttonBody.name=BODY;
			buttonBar.name=BAR;
			buttonDic[UP]=buttonUp;
			buttonDic[DOWN]=buttonDown;
			buttonDic[BODY]=buttonBody;
			buttonDic[BAR]=buttonBar;
			buttons.push(buttonUp,buttonDown,buttonBody,buttonBar);
			buttonUp.useHandCursor=false;
			buttonDown.useHandCursor=false;
			buttonBody.useHandCursor=false;
			buttonBar.useHandCursor=false;
		}
		/**设置皮肤*/
		override public function setSkin(type:String, skin:Object,param:Object=null):void
		{
			super.setSkin(type,skin,param);
			var types:Array=type.split("-");
			var buttonType:String=types[1];
			var statcType:String=types[2];
			if(types[0]==modelType){
				if(statcType=="line"){
					lineBar=new Bitmap(skin as BitmapData);
				}
			}
		}
		/**渲染,如果没给bar设置皮肤,它会使用主题皮肤*/
		override protected function render():void
		{
			//渲染按钮
			if(buttonBar.hasSkinData==false){
				for(var model:String in NameList.list){
					if(model==MoonConst.MODEL_SCROLL){
						for(var type:String in NameList.list[model]){
							setSkin(type,NameList.list[model][type],NameList.param[model][type]);
						}
						break;
					}
				}
			}
			var bodyHeight:Number=_scrollHeight-buttonUp.height*2;
			buttonBody.setSize(buttonBody.width,bodyHeight);
			
			buttonBar.y=buttonBody.y=buttonUp.height;
			buttonDown.y=buttonBody.y+buttonBody.height;
			for each(var button:BasicButton in buttons){
				this.addChild(button);
				button.newAddEventListener(MoonEvent.MOUSE_UP,onMouseHandler);
				button.newAddEventListener(MoonEvent.MOUSE_DOWN,onMouseHandler);
			}
			scrollBarHeight=buttonUp.height+buttonBody.height+buttonDown.height;
			scrollBarMoveHeight=buttonBody.height - buttonBar.height;
			//渲染内容
			if(scrollTarget){
				scrollTarget.x=-1*(scrollTarget.width);
				maskQuad.x=scrollTarget.x;
				this.addChild(scrollTarget);
				scrollTarget.mask=maskQuad;
				this.addChild(maskQuad);
				scrollTarget.addEventListener(MouseEvent.MOUSE_OVER,onScrollTargetHandler);
				scrollTarget.addEventListener(Event.ADDED,onScrollTargetHandler);
				scrollTarget.addEventListener(Event.REMOVED,onScrollTargetHandler);
			}
			updateButtonBar();
		}
		
		protected function onScrollTargetHandler(event:Event):void
		{
			if (event.type == Event.ADDED || event.type == Event.REMOVED) {
				if(isUpdateBarHeight){
					setTimeout(updateButtonBar, 50);
				}
			}else{
				scrollTarget.addEventListener(MouseEvent.MOUSE_WHEEL,onMouseWheel);
				scrollTarget.addEventListener(MouseEvent.MOUSE_OUT,onMouseWheel);
			}
		}
		/**鼠标滚轮事件*/
		protected function onMouseWheel(event:MouseEvent):void
		{
			if(event.type==MouseEvent.MOUSE_WHEEL){
				if (event.delta > 0)	moveUp();
				else					moveDown();
			}else{
				scrollTarget.removeEventListener(MouseEvent.MOUSE_WHEEL,onMouseWheel);
				scrollTarget.removeEventListener(MouseEvent.MOUSE_OUT,onMouseWheel);
			}
			
		}
		/**鼠标事件*/
		private function onMouseHandler(e:MoonEvent):void
		{
			var button:BasicButton=e.currentTarget as BasicButton
			if(e.type==MoonEvent.MOUSE_DOWN){
				if(button.name==UP){
					waitTimer = setTimeout(addTimer,500,UP);
				}else if(button.name==DOWN){
					waitTimer = setTimeout(addTimer,500,DOWN);
				}else if(button.name==BAR){
					buttonBar.startDrag(false,new Rectangle(buttonBody.x,buttonBody.y,0,buttonBody.height-buttonBar.height));
					this.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
					for each(var btn:BasicButton in buttons){
						btn.removeEvent();
					}
				}
			}else{
				if(button.name==UP){
					moveUp();
				}else if(button.name==DOWN){
					moveDown();
				}else if(button.name==BODY){
					var y:int=this.mouseY;
					if(y<buttonBar.y){
						buttonBar.y=y;
					}else{
						buttonBar.y=y-buttonBar.height;
					}
					contentMoveFree();
				}
			}
			this.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		/**增加时间*/
		private function addTimer(type:String):void
		{
			moveStatc=type;
			removeTimer();
			timer=new Timer(100);
			timer.addEventListener(TimerEvent.TIMER,onEnterFrame);
			timer.start();
		}
		/**删除时间*/
		private function removeTimer():void
		{
			if(timer){
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER,onEnterFrame);
				timer=null;
			}
		}
		/**一直在移动*/
		protected function onEnterFrame(event:TimerEvent):void
		{
			if(moveStatc==UP)	moveUp();
			else				moveDown();
		}
		/**向上移动*/
		protected function moveUp():void
		{
			if(buttonBar.y>buttonUp.height){
				buttonBar.y-=_moveDistance;
				if(buttonBar.y<=buttonUp.height){
					buttonBar.y=buttonUp.height;
					removeTimer();
				}
				contentMoveFree();
			}
		}
		/**向下移动*/
		protected function moveDown():void
		{
			if((buttonBar.y+buttonBar.height)<buttonDown.y){
				buttonBar.y+=_moveDistance;
				if((buttonBar.y+buttonBar.height)>=buttonDown.y){
					buttonBar.y=buttonDown.y-buttonBar.height;
					removeTimer();
				}
				contentMoveFree();
			}
		}
		/**设置显示的范围大小*/
		override public function setSize(w:Number=-1,h:Number=-1):void
		{
			maskQuad=new Sprite;
			maskQuad.graphics.beginFill(0);
			maskQuad.graphics.drawRect(0,0,w,h);
			maskQuad.graphics.endFill();
			scrollHeight=h;
		}
		/**场景鼠标松开*/
		protected function onMouseUp(event:MouseEvent):void
		{
			buttonBar.stopDrag();
			buttonBar.currentStatc=MoonConst.BUTTON_UP;
			this.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			this.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			for each(var button:BasicButton in buttons){
				button.addEvent();
			}
			clearTimeout(waitTimer);
			removeTimer();
		}
		/**场景鼠标移动*/
		protected function onMouseMove(event:MouseEvent):void
		{
			contentMoveFree();
		}
		/**内容移动*/
		protected function contentMoveFree():void
		{
			if(scrollTarget){
				var moveHeight:int = scrollTargetHeith - scrollBarHeight;
				var scrollPercent:Number = (buttonBar.y-buttonUp.height) / scrollBarMoveHeight;
				scrollTarget.y = 0 - (scrollPercent * moveHeight);
			}
		}
		/**计算buttonBar的变化*/
		protected function updateButtonBar():void
		{	
			var targetHeith:int=scrollTargetHeith-buttonUp.height*2;
			if (targetHeith <= buttonBody.height) {
				buttonBar.y=buttonUp.height;
				contentMoveFree();
				buttonBar.visible=false;
				return;
			}else{
				buttonBar.visible=true;
			}
			var barHeight:Number = (buttonBody.height / targetHeith) * buttonBody.height;
			buttonBar.setSize(buttonBar.width,barHeight);
			scrollBarMoveHeight=buttonBody.height - buttonBar.height;
			if(lineBar){
				var x:Number=(buttonBar.width-lineBar.width)>>1;
				var y:Number=(buttonBar.height-lineBar.height)>>1;
				buttonBar.addIcon(lineBar,x,y);
			}
			
			if (scrollTarget) {
				var boo1:Boolean = (buttonBar.y + buttonBar.height) > buttonDown.y;
				var boo2:Boolean = scrollTarget.y +scrollTarget.height < _scrollHeight;
				if (boo1||boo2) {
					buttonBar.y = buttonDown.y - buttonBar.height;
					scrollTarget.y = _scrollHeight - scrollTarget.height;
				}
				
			}
			
		}
		
		protected function get scrollTargetHeith():Number
		{
			return scrollTarget.height;
		}

		/**显示的内容*/
		public function get scrollTarget():DisplayObject
		{
			return _scrollTarget;
		}

		/**
		 * @private
		 */
		public function set scrollTarget(value:DisplayObject):void
		{
			_scrollTarget = value;
		}
		/**滚动条长度*/
		public function get scrollHeight():int
		{
			return _scrollHeight;
		}

		public function set scrollHeight(value:int):void
		{
			_scrollHeight = value;
		}
		
		override public function dispose():void
		{
			removeTimer();
			this.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			for each(var button:BasicButton in buttons){
				button.newRemoveEventListener(MoonEvent.MOUSE_UP,onMouseHandler);
				button.newRemoveEventListener(MoonEvent.MOUSE_DOWN,onMouseHandler);
				button.dispose();
				button=null;
			}
			if(scrollTarget){
				scrollTarget.removeEventListener(MouseEvent.MOUSE_WHEEL,onMouseWheel);
				scrollTarget.removeEventListener(MouseEvent.MOUSE_OUT,onMouseWheel);
				scrollTarget.removeEventListener(Event.ADDED,onScrollTargetHandler);
				scrollTarget.removeEventListener(Event.REMOVED,onScrollTargetHandler);
				scrollTarget.removeEventListener(MouseEvent.MOUSE_OVER,onScrollTargetHandler);
				scrollTarget=null;
			}
			buttons.length=0;
			buttons=null;
			buttonUp=null;
			buttonDown=null;
			buttonBody=null;
			buttonBar=null;
			buttonDic=null;
			super.dispose();
		}
	}
}