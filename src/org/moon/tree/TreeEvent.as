package org.moon.tree {
	import flash.events.Event;
	
	/**
	 * Tree的事件类
	 * 目前只有一个事件，就是点击某一个分支所派发的CLICK_NODE事件
	 *
	 * @author yanghongbin
	 * e-mail:assinyang@163.com
	 */
	public class TreeEvent extends Event {
		/**
		 * 点击某一个节点的事件名
		 */
		public static const CLICK_NODE:String = "clickNode";
		/**关闭所有节点*/
		public static const CLOSE_ALL_TREE:String = "CLOSE_ALL_TREE";
		//事件源
		public var item:TreeCellRenderer;
		
		public function TreeEvent(type:String, _item:TreeCellRenderer, bubbles:Boolean = false,
								  cancelable:Boolean = false) {
			this.item = _item;
			super(type, bubbles, cancelable);
			
		}
	}
}