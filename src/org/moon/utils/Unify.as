package org.moon.utils
{
	/**
	 * ...
	 * @author vinson
	 */
	public class Unify
	{
		/**得到从现在到到未来的一个时间里面的秒数
		 * str: 2015/12/29-16:43:11
		 * */
		public static function getTimeNumber(str:*):int
		{
			if(Number(str)==0){
				str=str.split("-")[0]+" "+str.split("-")[1];
			}
			var currentData:Date=new Date();
			var endDate:Date=new Date(str);
			var value:int=(endDate.getTime()-currentData.getTime())/1000;
			return value
		}
		
		/**得到从现在到到未来的一个时间里面的具体时间如1天2小时3分
		 * str: 2015/12/29-16:43:11 或者(自 1970 年 1 月 1 日午夜以来的一个未来毫秒数)
		 * 返回-1表示过期
		 * */
		public static function getTimeArray(str:*):Array
		{
			var value:int=getTimeNumber(str);
			if(value<=0) return [];
			var day:int=int(value/(24*60*60));
			var hours:int=int((value-(day*24*60*60))/3600);
			var minute:int=int((value-(day*24*60*60)-(hours*3600))/60);
			var second:int=int((value-(day*24*60*60)-(hours*3600)-minute*60));
			return [hours, minute, second];
		}
	}
}