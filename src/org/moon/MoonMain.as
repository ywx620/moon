package org.moon
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	import org.moon.basic.BasicButton;
	import org.moon.basic.BasicUI;
	import org.moon.event.MoonEvent;
	import org.moon.utils.MoonConst;

	/**
	 * ...
	 * @author vinson
	 */
	public class MoonMain extends Sprite
	{
		private var scrollBar:ScrollBar;
		private var scrollTextBar:ScrollTextBar;
		private var pageBar:PageBar;
		private var warnBar:WarnBar;
		private var listBar:ListBar;
		private var numberBar:NumberBar;
		private var progressBar:ProgressBar;
		public function MoonMain()
		{
			new MoonTheme;
			createScrollBar(110,10);
			createPageBar(300,30);
			createListBar(300,300);
			createNumberBar(10,250);
			createProgressBar(300,250);
			createCheckBox(200,150);
			createRadioGroup(300,100);	
			
		}
		
		private function createRadioGroup(x:int, y:int):void
		{
			var bar:RadioGroup=new RadioGroup;
			bar.data=["radio1","radio2","radio3","radio4","radio5"]
			this.addChild(bar);
			bar.move(x,y);
		}
		
		private function createCheckBox(x:int, y:int):void
		{
			var checkbox:CheckBox=new CheckBox;
			this.addChild(checkbox);
			checkbox.label="hello";
			checkbox.setLabelSeat(25,0);
			checkbox.x=x;checkbox.y=y;
			
			checkbox=new CheckBox;
			this.addChild(checkbox);
			checkbox.label="moon";
			checkbox.setLabelSeat(25,0);
			checkbox.x=x;checkbox.y=y+25;
			
			checkbox=new CheckBox;
			this.addChild(checkbox);
			checkbox.label="sun";
			checkbox.setLabelSeat(25,0);
			checkbox.x=x;checkbox.y=y+50;
		}
		
		private function createProgressBar(x:int, y:int):void
		{
			progressBar=new ProgressBar;
			progressBar.x=x;progressBar.y=y;
			//不使用主题皮肤，自己设定皮肤
			progressBar.setSkin(MoonConst.PROGRESS_BACKGROUND,	BasicUI.getBitmapData(BasicUI.getRect(100,18,0)));
			progressBar.setSkin(MoonConst.PROGRESS_BAR,			BasicUI.getBitmapData(BasicUI.getRect(100,18,0XFF0000)));
			//progressBar.setSize(200,30);
			this.addChild(progressBar);
			progressBar.value=0.5;
			//使用主题皮肤
			var p:ProgressBar=new ProgressBar;
			p.x=x;p.y=y+20;
			this.addChild(p);
			p.value=0.5;
		}
		
		private function createNumberBar(x:int, y:int):void
		{
			numberBar=new NumberBar;
			this.addChild(numberBar);
			numberBar.move(x,y);
		}
		
		private function createListBar(x:int, y:int):void
		{
			// TODO Auto Generated method stub
			listBar=new ListBar;
			listBar.data=["list1","list2","list3","list4"];
			this.addChild(listBar);
			listBar.move(x,y);
		}
		
		private function createWarnBar(x:int, y:int):void
		{
			warnBar=new WarnBar;
			warnBar.move(x,y);
			warnBar.label="<font color='#ff0000'>不用老是提示我好吗不用老是提示我好吗</font>"
			warnBar.newAddEventListener(WarnBar.SURE,onWarnHandler);
			warnBar.newAddEventListener(WarnBar.CANCEL,onWarnHandler);
			this.addChild(warnBar);
		}		
		
		private function onWarnHandler(e:MoonEvent):void
		{
			if(e.type==WarnBar.SURE){
				trace("我点的是确定")
			}else{
				trace("我点的是取消")
			}
			var bar:WarnBar=e.currentTarget as WarnBar;
			bar.removeFromParent(true);
			bar=null;
		}
		
		private function createScrollBar(x:int, y:int):void
		{
			scrollBar=new ScrollBar;
			scrollBar.move(x,y);
			scrollBar.setSize(100,200);
			scrollBar.scrollTarget=BasicUI.getRectAndX(100,200,0XFFFFFF);
			this.addChild(scrollBar);
			
			var btn:BasicButton=new BasicButton;
			this.addChild(btn);
			btn.newAddEventListener(MoonEvent.MOUSE_UP,onMoonEvent);
			btn.label="增加长度";
			btn.x=x+30;
			btn.y=y;
			
			var btn2:BasicButton=new BasicButton;
			this.addChild(btn2);
			btn2.newAddEventListener(MoonEvent.MOUSE_UP,onMoonEvent);
			btn2.newAddEventListener(MoonEvent.MOUSE_OVER,onMoonEvent);
			btn2.label="减少长度";
			btn2.width=150;
			btn2.x=x+30;
			btn2.y=y+40;
			
			var text:TextField=new TextField;
			scrollTextBar=new ScrollTextBar();
			scrollTextBar.textSeat="right";
			scrollTextBar.x=x;
			scrollTextBar.y=y+300;
			scrollTextBar.scrollTextTarget=text;
			scrollTextBar.setSize(100,150);
			text.text="asdlfjad;lfjasdflksdjfl;kasdjflksajdfl;kasjdflkasdjfl;asdjfl;askdfjasl;dkfj;asdlfjad;lfjasdflksdjfl;kasdjflksajdfl;kasjdflkasdjfl;asdjfl;askdfjasl;dkfj;asdlfjad;lfjasdflksdjfl;kasdjflksajdfl;kasjdflkasdjfl;asdjfl;askdfjasl;dkfj;"
			this.addChild(scrollTextBar);
			text.type=TextFieldType.INPUT;
		
		}
		
		private function onMoonEvent(e:MoonEvent):void
		{
			var btn:BasicButton=e.currentTarget as BasicButton
			var container:Sprite=scrollBar.scrollTarget as Sprite;
			if(e.type==MoonEvent.MOUSE_OVER){
				//trace(e.type)
				TipsManager.getIns().showSimple("<font color='#FFFFFF'>我只是打酱油的<br>我只是打酱油的</font>",btn,TipsManager.FOLLOW);
				return;
			}
			if(btn.label=="增加长度"){
				var box:Sprite=BasicUI.getRectAndX(100,100,BasicUI.randomColor);
				box.y=container.height;
				container.addChild(box);
				
				createWarnBar(500,300);
			}else{
				container.removeChildAt(container.numChildren-1);
			}
		}
		private var buttons:Vector.<BasicButton>=new Vector.<BasicButton>;
		private var pageNum:int=6;
		private var half:int=Math.ceil(pageNum/2);
		private var current:int=1;
		private var total:int=15;
		private var icon:Sprite;
		private function createPageBar(x:int, y:int):void
		{
			pageBar=new PageBar;
			this.addChild(pageBar);
			pageBar.move(x,y);
			pageBar.totalPage=total;
			pageBar.newAddEventListener(PageBar.NEXT_PAGE,onNextPage);
			pageBar.newAddEventListener(PageBar.PREV_PAGE,onNextPage);
			
			icon=BasicUI.getScrollLineBar(10,10,0)
			
			for(var i:int=0;i<pageNum;i++){
				var btn:BasicButton=new BasicButton;
				this.addChild(btn);
				btn.label=String(i+1);
				btn.x=x+100*i;
				btn.y=y+30;
				buttons.push(btn);
			}
			
		}
		
		private function onNextPage(e:MoonEvent):void
		{
			current=int(e.data);
			trace(current);
			for(var i:int=0;i<pageNum;i++){
				var btn:BasicButton=buttons[i];
				if(current<=half){
					btn.label=String(i+1);
				}else if(current>total-half){
					btn.label=String(total-pageNum+i+1);
				}else{
					btn.label=String(current-half+i+1);
				}
			}
			if(current<=half){
				btn=buttons[current-1];
			}else if(current>total-half){
				btn=buttons[pageNum-(total-current)-1];
			}else{
				btn=buttons[half-1];
			}
			btn.addIcon(icon);
		}
		
	}
}