package org.moon
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import org.moon.basic.BasicLabel;
	import org.moon.tree.MoonTreeCellRenderer;
	import org.moon.tree.Tree;
	import org.moon.utils.time.ITime;
	import org.moon.utils.time.TimeFactory;
	import org.moon.utils.time.TimeText;
	
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
		private var tabbar:TabBar;
		private var timebar:TimeBar;
		public function MoonMain()
		{
			new MoonTheme;
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			createScrollBar(110,10);
			createWarnBar(500,300);
			createPageBar(300,30);
			createListBar(300,300);
			createNumberBar(10,250);
			createProgressBar(300,250);
			createCheckBox(200,150);
			createRadioGroup(300,100);
			createTabBar(400, 10);
			createSliderBar(400, 200);
			createAutoWarnBar(500, 500);
			createIntegerBar(550, 180);
			createTimeBar(560, 220);
			createTree(760, 300);
			createMultiplePercent(400, 500);
			createTimeFactory();
		}
		
		private function createTimeFactory():void {
			var txt:BasicLabel = new BasicLabel();
			txt.y = 500;
			this.addChild(txt);
			var time:ITime=TimeFactory.getIns().createTime("111");
			if(time.time==0){//表示不需要每次都重新赋值
				time.time=10;
				time.showNum=2;
			}
			time.setBackFunction(function back(data:Object):void{txt.text=data.show;if(data.value==0){txt.text="结束"}});
			time.start();
			
			var txt2:BasicLabel = new BasicLabel();
			txt2.y = 540;
			this.addChild(txt2);
			time=TimeFactory.getIns().createTime("222",TimeFactory.COUNT_UP);
			time.time=10;//表示每次都重新赋值
			time.showNum=3;
			time.setBackFunction(function back(data:Object):void{txt2.text=data.show;if(data.value==20){TimeFactory.getIns().removeTime("222")}});
			time.start();
			time = null;
			
			var txt3:TextField = new TextField();
			txt3.y = 570;
			txt3.autoSize = "center";
			this.addChild(txt3);
			var timeText:TimeText = new TimeText("333", txt3, 15, "确定");
			timeText.setTime();
		}
		
		private function createMultiplePercent(x:int, y:int):void
		{
			var mp:MultiplePercent=new MultiplePercent;
			mp.total=15;
			mp.datas=[{name:"a",num:3,color:0XFFBBCC},{name:"b",num:3},{name:"c",num:3},{name:"d",num:3},{name:"e",num:3}];
			mp.radius=90;
			mp.move(x,y);
			this.addChild(mp);
		}
		private function createTimeBar(x:int, y:int):void
		{
			timebar = new TimeBar;
			this.addChild(timebar);
			timebar.x = x; timebar.y = y;
			var date:Date = new Date;
			timebar.number = date.getTime()+5405*1000;
		}
		private function createIntegerBar(x:int, y:int):void
		{
			var integer:IntegerBar = new IntegerBar;
			this.addChild(integer);
			integer.x = x; integer.y = y;
			integer.number = 1234567890965431987;
		}
		private function createAutoWarnBar(x:int, y:int):void
		{
			var bar:AutoWarnBar = new AutoWarnBar;
			bar.move(x,y);
			bar.label = "<font color='#ff0000'>这是个过几秒会自己关闭的</font>"
			bar.start(9);
			this.addChild(bar);
		}
		private function createSliderBar(x:int, y:int):void
		{
			var bar:SliderBar=new SliderBar;
			bar.move(x,y);
			this.addChild(bar);
			bar.value=0.5;
		}
		
		private function createTabBar(x:int, y:int):void
		{
			tabbar=new TabBar;
			this.addChild(tabbar);
			tabbar.move(x,y);
			tabbar.gad=50;
			for(var i:int=0;i<5;i++){
				var btn:BasicButton=new BasicButton;
				tabbar.addItem(btn);
				btn.label="菜单"+i;
			}
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
			numberBar.move(x, y);
			
			//自定义皮肤
			var numberBar1:NumberBar=new NumberBar;
			numberBar1.setSkin(MoonConst.NUMBER_UP_OVER,		BasicUI.getBitmapData(BasicUI.getRemoveRoundRect(18,18,MoonTheme.COLOR_RANDOM)));
			numberBar1.setSkin(MoonConst.NUMBER_UP_UP,			BasicUI.getBitmapData(BasicUI.getRemoveRoundRect(18,18,MoonTheme.COLOR_RANDOM)));
			numberBar1.setSkin(MoonConst.NUMBER_UP_DOWN,		BasicUI.getBitmapData(BasicUI.getRemoveRoundRect(18,18,MoonTheme.COLOR_RANDOM)));
			numberBar1.setSkin(MoonConst.NUMBER_DOWN_OVER,		BasicUI.getBitmapData(BasicUI.getAddRoundRect(18,18,MoonTheme.COLOR_RANDOM)));
			numberBar1.setSkin(MoonConst.NUMBER_DOWN_UP,		BasicUI.getBitmapData(BasicUI.getAddRoundRect(18,18,MoonTheme.COLOR_RANDOM)));
			numberBar1.setSkin(MoonConst.NUMBER_DOWN_DOWN,		BasicUI.getBitmapData(BasicUI.getAddRoundRect(18,18,MoonTheme.COLOR_RANDOM)));
			numberBar1.setSkin(MoonConst.NUMBER_BACKGROUND,		BasicUI.getBitmapData(BasicUI.getRoundRect(18,18,MoonTheme.COLOR_RANDOM)));
			this.addChild(numberBar1);
			numberBar1.move(x,y+50);
		}
		
		private function createListBar(x:int, y:int):void
		{
			// TODO Auto Generated method stub
			listBar = new ListBar;
			listBar.setSize(300,100)
			listBar.data = ["list1", "list2", "list3", "list4", "list5", "list6", "list7", "list8", "list9", "list10", "list11"];
			//listBar.scrollHeight = 500;
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
			scrollBar.scrollTarget = BasicUI.getRectAndX(100, 100, 0XFFFFFF);
			scrollBar.isAutoBottom = true;
			//scrollBar.offset = 120;
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
			scrollTextBar.textSeat = "right";
			scrollTextBar.isAutoBottom = true;
			scrollTextBar.x=x;
			scrollTextBar.y=y+300;
			scrollTextBar.scrollTextTarget=text;
			scrollTextBar.setSize(100,150);
			text.text="asdlfjad;lfjasdflksdjfl;kasdjflksajdfl;kasjdflkasdjfl;asdjfl;askdfjasl;dkfj;asdlfjad;lfjasdflksdjfl;kasdjflksajdfl;kasjdflkasdjfl;asdjfl;askdfjasl;dkfj;asdlfjad;lfjasdflksdjfl;kasdjflksajdfl;kasjdflkasdjfl;asdjfl;askdfjasl;dkfj;"
			this.addChild(scrollTextBar);
			text.type = TextFieldType.INPUT;
			
			//scrollBar.removeFromParent(true)
		
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
		private function createTree(x:int,y:int):void
		{
			//需要按下面格式来
			var myxml:XML = <node label="Root Node">
								<node label="Work Documents" id="1">
							   		<node label="Project.doc" id="11"/>
									<node label="Calendar.doc" id="12"/>
									<node label="Showcase.ppt" id="13"/>
							   		<node label="Statistics.xls" id="14"/>
								</node>
								<node label="Personal Docs" id="2">
									<node label="Taxes for 2006.pdf" id="21"/>
							   		<node label="Investments.xls" id="22"/>
									<node label="Schedule.doc" id="23"/>
								</node>
						  		<node label="Photos" id="3">
									<node label="Coliseum.jpg" id="31"/>
								   	<node label="Vatican.jpg" id="32"/>
								</node>
							</node>;
							
			var tree:Tree = new Tree;
			tree.treeWidth = 130;
			tree.itemRenderer = MoonTreeCellRenderer;
			tree.x = x;
			tree.y = y;
			tree.dataProvider = myxml;
			this.addChild(tree);
			
			var tree2:Tree = new Tree;
			tree2.treeWidth = 130;
			tree2.x = x+150;
			tree2.y = y;
			tree2.isCloseAll=true;//此属性是用来断定当打开一个节点时是否关闭其它节点
			tree2.dataProvider = myxml;
			this.addChild(tree2);
		}
	}
}