package org.moon
{
	import org.moon.basic.BasicUI;
	import org.moon.utils.MoonConst;
	import org.moon.utils.NameList;

	/**
	 * ...皮肤主题
	 * @author vinson
	 */
	public class MoonTheme
	{
		public static const COLOR_BUTTON_OVER:uint=0XEA7500;
		public static const COLOR_BUTTON_DOWN:uint=0XFF8000;
		public static const COLOR_BUTTON_UP:uint=0XFF9224;
		public static const COLOR_SCROLL_UP_OVER:uint=0XEA7500;
		public static const COLOR_SCROLL_UP_DOWN:uint=0XFF9224;
		public static const COLOR_SCROLL_UP_UP:uint=0XFF8000;
		public static const COLOR_SCROLL_BODY:uint=0XFFEEDD;
		public static const COLOR_SCROLL_BAR_OVER:uint=0X9F5000;
		public static const COLOR_SCROLL_BAR_DOWN:uint=0X844200;
		public static const COLOR_SCROLL_BAR_UP:uint=0XBB5E00;
		public static const COLOR_TIPS_BG:uint=0XCCCCCC;
		public static const COLOR_NUMBER:uint = 0X0000E3;
		public static function get COLOR_RANDOM():uint{return Math.random()*0XFFFFFF}
		public function MoonTheme()
		{
			//button 按钮
			NameList.add(MoonConst.MODEL_BUTTON,MoonConst.BUTTON_OVER,	BasicUI.getBitmapData(BasicUI.getRoundRect(80,30,COLOR_BUTTON_OVER)));
			NameList.add(MoonConst.MODEL_BUTTON,MoonConst.BUTTON_UP,	BasicUI.getBitmapData(BasicUI.getRoundRect(80,30,COLOR_BUTTON_UP)));
			NameList.add(MoonConst.MODEL_BUTTON,MoonConst.BUTTON_DOWN,	BasicUI.getBitmapData(BasicUI.getRoundRect(80,30,COLOR_BUTTON_DOWN)));

			//scroll 滚动条
			NameList.add(MoonConst.MODEL_SCROLL,MoonConst.SCROLL_UP_OVER,	BasicUI.getBitmapData(BasicUI.getArrowRoundRect(18,18,COLOR_SCROLL_UP_OVER)));
			NameList.add(MoonConst.MODEL_SCROLL,MoonConst.SCROLL_UP_DOWN,	BasicUI.getBitmapData(BasicUI.getArrowRoundRect(18,18,COLOR_SCROLL_UP_DOWN)));
			NameList.add(MoonConst.MODEL_SCROLL,MoonConst.SCROLL_UP_UP,		BasicUI.getBitmapData(BasicUI.getArrowRoundRect(18,18,COLOR_SCROLL_UP_UP)));
			NameList.add(MoonConst.MODEL_SCROLL,MoonConst.SCROLL_BODY_OVER,	BasicUI.getBitmapData(BasicUI.getRoundRect(18,50,COLOR_SCROLL_BODY)));
			NameList.add(MoonConst.MODEL_SCROLL,MoonConst.SCROLL_BODY_DOWN,	BasicUI.getBitmapData(BasicUI.getRoundRect(18,50,COLOR_SCROLL_BODY)));
			NameList.add(MoonConst.MODEL_SCROLL,MoonConst.SCROLL_BODY_UP,	BasicUI.getBitmapData(BasicUI.getRoundRect(18,50,COLOR_SCROLL_BODY)));
			NameList.add(MoonConst.MODEL_SCROLL,MoonConst.SCROLL_BAR_OVER,	BasicUI.getBitmapData(BasicUI.getRoundRect(18,20,COLOR_SCROLL_BAR_OVER)));
			NameList.add(MoonConst.MODEL_SCROLL,MoonConst.SCROLL_BAR_DOWN,	BasicUI.getBitmapData(BasicUI.getRoundRect(18,20,COLOR_SCROLL_BAR_DOWN)));
			NameList.add(MoonConst.MODEL_SCROLL,MoonConst.SCROLL_BAR_UP,	BasicUI.getBitmapData(BasicUI.getRoundRect(18,20,COLOR_SCROLL_BAR_UP)));
			NameList.add(MoonConst.MODEL_SCROLL,MoonConst.SCROLL_BAR_LINE,	BasicUI.getBitmapData(BasicUI.getScrollLineBar(9,9,0)));
			NameList.add(MoonConst.MODEL_SCROLL,MoonConst.SCROLL_DOWN_OVER,	BasicUI.getBitmapData(BasicUI.getArrowRoundRect(18,18,COLOR_SCROLL_UP_OVER,0,180)));
			NameList.add(MoonConst.MODEL_SCROLL,MoonConst.SCROLL_DOWN_DOWN,	BasicUI.getBitmapData(BasicUI.getArrowRoundRect(18,18,COLOR_SCROLL_UP_DOWN,0,180)));
			NameList.add(MoonConst.MODEL_SCROLL,MoonConst.SCROLL_DOWN_UP,	BasicUI.getBitmapData(BasicUI.getArrowRoundRect(18,18,COLOR_SCROLL_UP_UP,0,180)));
			
			//page 页码
			NameList.add(MoonConst.MODEL_PAGE,MoonConst.PAGE_UP_OVER,		BasicUI.getBitmapData(BasicUI.getArrowRoundRect(18,18,COLOR_BUTTON_OVER,0,-90)));
			NameList.add(MoonConst.MODEL_PAGE,MoonConst.PAGE_UP_UP,			BasicUI.getBitmapData(BasicUI.getArrowRoundRect(18,18,COLOR_BUTTON_UP,0,-90)));
			NameList.add(MoonConst.MODEL_PAGE,MoonConst.PAGE_UP_DOWN,		BasicUI.getBitmapData(BasicUI.getArrowRoundRect(18,18,COLOR_BUTTON_DOWN,0,-90)));
			NameList.add(MoonConst.MODEL_PAGE,MoonConst.PAGE_DOWN_OVER,		BasicUI.getBitmapData(BasicUI.getArrowRoundRect(18,18,COLOR_BUTTON_OVER,0,90)));
			NameList.add(MoonConst.MODEL_PAGE,MoonConst.PAGE_DOWN_UP,		BasicUI.getBitmapData(BasicUI.getArrowRoundRect(18,18,COLOR_BUTTON_UP,0,90)));
			NameList.add(MoonConst.MODEL_PAGE,MoonConst.PAGE_DOWN_DOWN,		BasicUI.getBitmapData(BasicUI.getArrowRoundRect(18,18,COLOR_BUTTON_DOWN,0,90)));
			NameList.add(MoonConst.MODEL_PAGE,MoonConst.PAGE_BACKGROUND,	BasicUI.getBitmapData(BasicUI.getRoundRect(50,18,COLOR_BUTTON_DOWN)));
			
			//tips 提示
			NameList.add(MoonConst.MODEL_TIPS,MoonConst.TIPS_BACKGROUND,	BasicUI.getBitmapData(BasicUI.getRoundRect(20,20,COLOR_TIPS_BG)));
			
			//warn 提醒框
			NameList.add(MoonConst.MODEL_WARN,MoonConst.WARN_CANCEL_OVER,		BasicUI.getBitmapData(BasicUI.getRoundRectText(80,30,COLOR_BUTTON_OVER,"取消")));
			NameList.add(MoonConst.MODEL_WARN,MoonConst.WARN_CANCEL_UP,			BasicUI.getBitmapData(BasicUI.getRoundRectText(80,30,COLOR_BUTTON_UP,"取消")));
			NameList.add(MoonConst.MODEL_WARN,MoonConst.WARN_CANCEL_DOWN,		BasicUI.getBitmapData(BasicUI.getRoundRectText(80,30,COLOR_BUTTON_DOWN,"取消")));
			NameList.add(MoonConst.MODEL_WARN,MoonConst.WARN_SURE_OVER,			BasicUI.getBitmapData(BasicUI.getRoundRectText(80,30,COLOR_BUTTON_OVER,"确定")));
			NameList.add(MoonConst.MODEL_WARN,MoonConst.WARN_SURE_UP,			BasicUI.getBitmapData(BasicUI.getRoundRectText(80,30,COLOR_BUTTON_UP,"确定")));
			NameList.add(MoonConst.MODEL_WARN,MoonConst.WARN_SURE_DOWN,			BasicUI.getBitmapData(BasicUI.getRoundRectText(80,30,COLOR_BUTTON_DOWN,"确定")));
			NameList.add(MoonConst.MODEL_WARN,MoonConst.WARN_BACKGROUND,		BasicUI.getBitmapData(BasicUI.getRoundRect(20,20,COLOR_TIPS_BG)));
			
			//list 列表
			NameList.add(MoonConst.MODEL_LIST,MoonConst.LIST_OPEN_OVER,		BasicUI.getBitmapData(BasicUI.getArrowRoundRect(20,20,COLOR_SCROLL_UP_OVER,0,-90)));
			NameList.add(MoonConst.MODEL_LIST,MoonConst.LIST_OPEN_DOWN,		BasicUI.getBitmapData(BasicUI.getArrowRoundRect(20,20,COLOR_SCROLL_UP_DOWN,0,-90)));
			NameList.add(MoonConst.MODEL_LIST,MoonConst.LIST_OPEN_UP,		BasicUI.getBitmapData(BasicUI.getArrowRoundRect(20,20,COLOR_SCROLL_UP_UP,0,-90)));
			NameList.add(MoonConst.MODEL_LIST,MoonConst.LIST_BACKGROUND,	BasicUI.getBitmapData(BasicUI.getRoundRect(120,20,COLOR_TIPS_BG)));
			
			//number 数字
			NameList.add(MoonConst.MODEL_NUMBER,MoonConst.NUMBER_UP_OVER,		BasicUI.getBitmapData(BasicUI.getRemoveRoundRect(18,18,COLOR_BUTTON_OVER)));
			NameList.add(MoonConst.MODEL_NUMBER,MoonConst.NUMBER_UP_UP,			BasicUI.getBitmapData(BasicUI.getRemoveRoundRect(18,18,COLOR_BUTTON_UP)));
			NameList.add(MoonConst.MODEL_NUMBER,MoonConst.NUMBER_UP_DOWN,		BasicUI.getBitmapData(BasicUI.getRemoveRoundRect(18,18,COLOR_BUTTON_DOWN)));
			NameList.add(MoonConst.MODEL_NUMBER,MoonConst.NUMBER_DOWN_OVER,		BasicUI.getBitmapData(BasicUI.getAddRoundRect(18,18,COLOR_BUTTON_OVER)));
			NameList.add(MoonConst.MODEL_NUMBER,MoonConst.NUMBER_DOWN_UP,		BasicUI.getBitmapData(BasicUI.getAddRoundRect(18,18,COLOR_BUTTON_UP)));
			NameList.add(MoonConst.MODEL_NUMBER,MoonConst.NUMBER_DOWN_DOWN,		BasicUI.getBitmapData(BasicUI.getAddRoundRect(18,18,COLOR_BUTTON_DOWN)));
			NameList.add(MoonConst.MODEL_NUMBER,MoonConst.NUMBER_BACKGROUND,	BasicUI.getBitmapData(BasicUI.getRoundRect(50,18,COLOR_BUTTON_DOWN)));
			
			//progress 进度条
			NameList.add(MoonConst.MODEL_PROGRESS,MoonConst.PROGRESS_BAR,			BasicUI.getBitmapData(BasicUI.getRoundRect(100,18,COLOR_BUTTON_UP)));
			NameList.add(MoonConst.MODEL_PROGRESS,MoonConst.PROGRESS_BACKGROUND,	BasicUI.getBitmapData(BasicUI.getRoundRect(100,18,COLOR_TIPS_BG)));
			
			//checkbox 复选框
			NameList.add(MoonConst.MODEL_CHECKBOX,MoonConst.CHECKBOX_DEFAULT,	BasicUI.getBitmapData(BasicUI.getCheckBoxRect(COLOR_BUTTON_OVER,0,0)));
			NameList.add(MoonConst.MODEL_CHECKBOX,MoonConst.CHECKBOX_SELECT,	BasicUI.getBitmapData(BasicUI.getCheckBoxRect(COLOR_BUTTON_OVER,0,1)));
			
			//radio 单选框
			NameList.add(MoonConst.MODEL_RADIO,MoonConst.RADIO_DEFAULT,	BasicUI.getBitmapData(BasicUI.getRadioCircle(COLOR_BUTTON_OVER,0,0)));
			NameList.add(MoonConst.MODEL_RADIO,MoonConst.RADIO_SELECT,	BasicUI.getBitmapData(BasicUI.getRadioCircle(COLOR_BUTTON_OVER,0,1)));
			
			//slider 滑块条
			NameList.add(MoonConst.MODEL_SLIDER,MoonConst.SLIDER_BAR_UP,		BasicUI.getBitmapData(BasicUI.getRoundRect(8,14,COLOR_SCROLL_BAR_UP)));
			NameList.add(MoonConst.MODEL_SLIDER,MoonConst.SLIDER_BAR_DOWN,		BasicUI.getBitmapData(BasicUI.getRoundRect(8,14,COLOR_SCROLL_BAR_OVER)));
			NameList.add(MoonConst.MODEL_SLIDER,MoonConst.SLIDER_BAR_OVER,		BasicUI.getBitmapData(BasicUI.getRoundRect(8,14,COLOR_SCROLL_BAR_DOWN)));
			NameList.add(MoonConst.MODEL_SLIDER,MoonConst.SLIDER_PROGRESS,		BasicUI.getBitmapData(BasicUI.getRoundRect(100,5,COLOR_BUTTON_UP)));
			NameList.add(MoonConst.MODEL_SLIDER,MoonConst.SLIDER_BACKGROUND,	BasicUI.getBitmapData(BasicUI.getRoundRect(100,5,COLOR_TIPS_BG)));
			
			//warn 提醒框自动关闭
			NameList.add(MoonConst.MODEL_AUTOWARN, MoonConst.AUTOWARN_BACKGROUND, BasicUI.getBitmapData(BasicUI.getRoundRect(20, 20, COLOR_TIPS_BG)));
			
			//integer 整数字
			NameList.add(MoonConst.MODEL_INTEGER,MoonConst.INTEGER_0,BasicUI.getBitmapData(BasicUI.getNumber(0,COLOR_NUMBER)));
			NameList.add(MoonConst.MODEL_INTEGER,MoonConst.INTEGER_1,BasicUI.getBitmapData(BasicUI.getNumber(1,COLOR_NUMBER)));
			NameList.add(MoonConst.MODEL_INTEGER,MoonConst.INTEGER_2,BasicUI.getBitmapData(BasicUI.getNumber(2,COLOR_NUMBER)));
			NameList.add(MoonConst.MODEL_INTEGER,MoonConst.INTEGER_3,BasicUI.getBitmapData(BasicUI.getNumber(3,COLOR_NUMBER)));
			NameList.add(MoonConst.MODEL_INTEGER,MoonConst.INTEGER_4,BasicUI.getBitmapData(BasicUI.getNumber(4,COLOR_NUMBER)));
			NameList.add(MoonConst.MODEL_INTEGER,MoonConst.INTEGER_5,BasicUI.getBitmapData(BasicUI.getNumber(5,COLOR_NUMBER)));
			NameList.add(MoonConst.MODEL_INTEGER,MoonConst.INTEGER_6,BasicUI.getBitmapData(BasicUI.getNumber(6,COLOR_NUMBER)));
			NameList.add(MoonConst.MODEL_INTEGER,MoonConst.INTEGER_7,BasicUI.getBitmapData(BasicUI.getNumber(7,COLOR_NUMBER)));
			NameList.add(MoonConst.MODEL_INTEGER,MoonConst.INTEGER_8,BasicUI.getBitmapData(BasicUI.getNumber(8,COLOR_NUMBER)));
			NameList.add(MoonConst.MODEL_INTEGER, MoonConst.INTEGER_9, BasicUI.getBitmapData(BasicUI.getNumber(9, COLOR_NUMBER)));
			
			//time
			NameList.add(MoonConst.MODEL_TIME, MoonConst.TIME_COLON, BasicUI.getBitmapData(BasicUI.getColon(COLOR_NUMBER)));
			
			//radio 多个百分比例
			NameList.add(MoonConst.MODEL_MULTIPLE_PERCENT,MoonConst.MULTIPLE_BODY,BasicUI.getBitmapData(BasicUI.getRoundRect(10,10,COLOR_TIPS_BG)),COLOR_BUTTON_UP);
			
		}
	}
}