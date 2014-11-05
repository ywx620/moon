package org.moon
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;	
	import org.moon.utils.Scale9Image;
	
	public class TipsManager
	{
		private static var instance:TipsManager;
		public static const FOLLOW:String="follow";
		public static const UP:String="up";
		public static const DOWN:String="donw";
		public static const LEFT:String="left";
		public static const RIGHT:String="right";
		private var host:DisplayObject;
		private var basicTips:BasicTips;
		private var str:String;
		private var type:String;
		public function TipsManager()
		{
		}
		public static function getIns():TipsManager
		{
			if(instance==null) instance=new TipsManager;
			return instance;
		}
		public function removeTips():void
		{
			if(host) host.stage.removeEventListener(MouseEvent.MOUSE_MOVE,onFollowMouse);
			if(basicTips) basicTips.removeFromParent(true);
			basicTips=null;
		}
		private function addStageAndAddEvent():void
		{
			host.stage.addChild(basicTips);
			setTipsSeat();
			host.stage.addEventListener(MouseEvent.MOUSE_MOVE,onFollowMouse);
		}
		/**支持html的简单tips显示，str是tips容，host是tips主体tips用来描述host,type类型，跟随鼠标否不跟随鼠标*/
		public function showSimple(str:String,host:DisplayObject,type:String="right"):void
		{
			this.host=host;
			this.type=type;
			removeTips();
			basicTips=new SimpleTips(str);
			addStageAndAddEvent();
		}
		protected function setTipsSeat():void
		{
			var offset:int=5;
			var p:Point=host.parent.localToGlobal(new Point(host.x,host.y));
			switch(type){
				case FOLLOW:
					basicTips.x=host.stage.mouseX+offset*3;
					basicTips.y=host.stage.mouseY+offset*3;
					if((host.stage.mouseX+basicTips.width)>host.stage.stageWidth){
						basicTips.x=host.stage.mouseX-basicTips.width-offset;
					}
					if((host.stage.mouseY+basicTips.height)>host.stage.stageHeight){
						basicTips.y=host.stage.stageHeight-basicTips.height;
					}
					break;
				case UP:
					basicTips.x=p.x+((host.width-basicTips.width)>>1);
					basicTips.y=p.y-basicTips.height-offset;
					break;
				case DOWN:
					basicTips.x=p.x+((host.width-basicTips.width)>>1);
					basicTips.y=p.y+host.height+offset;
					break;
				case LEFT:
					basicTips.x=p.x-basicTips.width;
					basicTips.y=p.y
					break;
				case RIGHT:
					basicTips.x=p.x+host.width;
					basicTips.y=p.y
					break;
			}
		}
		protected function onFollowMouse(event:MouseEvent):void
		{
			if(checkIsOutSide(host)){
				setTipsSeat();
			}else{
				host.stage.removeEventListener(MouseEvent.MOUSE_MOVE,onFollowMouse);
				basicTips.removeFromParent(true);
				basicTips=null;
			}
		}
		
		private function checkIsOutSide(host:DisplayObject):Boolean
		{
			if(host.mouseX>0&&host.mouseX<host.width){
				if(host.mouseY>0&&host.mouseY<host.height){
					return true;
				}
			}
			return false;
		}
		
	}
}
import flash.display.BitmapData;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import org.moon.basic.BasicContent;
import org.moon.utils.MoonConst;
import org.moon.utils.NameList;
import org.moon.utils.Scale9Image;

/**基础的tips类*/
class BasicTips extends BasicContent
{
	protected var background:Scale9Image;
	public function BasicTips()
	{
		
	}
	/**渲染,如果没给bar设置皮肤,它会使用主题皮肤*/
	override protected function render():void
	{
		for(var model:String in NameList.list){
			if(model==MoonConst.MODEL_TIPS){
				for(var type:String in NameList.list[model]){
					if(type.split("-")[1]=="background"){
						var image:BitmapData=NameList.list[model][type];
						background=new Scale9Image(image.clone());
					}
				}
			}
		}
		background.scale9Grid=new Rectangle(10,10,5,5);
	}
	protected function setTextField(str:String,x:Number=0,y:Number=0,c:String="#FFFFFF"):void
	{
		var text:TextField=new TextField;
		//text.autoSize="left";
		text.width=background.width-20;
		text.multiline=true;
		text.wordWrap=true;
		text.htmlText="<font color='"+c+"'>"+str+"</font>";
		text.x=x;text.y=y;
		this.addChild(text);
	}
}
/**简单的tips类*/
class SimpleTips extends BasicTips
{
	private var simpleText:TextField;
	private var str:String;
	public function SimpleTips(str:String)
	{
		super();
		this.str=str;
	}
	/**渲染*/
	override protected function render():void
	{
		super.render();
		simpleText=new TextField();
		this.addChild(background);
		this.addChild(simpleText);
		simpleText.autoSize=TextFieldAutoSize.CENTER;
		simpleText.multiline=true;
		simpleText.htmlText=this.str;
		background.width=simpleText.width+20;
		background.height=simpleText.height+20;
		simpleText.x=(background.width-simpleText.width)>>1;
		simpleText.y=(background.height-simpleText.height)>>1;
	}
	override public function dispose():void
	{
		this.removeChildAll(0,-1,true);
		background=null;
		simpleText=null;
		super.dispose();
	}
}