package org.moon.tree 
{
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	import org.moon.basic.BasicButton;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import org.moon.MoonTheme;
	import org.moon.tree.TreeCellRenderer;
	import org.moon.utils.MoonConst;
	/**
	 * ...
	 * @author vinson
	 */
	public class MoonTreeCellRenderer extends TreeCellRenderer 
	{
		public function MoonTreeCellRenderer()
		{
			super();
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
			this.addChild(iconReference);
			
			this.labelTextField.tabEnabled = false;
			this.labelTextField.multiline = false;
			this.labelTextField.selectable = false;
			this.labelTextField.autoSize = TextFieldAutoSize.LEFT;
			var textFormat:TextFormat = new TextFormat();
			textFormat.color = 0x000000;
			this.labelTextField.defaultTextFormat = textFormat;
			this.labelTextField.text = this.data.label;
			this.labelTextField.x = iconReference.x + 3;
			this.labelTextField.y = iconReference.y - 8;
			this.addChild(this.labelTextField);
			
			
			this.addChild(this.mouseArea);
			//设置下遮罩的高度
			this._maskHeight = Math.max(this.labelTextField.height, iconReference.height);
		}
		
		override protected function setBg(_x:Number, _width:Number):void {
			this.bg.graphics.clear();
			this.bg.graphics.beginFill(MoonTheme.COLOR_BUTTON_DOWN, 0.1);
			this.bg.graphics.drawRect(_x, 0, _width, _maskHeight);
			this.bg.graphics.endFill();
		}
		
		override protected function setMouseArea(_x:Number, w:Number):void {
			this.mouseArea.graphics.clear();
			this.mouseArea.graphics.beginFill(MoonTheme.COLOR_BUTTON_DOWN, 0);
			this.mouseArea.graphics.drawRect(_x, 0, w, _maskHeight);
			this.mouseArea.graphics.endFill();
		}
		
		override protected function setMouseOutBg():void {
			this.bg.graphics.clear();
			if (this.hasChildNodes) {
				this.bg.graphics.beginFill(MoonTheme.COLOR_BUTTON_DOWN, 0.1);
				this.bg.graphics.drawRect(_maskX, 0, this._maxMaskX, _maskHeight);
				this.bg.graphics.endFill();
			}
		}
		
		override protected function setMouseOverBg():void {
			this.bg.graphics.clear();
			this.bg.graphics.beginFill(MoonTheme.COLOR_BUTTON_OVER, .2);
			this.bg.graphics.drawRect(_maskX, 0, this._maxMaskX, _maskHeight);
			this.bg.graphics.endFill();
		}
		
		override protected function setSelectedBg():void {
			this.bg.graphics.clear();
			this.bg.graphics.beginFill(MoonTheme.COLOR_BUTTON_DOWN, .6);
			this.bg.graphics.drawRect(_maskX, 0, this._maxMaskX, _maskHeight);
			this.bg.graphics.endFill();
		}
	}
}