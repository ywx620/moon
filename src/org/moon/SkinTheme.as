package org.moon
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import org.moon.basic.BasicUI;
	import org.moon.utils.MoonConst;
	import org.moon.utils.NameList;

	/**
	 * ...使用外部资源的皮肤主题
	 * @author vinson
	 */
	public class SkinTheme
	{
		/**得到位图的数据*/
		public function getBitmapData(bitmap:Bitmap):BitmapData
		{
			return bitmap.bitmapData;
		}
		/**设置按钮*/
		public function setButton(over:Bitmap,up:Bitmap,down:Bitmap):void
		{
			//button 按钮
			NameList.add(MoonConst.MODEL_BUTTON,MoonConst.BUTTON_OVER,	getBitmapData(over));
			NameList.add(MoonConst.MODEL_BUTTON,MoonConst.BUTTON_UP,	getBitmapData(up));
			NameList.add(MoonConst.MODEL_BUTTON,MoonConst.BUTTON_DOWN,	getBitmapData(down));
		}
		/**设置滚动条*/
		public function setScroll(up_over:Bitmap,up_up:Bitmap,up_down:Bitmap,body_over:Bitmap,body_up:Bitmap,body_down:Bitmap,bar_over:Bitmap,bar_up:Bitmap,bar_down:Bitmap,down_over:Bitmap,down_up:Bitmap,down_down:Bitmap):void
		{
			//scroll 滚动条
			NameList.add(MoonConst.MODEL_SCROLL,MoonConst.SCROLL_UP_OVER,	getBitmapData(up_over));
			NameList.add(MoonConst.MODEL_SCROLL,MoonConst.SCROLL_UP_UP,		getBitmapData(up_up));
			NameList.add(MoonConst.MODEL_SCROLL,MoonConst.SCROLL_UP_DOWN,	getBitmapData(up_down));
			NameList.add(MoonConst.MODEL_SCROLL,MoonConst.SCROLL_BODY_OVER,	getBitmapData(body_over));
			NameList.add(MoonConst.MODEL_SCROLL,MoonConst.SCROLL_BODY_UP,	getBitmapData(body_up));
			NameList.add(MoonConst.MODEL_SCROLL,MoonConst.SCROLL_BODY_DOWN,	getBitmapData(body_down));
			NameList.add(MoonConst.MODEL_SCROLL,MoonConst.SCROLL_BAR_OVER,	getBitmapData(bar_over));
			NameList.add(MoonConst.MODEL_SCROLL,MoonConst.SCROLL_BAR_UP,	getBitmapData(bar_up));
			NameList.add(MoonConst.MODEL_SCROLL,MoonConst.SCROLL_BAR_DOWN,	getBitmapData(bar_down));
			NameList.add(MoonConst.MODEL_SCROLL,MoonConst.SCROLL_DOWN_OVER,	getBitmapData(down_over));
			NameList.add(MoonConst.MODEL_SCROLL,MoonConst.SCROLL_DOWN_UP,	getBitmapData(down_up));
			NameList.add(MoonConst.MODEL_SCROLL,MoonConst.SCROLL_DOWN_DOWN,	getBitmapData(down_down));
		}
		/**设置单选框*/
		public function setRadio(up:Bitmap,over:Bitmap,select:Bitmap):void
		{
			//radio 单选框
			NameList.add(MoonConst.MODEL_RADIO,MoonConst.RADIO_DEFAULT,	getBitmapData(up));
			NameList.add(MoonConst.MODEL_RADIO,MoonConst.RADIO_OVER,	getBitmapData(over));
			NameList.add(MoonConst.MODEL_RADIO,MoonConst.RADIO_SELECT,	getBitmapData(select));
		}
		/**设置提示框背景*/
		public function setTips(background:Bitmap):void
		{
			//tips 提示
			NameList.add(MoonConst.MODEL_TIPS,MoonConst.TIPS_BACKGROUND, getBitmapData(background));
		}
		/**设置进度条*/
		public function setProgress(bar:Bitmap,background:Bitmap):void
		{
			//progress 进度条
			NameList.add(MoonConst.MODEL_PROGRESS,MoonConst.PROGRESS_BAR,		 getBitmapData(bar));
			NameList.add(MoonConst.MODEL_PROGRESS,MoonConst.PROGRESS_BACKGROUND, getBitmapData(background));
		}
		/**设置复选框*/
		public function setCheckBox(up_0:Bitmap,over_0:Bitmap,select_0:Bitmap,up_1:Bitmap,over_1:Bitmap,select_1:Bitmap):void
		{
			//checkbox 复选框
			NameList.add(MoonConst.MODEL_CHECKBOX,MoonConst.CHECKBOX_DEFAULT_0,	getBitmapData(up_0));
			NameList.add(MoonConst.MODEL_CHECKBOX,MoonConst.CHECKBOX_OVER_0,	getBitmapData(over_0));
			NameList.add(MoonConst.MODEL_CHECKBOX, MoonConst.CHECKBOX_SELECT_0,	getBitmapData(select_0));
			NameList.add(MoonConst.MODEL_CHECKBOX,MoonConst.CHECKBOX_DEFAULT_1,	getBitmapData(up_1));
			NameList.add(MoonConst.MODEL_CHECKBOX,MoonConst.CHECKBOX_OVER_1,	getBitmapData(over_1));
			NameList.add(MoonConst.MODEL_CHECKBOX,MoonConst.CHECKBOX_SELECT_1,	getBitmapData(select_1));
		}
		/**设置滑块条*/
		public function setSlider(bar_up:Bitmap,bar_over:Bitmap,bar_down:Bitmap,progress:Bitmap,background:Bitmap):void
		{
			//slider 滑块条
			NameList.add(MoonConst.MODEL_SLIDER,MoonConst.SLIDER_BAR_UP,		getBitmapData(bar_up));
			NameList.add(MoonConst.MODEL_SLIDER,MoonConst.SLIDER_BAR_OVER,		getBitmapData(bar_over));
			NameList.add(MoonConst.MODEL_SLIDER,MoonConst.SLIDER_BAR_DOWN,		getBitmapData(bar_down));
			NameList.add(MoonConst.MODEL_SLIDER,MoonConst.SLIDER_PROGRESS,		getBitmapData(progress));
			NameList.add(MoonConst.MODEL_SLIDER,MoonConst.SLIDER_BACKGROUND,	getBitmapData(background));
		}
		/**设置自动关闭的提醒框*/
		public function setAutoWarn(background:Bitmap):void
		{
			//warn 提醒框自动关闭
			NameList.add(MoonConst.MODEL_AUTOWARN, MoonConst.AUTOWARN_BACKGROUND, getBitmapData(background));
		}
		public function setList(over:Bitmap,up:Bitmap,down:Bitmap,background:Bitmap):void
		{
			//list 列表
			NameList.add(MoonConst.MODEL_LIST,MoonConst.LIST_OPEN_UP,		getBitmapData(over));
			NameList.add(MoonConst.MODEL_LIST,MoonConst.LIST_OPEN_OVER,		getBitmapData(up));
			NameList.add(MoonConst.MODEL_LIST,MoonConst.LIST_OPEN_DOWN,		getBitmapData(down));
			NameList.add(MoonConst.MODEL_LIST,MoonConst.LIST_BACKGROUND,	getBitmapData(background));
			
		}
	}
}