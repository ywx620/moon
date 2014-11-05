package org.moon
{
	import flash.display.BitmapData;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import org.moon.basic.BasicBar;
	import org.moon.basic.BasicButton;
	import org.moon.event.MoonEvent;
	import org.moon.utils.MoonConst;
	import org.moon.utils.NameList;
	import org.moon.utils.Scale9Image;

	/**
	 * ...
	 * @author vinson
	 */
	public class PageBar extends BasicBar
	{
		protected var buttonUp:BasicButton;
		protected var buttonDown:BasicButton;
		protected var _currentPage:int=1;
		protected var _totalPage:int=5;
		protected var textField:TextField;
		protected var background:Scale9Image;
		protected var _pageWidth:int=80;//默认宽度
		protected static const UP:String="up";
		protected static const DOWN:String="down";
		public static const PREV_PAGE:String="prevPage";
		public static const NEXT_PAGE:String="nextPage";
		public function PageBar()
		{
			modelType="page";
			initSkin();
		}
		/**初始化皮肤*/
		private function initSkin():void
		{
			buttonUp=new BasicButton;
			buttonDown=new BasicButton;
			buttonDic[UP]=buttonUp;
			buttonDic[DOWN]=buttonDown;
			buttons.push(buttonUp,buttonDown);
		}
		/**设置皮肤*/
		override public function setSkin(type:String, skin:Object,param:Object=null):void
		{
			super.setSkin(type,skin,param);
			if(type==MoonConst.PAGE_BACKGROUND){
				background=new Scale9Image(skin.clone());
			}
		}
		/**渲染,如果没给bar设置皮肤,它会使用主题皮肤*/
		override protected function render():void
		{
			//渲染按钮
			if(buttonUp.hasSkinData==false){
				for(var model:String in NameList.list){
					if(model==MoonConst.MODEL_PAGE){
						for(var type:String in NameList.list[model]){
							if(type.split("-")[1]=="background"){
								var image:BitmapData=NameList.list[model][type];
								if(!background)	background=new Scale9Image(image.clone())
							}else{
								setSkin(type,NameList.list[model][type],NameList.param[model][type]);
							}
						}
						break;
					}
				}
			}
			
			for each(var button:BasicButton in buttons){
				this.addChild(button);
				button.newAddEventListener(MoonEvent.MOUSE_UP,onMouseHandler);
			}
			this.addChild(background);
			var upw:Number=buttonUp.width;
			var downx:Number=_pageWidth-upw;
			buttonDown.x=downx;
			background.width=_pageWidth-upw*2;
			background.x=upw;
			
			textField=new TextField;
			textField.width=background.width;
			textField.height=background.height;
			textField.x=background.x;

			var textformat:TextFormat=new TextFormat();
			textformat.color=0XFFFFFF
			textformat.align="center";
			textField.defaultTextFormat=textformat;
			
			this.addChild(textField);
			
			updatePage();
			
		}
		private function onMouseHandler(e:MoonEvent):void
		{
			var btn:BasicButton=e.currentTarget as BasicButton;
			if(btn==buttonUp){
				if(this._currentPage>1)	this._currentPage--;
				this.newDispatchEvent(PREV_PAGE,this._currentPage);
			}else{
				if(this._currentPage<this._totalPage) this._currentPage++;
				this.newDispatchEvent(NEXT_PAGE,this._currentPage);
			}
			updatePage();
		}
		/**更新页码*/
		private function updatePage():void
		{
			buttonIsEnabled(this.buttonUp,true);
			buttonIsEnabled(this.buttonDown,true);
			if(_totalPage<=1){
				buttonIsEnabled(this.buttonUp,false);
				buttonIsEnabled(this.buttonDown,false);
				this.textField.text="1/1";
			}else{
				if(this._currentPage==1)						buttonIsEnabled(this.buttonUp,false);
				else if(this._currentPage==this._totalPage)	buttonIsEnabled(this.buttonDown,false);
				this.textField.text=this._currentPage+"/"+this._totalPage
			}
		}
		protected function buttonIsEnabled(btn:BasicButton,boo:Boolean):void
		{
			btn.removeEvent();
			if(boo==true) btn.addEvent();
			btn.buttonIsEnabled(boo);
		}
		public function get currentPage():int
		{
			return _currentPage;
		}

		public function set currentPage(value:int):void
		{
			_currentPage = value;
		}

		public function get totalPage():int
		{
			return _totalPage;
		}

		public function set totalPage(value:int):void
		{
			_totalPage = value;
		}
		public function reset():void
		{
			currentPage=1;
			updatePage();
		}
		/**自动计算总数并且更新界面
		 * arrayLen:实际数据数组长度
		 * onePageOne:一页显示个数
		 * */
		public function setTotalPageUpdate(arrayLen:int,onePageOne:int):void
		{
			totalPage=Math.ceil(arrayLen/onePageOne);
			currentPage=1;
		}
		/**传入数组与当前页显示个数可以得到当前应该显示的数据数组*/
		public function getCurrentPageArray(array:Array,onePageOne:int):Array
		{
			var returnArr:Array=new Array
			for(var i:int=0;i<onePageOne;i++){
				var index:int=i+(currentPage-1)*onePageOne;
				if(index<array.length){
					returnArr.push(array[index]);
				}
			}
			return returnArr
		}
		override public function dispose():void
		{
			var i:int=0;
			if(buttons){
				for(i=0;i<buttons.length;i++){
					buttons[i].dispose();
					buttons[i].newRemoveEventListener(MoonEvent.MOUSE_UP,onMouseHandler);
					buttons[i]=null;
				}
				buttons.length=0;
				buttons=null;
			}
			super.dispose();
			textField=null;
			background=null;
		}

	}
}

