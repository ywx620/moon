package org.moon.tree {
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 *树组件的渲染项
	 * 注意，这个类作为基类使用。可以根据自定义样式进行继承重写
	 * openIcon和closeIcon两个属性这里没有写 可以作为打开和关闭时候的图标显示 icon作为普通的图标显示
	 * 如果使用openIcon和CloseIcon的话，需要重写initUI,drawData,setOpenIcon,setCloseIcon 这几个方法，
	 * 顺序是 在initUI中进行初始化 new一下就可以
	 * 在drawData中进行具体的设置，图片位置等 最后addChild
	 * 在 setOpenIcon和setCloseIcon设置出现不出现 这两个方法会在该节点打开或者关闭的时候自动调用。只需要重写就可以了
	 * openIcon和CloseIcon的资源根据项目需要自己设置。可以使用位图或者嵌入资源等。这里不做约束。类型给出的是*类型
	 *
	 * @author yanghongbin
	 * e-mail:assinyang@163.com
	 *
	 */
	public class TreeCellRenderer extends Sprite {
		//鼠标作用的区域
		protected var mouseArea:Sprite;
		//背景
		protected var bg:Sprite;
		protected var _data:TreeCellRendererVO;
		protected var _parentNode:TreeCellRenderer;
		protected var _childNodes:Array;
		protected var _hasParentNode:Boolean;
		protected var _hasChildNodes:Boolean;
		protected var icon:*;
		protected var openIcon:*;
		protected var closeIcon:*;
		protected var labelTextField:TextField;
		protected var _level:int;
		protected var paddingX:int = 10;
		protected var childrenContainer:Sprite;
		public var nodeStatus:String = Tree.NODE_CLOSE;
		protected var _isSelected:Boolean;
		protected var _maxMaskX:Number;
		protected var _maskHeight:Number;
		protected var _maskX:Number;
		
		public function TreeCellRenderer() {
			super();
			this.buttonMode = true;
			this.initUI();
			this.initListener();
		}
		
		/**
		 *是否选中
		 * @return Boolean
		 *
		 */
		protected function get isSelected():Boolean {
			return _isSelected;
		}
		
		/**
		 *初始化UI
		 * 可以根据需要继承此类重写此方法，添加自己需要的UI组建
		 * 此方法只是进行初始化UI ，不会将UI放置到显示列表中，也不会设置位置 宽度等。
		 * 位置宽度 在drawData()中进行。如果需要自定义定位请重写drawData()方法
		 *
		 */
		protected function initUI():void {
			this.bg = new Sprite();
			this.addChild(this.bg);
			
			this.mouseArea = new Sprite();
			
			this.icon = new Sprite();
			this.labelTextField = new TextField();
		}
		
		/**
		 *这里更新
		 * @param _width
		 *
		 */
		public function updateRenderer(_maxMaskX1:Number):void {
			this._maskX = (this._level * 10) * -1;
			this._maxMaskX = _maxMaskX1;
			var mmx:Number = _maxMaskX1;
			this.setMouseArea(_maskX, mmx);
			this.setBg(_maskX, mmx);
		}
		
		protected function setBg(_x:Number, _width:Number):void {
			this.bg.graphics.clear();
			this.bg.graphics.beginFill(0x000000, 0);
			this.bg.graphics.drawRect(_x, 0, _width, _maskHeight);
			this.bg.graphics.endFill();
		}
		
		protected function setMouseArea(_x:Number, w:Number):void {
			this.mouseArea.graphics.clear();
			this.mouseArea.graphics.beginFill(0x000000, 0);
			this.mouseArea.graphics.drawRect(_x, 0, w, _maskHeight);
			this.mouseArea.graphics.endFill();
		}
		
		protected function setMouseOverBg():void {
			this.bg.graphics.clear();
			this.bg.graphics.beginFill(0x000000, .2);
			this.bg.graphics.drawRect(_maskX, 0, this._maxMaskX, _maskHeight);
			this.bg.graphics.endFill();
		}
		
		protected function setMouseOutBg():void {
			this.bg.graphics.clear();
		}
		
		protected function setSelectedBg():void {
			this.bg.graphics.clear();
			this.bg.graphics.beginFill(0x000000, .6);
			this.bg.graphics.drawRect(_maskX, 0, this._maxMaskX, _maskHeight);
			this.bg.graphics.endFill();
		}
		
		protected function initListener():void {
			this.addEventListener(TreeEvent.CLICK_NODE, otherClickNode);
			this.addEventListener(MouseEvent.CLICK, onClick);
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		protected function removeListener():void {
			this.removeEventListener(TreeEvent.CLICK_NODE, otherClickNode);
			this.removeEventListener(MouseEvent.CLICK, onClick);
			this.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		/**
		 *节点打开的ICON
		 *
		 */
		protected function setOpenIcon():void {
			//这里请在子类中重写自己设定即可
		}
		
		/**
		 *节点关闭的ICON
		 *
		 */
		protected function setCloseIcon():void {
			//这里请在子类中重写自己设定即可
		}
		
		/**
		 *点击事件
		 * @param e
		 *
		 */
		protected function onClick(e:MouseEvent):void {
			//终止事件的冒泡，因为MouseEvent事件在FP底层是默认冒泡派发的
			e.stopPropagation();
			doNode();
		}
		
		public function doNode():void{
			if(this.hasChildNodes){
				this.dispatchEvent(new TreeEvent(TreeEvent.CLOSE_ALL_TREE, this, true));
			}
			this.clickNode();
			this.dispatchEvent(new TreeEvent(TreeEvent.CLICK_NODE, this, true));
		}
		
		protected function clickNode():void {
			
			this.selected();
			
			if (!this.isOpen()) {
				this.open();
			} else {
				this.close();
			}
		}
		
		/**
		 *选中
		 *
		 */
		public function selected():void {
			this._isSelected = true;
			this.setSelectedBg();
		}
		
		/**
		 *没选中
		 *
		 */
		public function unSelected():void {
			this._isSelected = false;
			this.setMouseOutBg();
		}
		
		/**
		 *打开节点操作
		 *
		 */
		protected function open():void {
			if (this.hasChildNodes) {
				if (this.isOpen() == false) {
					this.setOpenIcon();
					this.nodeStatus = Tree.NODE_OPEN;
					this.childrenContainer.y = this.height;
					this.addChild(this.childrenContainer);
				}
			}
		}
		
		
		/**
		 *关闭节点操作
		 *
		 */
		public function close():void {
			if (this.hasChildNodes) {
				if (this.isOpen() == true) {
					this.setCloseIcon();
					this.nodeStatus = Tree.NODE_CLOSE;
					this.removeChild(this.childrenContainer);
				}
			}
		}
		
		public function isOpen():Boolean {
			if (!this._hasChildNodes) {
				return false;
			}
			
			if (this.nodeStatus == Tree.NODE_OPEN) {
				return true;
			}
			
			if (this.nodeStatus == Tree.NODE_CLOSE) {
				return false;
			}
			return false;
		}
		
		protected function otherClickNode(e:TreeEvent):void {
			this.drawLayout();
			
		}
		
		/**
		 *移入鼠标
		 * @param e
		 *
		 */
		protected function onMouseOver(e:MouseEvent):void {
			e.stopPropagation();
			
			if (!this._isSelected) {
				this.setMouseOverBg();
			}
		}
		
		/**
		 *移出鼠标
		 * @param e
		 *
		 */
		protected function onMouseOut(e:MouseEvent):void {
			e.stopPropagation();
			
			if (!this._isSelected) {
				this.setMouseOutBg();
			}
		}
		
		/**
		 *开始解析数据
		 *
		 */
		protected function resloveData():void {
			this.drawData();
		}
		
		/**
		 *根据数据 构建UI
		 * 所有UI已经在initUI中初始化过
		 * 这里进行UI的位置和宽度的设置
		 * 最后添加到显示列表中
		 */
		protected function drawData():void {
			var iconReference:Sprite = this.icon as Sprite;
			var iconGrap:Graphics = iconReference.graphics;
			
			if (this._hasChildNodes) {
				iconGrap.beginFill(0x000000, 0.8);
			} else {
				iconGrap.beginFill(0xffffff, 0.4);
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
		
		/**
		 *绘制子节点显示对象
		 * 放入容器中childrenContainer
		 * 这个容器暂时不显示
		 *
		 */
		public function drawChildrenDisplay():void {
			this.childrenContainer = new Sprite();
			
			for (var i:int = 0; i < this._childNodes.length; i++) {
				var childDis:TreeCellRenderer = this._childNodes[i];
				this.childrenContainer.addChild(childDis);
			}
			this.drawLayout();
		}
		
		/**
		 *设置位置
		 *
		 */
		protected function drawLayout():void {
			if (!this._hasChildNodes) {
				return ;
			}
			
			for (var i:int = 0; i < this._childNodes.length; i++) {
				var childDis:TreeCellRenderer = this._childNodes[i];
				
				if (i == 0) {
					childDis.y = 0;
				} else {
					childDis.y = this._childNodes[i - 1].y + this._childNodes[i - 1].height;
				}
			}
		}
		
		public function get level():int {
			return _level;
		}
		
		public function set level(value:int):void {
			_level = value;
			
			if (value != 0) {
				this.x = paddingX;
			}
		}
		
		/**
		 *是否有子节点
		 * [read-only]
		 */
		public function get hasChildNodes():Boolean {
			return _hasChildNodes;
		}
		
		/**
		 *是否有父节点
		 * [read-only]
		 */
		public function get hasParentNode():Boolean {
			return _hasParentNode;
		}
		
		/**
		 *子节点的数据 Array<TreeCellRenderer>
		 */
		public function get childNodes():Array {
			return _childNodes;
		}
		
		/**
		 * @private
		 */
		public function set childNodes(value:Array):void {
			_childNodes = value;
			this._hasChildNodes = true;
		}
		
		/**
		 *父节点的数据
		 */
		public function get parentNode():TreeCellRenderer {
			return _parentNode;
		}
		
		/**
		 * @private
		 */
		public function set parentNode(value:TreeCellRenderer):void {
			_parentNode = value;
			
			if (_parentNode != null) {
				this._hasParentNode = true;
			}
		}
		
		public function get data():TreeCellRendererVO {
			return _data;
		}
		
		public function set data(value:TreeCellRendererVO):void {
			_data = value;
			
			if (_data != null) {
				this.resloveData();
			}
		}
		public function dispose():void
		{
			removeListener();
			
		}
		
	}
}