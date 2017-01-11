package org.moon.sun
{
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	import modules.utils.CreateComponent;
	
	import org.moon.tree.TreeCellRenderer;
	
	/**
	 * ...2015-12-17
	 * @author vinson
	 */
	public class McTreeCellRenderer extends TreeCellRenderer
	{
		public static var skinData:Dictionary=new Dictionary;
		protected var newSkin:MovieClip;
		protected var labelMc:MovieClip;
		protected var iconMc:MovieClip;
		public function McTreeCellRenderer()
		{
			super();
		}
		/**
		 *初始化UI
		 * 可以根据需要继承此类重写此方法，添加自己需要的UI组建
		 * 此方法只是进行初始化UI ，不会将UI放置到显示列表中，也不会设置位置 宽度等。
		 * 位置宽度 在drawData()中进行。如果需要自定义定位请重写drawData()方法
		 *
		 */
		override protected function initUI():void {
			this.bg = new Sprite();
			this.addChild(this.bg);
			this.mouseArea = new Sprite();
			this.icon = new Sprite();
			this.labelTextField = CreateComponent.createTextField(0,0,123,28,"center",18,0XFFFF99);
		}
		/**
		 *根据数据 构建UI
		 * 所有UI已经在initUI中初始化过
		 * 这里进行UI的位置和宽度的设置
		 * 最后添加到显示列表中
		 */
		override protected function drawData():void {
			var iconReference:Sprite = this.icon as Sprite;
			var iconGrap:Graphics = iconReference.graphics;
			if (this.hasChildNodes) {
				iconGrap.beginFill(0x000000, 1);
			} else {
				iconGrap.beginFill(0xffffff, 1);
			}
			iconGrap.drawCircle(0, 0, 3);
			iconGrap.endFill();
			
			iconReference.x = 3;
			iconReference.y = 8;
			iconReference.height = 6;
			//this.addChild(iconReference);
			
			this.labelTextField.tabEnabled = false;
			this.labelTextField.multiline = false;
			this.labelTextField.selectable = false;
			this.labelTextField.text = this.data.label;
			this.labelTextField.x = iconReference.x + 3;
			this.labelTextField.y = iconReference.y - 8;
			this.addChild(this.labelTextField);
			
			
			if (this.hasChildNodes) {
				labelTextField.text="";
				newSkin=new skinData[1] as MovieClip;
				labelMc=new skinData[3] as MovieClip;
				labelMc.x=(newSkin.width-labelMc.width)/2;
				labelMc.y=(newSkin.height-labelMc.height)/2;
				labelMc.gotoAndStop(int(this.data.id));
				this.addChild(labelMc);
			} else {
				newSkin=new skinData[2] as MovieClip;
				labelTextField.x=(newSkin.width-labelTextField.width)/2;
				labelTextField.y=(newSkin.height-labelTextField.height)/2;
			}
			newSkin.stop();
			this.addChildAt(newSkin,0);
			this.addChild(this.mouseArea);
			//设置下遮罩的高度
			this._maskHeight = Math.max(this.labelTextField.height, iconReference.height);
		}
		
		override protected function setMouseArea(_x:Number, w:Number):void {
			
		}
		
		override protected function setMouseOverBg():void {
			newSkin.gotoAndStop(2);
		}
		
		override protected function setMouseOutBg():void {
			newSkin.gotoAndStop(1);
		}
		
		override protected function setSelectedBg():void {
			newSkin.gotoAndStop(3);
		}
		public function removeIconMc():void
		{
			if(iconMc&&this.contains(iconMc)){
				this.removeChild(iconMc);
			}
		}
		public function addIconMc(mc:MovieClip,x:int=0,y:int=0):void
		{
			iconMc=mc;
			iconMc.gotoAndStop(1);
			iconMc.x=x;iconMc.y=y;
			this.addChild(iconMc);
		}
	}
}