package org.moon
{
	import org.moon.basic.BasicBar;
	import org.moon.basic.BasicButton;
	import org.moon.basic.BasicContent;
	import org.moon.event.MoonEvent;
	
	/**
	 * ...
	 * @author vinson
	 */
	public class NumPageBar extends BasicBar
	{
		private var buttons:Vector.<BasicButton>=new Vector.<BasicButton>;
		private var buttonUp:BasicButton;
		private var buttonDown:BasicButton;
		private var _gad:int=5;
		private var index:int=0;
		private var currentNum:int=0;
		public static const UP:int=1;
		public static const DOWN:int=2;
		public static const NUM:int=3;
		private var showNum:int;
		protected var _totalPage:int;
		protected var _currentPage:int;
		public static const PREV_PAGE:String="prevPage";
		public static const NEXT_PAGE:String="nextPage";
		public function NumPageBar()
		{
			super();
		}
		/**增加子对象*/
		public function addItem(button:BasicButton,type:int=1):void
		{
			var len:int=buttons.length;
			if(type==3){
				button.name="number-"+index;
				index++;
				buttons.push(button);
			}else{
				button.name="button-"+type;
				if(type==1) 	buttonUp=button;
				else			buttonDown=button;
			}
			button.newAddEventListener(MoonEvent.MOUSE_UP,onHandlerEvent);
			button.addEvent();
			button.isButtonModel=true;
			
		}
		/**把子对象增加到容器中
		 * showNum:可以看见的数字按钮的个数
		 * totalNum:所有数字按钮的个数
		 * */
		public function addToContainer(showNum:int,totalNum:int):void
		{
			this.showNum=showNum;
			this._totalPage=totalNum;
			_currentPage=0;
			this.addChild(buttonUp);
			this.addChild(buttonDown);
			for(var i:int=0;i<buttons.length;i++){
				var button:BasicButton=buttons[i];
				this.addChild(button);
				button.x=buttonUp.width+gad+(button.width+gad)*i;
				button.y=(buttonUp.height-button.height)>>1;
				button.buttonmc.mouseChildren=false;
				button.buttonmc.text.text=String(i+1);
			}
			buttonDown.x=button.x+button.width+gad;
			buttonUp.buttonIsEnabled(false);
			selectButton(0);
		}
		/**按钮事件*/
		private function onHandlerEvent(e:MoonEvent):void
		{
			var button:BasicButton=e.currentTarget as BasicButton;
			if(button.name.split("-")[0]=="button"){
				if(button==buttonUp){
					if(this._currentPage>0)	this._currentPage--;
					this.newDispatchEvent(PREV_PAGE,this._currentPage);
				}else{
					if(this._currentPage<this._totalPage-1) this._currentPage++;
					this.newDispatchEvent(NEXT_PAGE,this._currentPage);
				}
				updatePage();
				selectButton(_currentPage);
			}else{
				selectButton(int(button.name.split("-")[1]));
			}
		}
		/**更新页码*/
		private function updatePage():void
		{
			buttonUp.buttonIsEnabled(true);
			buttonDown.buttonIsEnabled(true);
			if(_totalPage<=1){//总长小于1两个都不能点
				buttonUp.buttonIsEnabled(false);
				buttonDown.buttonIsEnabled(false);
			}else{
				if(this._currentPage==0)						buttonUp.buttonIsEnabled(false);
				else if(this._currentPage==this._totalPage-1)	buttonDown.buttonIsEnabled(false);
			}
			
		}
		/**选择哪个按钮*/
		protected function selectButton(index:int):void
		{
			_currentPage=index;
			updatePage();
			var half:int=Math.ceil(showNum/2);
			var bName:String;
			var current:int=_currentPage+1;
			for(var i:int=0;i<showNum;i++){
				var button:BasicButton=buttons[i];
				if(current<half){
					bName=String(i+1);
				}else if(current>_totalPage-half){
					bName=String(_totalPage-showNum+i+1);
				}else{
					bName=String(current-half+i+1);
				}
				buttons[i].buttonmc.text.text=bName;
				buttons[i].name="number-"+int(int(bName)-1);
				buttons[i].removeEvent();
				buttons[i].addEvent();
				buttons[i].isButtonModel=true;
				buttons[i].buttonmc.gotoAndStop(1);
			}
			if(current<half){
				button=buttons[current-1];
			}else if(current>_totalPage-half){
				button=buttons[showNum-(_totalPage-current)-1];
			}else{
				button=buttons[half-1];
			}
			button.removeEvent();
			button.isButtonModel=false;
			button.buttonmc.gotoAndStop(3);
			this.newDispatchEvent(MoonEvent.CHANGE,this._currentPage);
		}
		/**传入数组与当前页显示个数可以得到当前应该显示的数据数组*/
		public function getCurrentPageArray(array:Array,onePageOne:int):Array
		{
			var returnArr:Array=new Array
			for(var i:int=0;i<onePageOne;i++){
				var index:int=i+(currentPage)*onePageOne;
				if(index<array.length){
					returnArr.push(array[index]);
				}
			}
			return returnArr
		}
		/**设置间隔*/
		public function get gad():int
		{
			return _gad;
		}
		
		public function set gad(value:int):void
		{
			_gad = value;
		}
		
		override public function dispose():void
		{
			var i:int=0;
			for(i=0;i<buttons.length;i++){
				buttons[i].dispose();
				buttons[i]=null;
			}
			buttons.length=0;
			buttons=null;
		}

		public function get currentPage():int
		{
			return _currentPage;
		}

		
	}
}
