package org.moon
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	
	import org.moon.basic.BasicBar;
	import org.moon.utils.MoonConst;
	import org.moon.utils.NameList;
	
	/**
	 * ...2016-7-6
	 * @author vinson
	 */
	public class MultiplePercent extends BasicBar
	{
		/**默认数据,name对应名字描述,num是比例值,这此是必须写的,可选值是color这个是16进制颜色数值*/
		public var datas:Array = [ { name:"a", num:3 }, { name:"b", num:3 }, { name:"c", num:3 } ];
		/**total是总值*/
		public var total:int=9;
		public var radius:int=100;
		private var sprites:Vector.<Sprite>=new Vector.<Sprite>;
		public function MultiplePercent()
		{
			super();
		}
		/**设置皮肤 color为16进制数字*/
		override public function setSkin(type:String,color:Object,param:Object=null):void
		{
			NameList.add(MoonConst.MODEL_MULTIPLE_PERCENT,MoonConst.MULTIPLE_BODY,(new BitmapData(0,0)),color);
		}
		/**渲染,如果没给bar设置皮肤,它会使用主题皮肤*/
		override protected function render():void
		{
			var radians:Array=new Array;
			var radian:Number=0;
			for (var i:int = 0; i < datas.length; i++) {
				var data:Object = datas[i];
				var num:int=data.num;
				var sprite:Sprite = createSprite(total / num);
				if (data.hasOwnProperty("color")) {
					trace(5345345345)
					var transform:ColorTransform = new ColorTransform;
					transform.color = data.color;
					sprite.transform.colorTransform = transform;
				}
				sprite.name=data.name+":"+int(num/total*100)+"%";
				radian+=(num/total)*360;
				if(radians.length>0){
					sprite.rotation=radians[i-1];
				}
				radians.push(radian);
				sprite.addEventListener(MouseEvent.MOUSE_MOVE,onMove);
				sprite.addEventListener(MouseEvent.MOUSE_OUT,onMove);
				sprites.push(sprite);
			}
		}
		
		protected function onMove(event:MouseEvent):void
		{
			var sprite:Sprite=event.currentTarget as Sprite;
			if(event.type==MouseEvent.MOUSE_MOVE){
				TipsManager.getIns().showSimple(sprite.name,sprite);
				sprite.scaleX=sprite.scaleY=1.1;
			}else{
				sprite.scaleX=sprite.scaleY=1;
			}
		}
		private function createSprite(n:Number):Sprite
		{
			var r:int=radius;
			var sprite:Sprite=new Sprite;
			sprite.graphics.lineStyle(1);
			sprite.graphics.beginFill(NameList.param[MoonConst.MODEL_MULTIPLE_PERCENT][MoonConst.MULTIPLE_BODY])
			sprite.graphics.moveTo(0,0);
			var max:int=360;//数值越大,画的圆越圆.
			var a:Number=Math.PI/(max>>1);//旋转弧度值
			var len:int=(max/n)+1;//需要画的点数
			for(var i:int=1;i<=len;i++){
				var x:Number=Math.cos((i-1)*a)*r;
				var y:Number=Math.sin((i-1)*a)*r;
				sprite.graphics.lineTo(x,y);
			}
			sprite.graphics.lineTo(0,0);
			this.addChild(sprite);
			return sprite;
		}
		override public function dispose():void
		{
			for(var i:int=0;i<sprites.length;i++){
				var sprite:Sprite=sprites[i];
				sprite.removeEventListener(MouseEvent.MOUSE_MOVE,onMove);
				sprite.removeEventListener(MouseEvent.MOUSE_OUT,onMove);
				sprite=null;
			}
			sprites.length=0;
			sprites=null;
			super.dispose();
		}
	}
}