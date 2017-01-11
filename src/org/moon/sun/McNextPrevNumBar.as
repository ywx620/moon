package org.moon.sun
{
	import flash.text.TextField;
	
	import modules.utils.CreateComponent;
	import modules.utils.MaterialManager;
	
	import org.moon.PageBar;
	import org.moon.basic.BasicContent;
	import org.moon.event.MoonEvent;
	import org.moon.utils.MoonConst;

	/**
	 * ...2015-7-17
	 * 有数字和上下页同时存在的组件
	 * @author vinson
	 */
	public class McNextPrevNumBar extends BasicContent
	{
		protected const PAGE_NUM:int=9;
		protected var pageNum:int=PAGE_NUM;
		protected var buttons:Vector.<McButton>=new Vector.<McButton>;
		protected var half:int=Math.ceil(pageNum/2);
		protected var current:int=1;
		protected var total:int=5;
		protected var mcPageBar:McPageBar;
		public function McNextPrevNumBar()
		{
			super();
		}
		public function setData(num:int):void
		{
			total=num;
		}
		protected function removeMcPageBar():void
		{
			if(mcPageBar){
				mcPageBar.newRemoveEventListener(PageBar.NEXT_PAGE,onNextPage);
				mcPageBar.newRemoveEventListener(PageBar.PREV_PAGE,onNextPage);
				mcPageBar.removeFromParent(true);
				mcPageBar=null;
			}
			for(var i:int=0;i<buttons.length;i++){
				var btn:McButton=buttons[i];
				btn.removeEvent();
				btn.newRemoveEventListener(MoonEvent.MOUSE_DOWN,onNextPage2);
				if(btn.buttonmc){
					btn.buttonmc.parent.removeChild(btn.buttonmc);
				}
				btn.dispose();
				btn=null;
			}
			buttons.length=0;
		}
		public function createPageBar(x:int, y:int):void
		{
			removeMcPageBar();
			var bar:McPageBar=new McPageBar;
			var btnPrev:McButton=new McButton;
			btnPrev.buttonmc=MaterialManager.getIns().getMovieClip("btn_prev");
			var btnNext:McButton=new McButton;
			btnNext.buttonmc=MaterialManager.getIns().getMovieClip("btn_next");
			bar.addMcItem(btnPrev,"remove");
			bar.addMcItem(btnNext,"add");
			this.addChild(btnPrev.buttonmc);
			this.addChild(btnNext.buttonmc);
			btnPrev.buttonmc.y=btnNext.buttonmc.y=y;
			
			bar.totalPage=total;
			bar.reset();
			bar.newAddEventListener(PageBar.NEXT_PAGE,onNextPage);
			bar.newAddEventListener(PageBar.PREV_PAGE,onNextPage);
			pageNum=PAGE_NUM;
			if(total<=pageNum){//如若总数少于指定数，不显示上下页，把总数定为指定数
				btnPrev.buttonmc.visible=false;
				btnNext.buttonmc.visible=false;
				pageNum=total;
			}
			var xx:Number=x-(40*pageNum)/2;
			for(var i:int=0;i<pageNum;i++){
				var btn:McButton=new McButton;
				btn.setSkin(MoonConst.BUTTON_MOVIECLIP,MaterialManager.getIns().getMovieClip("button_num_bg"));
				btn.isButtonModel=true;
				btn.addEvent();
				btn.newAddEventListener(MoonEvent.MOUSE_DOWN,onNextPage2);
				this.addChild(btn);
				var label:TextField=CreateComponent.createTextField(0,4,31,20,"center",16);
				label.name="label";
				btn.buttonmc.addChild(label);
				btn.x=xx+(btn.buttonmc.width+4)*i;
				btn.y=y+2;
				buttons.push(btn);
			}
			btnPrev.buttonmc.x=xx-btnPrev.buttonmc.width;
			btnNext.buttonmc.x=btn.x+btn.buttonmc.width;
			onNextPage();
			mcPageBar=bar;
		}
		/**点数字*/
		protected function onNextPage(e:MoonEvent=null):void
		{
			if(e!=null)	current=int(e.data);
			else		current=1;
			updateNextPage();
		}
		/**上下页*/
		protected function onNextPage2(e:MoonEvent):void
		{
			var btn:McButton=e.currentTarget as McButton;
			var label:TextField=btn.buttonmc.getChildByName("label") as TextField;
			current=int(label.text);
			mcPageBar.currentPage=current;
			updateNextPage();
		}
		protected function updateNextPage():void
		{
			for(var i:int=0;i<pageNum;i++){
				var btn:McButton=buttons[i];
				var label:TextField=btn.buttonmc.getChildByName("label") as TextField;
				if(current<=half){
					label.text=String(i+1);
				}else if(current>total-half){
					label.text=String(total-pageNum+i+1);
				}else{
					label.text=String(current-half+i+1);
				}
				btn.isButtonModel=true;
				btn.removeEvent();
				btn.addEvent();
				btn.buttonmc.gotoAndStop(1);
			}
			if(current<=half){
				btn=buttons[current-1];
			}else if(current>total-half){
				btn=buttons[pageNum-(total-current)-1];
			}else{
				btn=buttons[half-1];
			}
			btn.isButtonModel=false;
			btn.removeEvent();
			btn.buttonmc.gotoAndStop(3);
			this.newDispatchEvent(MoonEvent.CHANGE,current);
		}
		public function setCurrentPaget(value:int):void
		{
			current=value;
			updateNextPage();
		}
		public function getCurrentPaget():int
		{
			return current
		}
		override public function dispose():void
		{
			removeMcPageBar();
		}
	}
}