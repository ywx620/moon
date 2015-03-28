package org.moon.basic
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.text.TextField;

	/**
	 * ...
	 * 默认参数x轴,y轴,w宽,h高,r半径,c颜色,ew圆角宽,eh圆家高
	 * @author vinson
	 */
	public class BasicUI extends BasicContent
	{
		/**得到随机色*/
		public static function get randomColor():uint{
			return Math.random()*0XFFFFFF;
		}
		/**得到矩形*/
		public static function getRect(w:Number,h:Number,c:Number=0,x:Number=0,y:Number=0):Sprite
		{
			var s:Sprite=new Sprite()
			s.graphics.beginFill(c);
			s.graphics.drawRect(x,y,w,h);
			s.graphics.endFill();
			return s;
		}
		/**得到矩形和一个X*/
		public static function getRectAndX(w:Number,h:Number,c:Number=0,x:Number=0,y:Number=0):Sprite
		{
			var s:Sprite=getRect(w,h,c,x,y)
			var l1:Sprite=new Sprite;
			l1.graphics.lineStyle(0.1);
			l1.graphics.moveTo(0,0);
			l1.graphics.lineTo(w,h);
			var l2:Sprite=new Sprite;
			l2.graphics.lineStyle(0.1);
			l2.graphics.moveTo(w,0);
			l2.graphics.lineTo(0,h);
			s.addChild(l1);
			s.addChild(l2);
			return s;
		}
		/**得到圆角矩形*/
		public static function getRoundRect(w:Number,h:Number,c:Number=0,ew:Number=5,eh:Number=5,x:Number=0,y:Number=0):Sprite
		{
			var s:Sprite=new Sprite()
			s.graphics.beginFill(c);
			s.graphics.drawRoundRect(x,y,w,h,ew,eh);
			s.graphics.endFill();
			return s;
		}
		/**得到圆形*/
		public static function getCircle(r:Number,c:Number=0,x:Number=0,y:Number=0):Sprite
		{
			var s:Sprite=new Sprite()
			s.graphics.beginFill(c);
			s.graphics.drawCircle(x,y,r);
			s.graphics.endFill();
			return s;
		}
		/**得到多边形,side边数,rotation角度*/
		public static function getPolygon(side:int=3,r:Number=10,c:uint=0,rotation:Number=0):Sprite
		{
			var s:Sprite = new Sprite;
			s.rotation=rotation;
			s.graphics.beginFill(c);
			for (var i:int =0; i <=side; i++) {
				var lineX:Number =  Math.cos((i * (360 / side) * Math.PI / 180)) * r;
				var lineY:Number =  Math.sin((i * (360 / side) * Math.PI / 180)) * r;
				if (i == 0) s.graphics.moveTo(lineX,lineY);
				else		s.graphics.lineTo(lineX, lineY);
				
			}
			s.graphics.endFill();
			return s;
		}
		/**得到圆角矩形与三角形合体rc是正方形颜色,pc是三角形颜色*/
		public static function getArrowRoundRect(w:Number,h:Number,rc:uint,pc:uint=0,rotation:Number=0):Sprite
		{
			var s:Sprite = new Sprite;
			s.addChild(getRoundRect(w,h,rc));
			var p:Sprite=getPolygon(3,w/3,pc,30+rotation);
			p.x=s.width>>1;p.y=s.height>>1;
			s.addChild(p);
			return s;
		}
		/**得到滚动条的bar*/
		public static function getScrollLineBar(w:Number,h:Number,c:uint):Sprite
		{
			var s:Sprite = new Sprite;
			var _h:Number=h/3;
			for(var i:int=0;i<3;i++){
				var r:Sprite=getRect(w,1,c,0,i*_h);
				s.addChild(r);
			}
			return s;
		}
		/**得到圆角矩形-加*/
		public static function getAddRoundRect(w:Number,h:Number,c:uint):Sprite
		{
			var s:Sprite = new Sprite;
			s.addChild(getRoundRect(w,h,c));
			var r1:Sprite=getRect(w/2,2,0,w/4,h/2-1);
			var r2:Sprite=getRect(2,h/2,0,w/2-1,h/4);
			s.addChild(r1);
			s.addChild(r2);
			return s;
		}
		/**得到圆角矩形-减*/
		public static function getRemoveRoundRect(w:Number,h:Number,c:uint):Sprite
		{
			var s:Sprite = new Sprite;
			s.addChild(getRoundRect(w,h,c));
			var r:Sprite=getRect(w/2,2,0,w/4,h/2-1);
			s.addChild(r);
			return s;
		}
		/**得到带文字的圆角方形*/
		public static function getRoundRectText(w:Number,h:Number,c:uint,str:String="click"):Sprite
		{
			var s:Sprite = new Sprite;
			s.addChild(getRoundRect(w,h,c));
			var text:TextField=new TextField;
			text.autoSize="center";
			text.text=str;
			text.x=(s.width-text.width)>>1;
			text.y=(s.height-text.height)>>1;
			s.addChild(text);
			return s;
		}
		/**得到矩形-复选框 bc背景颜色，gc钩的颜色,type为0是没有钩为1是有钩*/
		public static function getCheckBoxRect(bc:uint=0XFFFFFF,gc:uint=0,type:int=0):Sprite
		{
			var s:Sprite = new Sprite;
			s.addChild(getRect(20,20,bc));
			if(type==1){
				var r:Sprite=new Sprite;
				r.graphics.beginFill(gc);
				r.graphics.moveTo(0,10);
				r.graphics.lineTo(10,18);r.graphics.lineTo(22,4);r.graphics.lineTo(18,0);r.graphics.lineTo(10,9);
				r.graphics.lineTo(6,4);r.graphics.lineTo(0,10);
				s.addChild(r);
			}
			return s;
		}
		/**得到矩形-单选框 bc背景颜色，gc钩的颜色,type为0是没有圆为1是有圆*/
		public static function getRadioCircle(bc:uint=0XFFFFFF,gc:uint=0,type:int=0):Sprite
		{
			var s:Sprite = new Sprite;
			s.addChild(getCircle(9,bc,9,9));
			if(type==1){
				var r:Sprite=getCircle(5,gc,9,9)
				s.addChild(r);
			}
			return s;
		}
		/**得到数字的sprite*/
		public static function getNumber(num:int = 8, bc:uint = 0):Sprite
		{
			var nums:Array=new Array([1,1,1,1,0,1,1],[1,0,0,1,0,0,0],[0,1,1,1,1,0,1],[0,1,1,0,1,1,1],[1,0,1,1,1,0,0],[1,1,0,0,1,1,1],[1,1,0,1,1,1,1],[0,1,1,0,0,1,0],[1,1,1,1,1,1,1],[1,1,1,0,1,1,1]);
			var sprites:Array = new Array;
			var s:Sprite = new Sprite;
			s.graphics.beginFill(0, 0);
			s.graphics.drawRect(0, 0, 18, 33);//目的是为了让每个数字大小都一样
			for (var i:int = 0; i < 7; i++ ) {
				var n:Sprite = getRect(12, 12, bc);
				if (i == 0) {
					n.width = 3;n.x = -3;
				}else if (i == 1) {
					n.height = 3;n.y = -3;
				}else if (i == 2) {
					n.width = 3;n.x = 12;
				}else if (i == 3) {
					n.width = 3; n.x = -3; n.y = 12+3;
				}else if (i == 4) {
					n.height = 3;n.y = 12;
				}else if (i == 5) {
					n.width = 3;n.x = 12;n.y=12+3
				}else if (i == 6) {
					n.height = 3;n.y = 24+3;
				}
				n.x += 3;				
				n.y += 3;				
				sprites.push(n);
			}
			var ns:Array = nums[num];
			for (i = 0; i < ns.length; i++ ) {
				if (ns[i] == 1) {
					n = sprites[i];
					s.addChild(n);
				}
			}
			return s;
		}
		/**得到冒号*/
		public static function getColon(c:uint):Sprite
		{
			var s:Sprite = new Sprite;
			s.addChild(getRect(3, 3, c, 0, 0));
			s.addChild(getRect(3, 3, c, 0, 10));
			return s;
		}
		/**得到BitmapData*/
		public static function getBitmapData(s:Sprite):BitmapData
		{
			var bitmapData:BitmapData=new BitmapData(s.width,s.height,true,0X00000000);
			bitmapData.draw(s);
			return bitmapData;
		}
	}
}