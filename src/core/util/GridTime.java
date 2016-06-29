package core.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

public class GridTime {

	/**
	 * 获得今天 
	 * @param format：返回的时间格式
	 * @return：按格式返回今天的时间
	 */
	public String GetToday(String format) {
		Date date = new Date();// 取时间
		//SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat formatter = new SimpleDateFormat(format);
		return formatter.format(date);
	}
	
	/**
	 * 获得昨天 
	 * @param format：返回的时间格式
	 * @return：按格式返回昨天的时间
	 */
	public String GetYestoday(String format) {
		Date date = new Date();// 取时间
		Calendar calendar = new GregorianCalendar();
		calendar.setTime(date);
		calendar.add(Calendar.DATE, -1);// 把日期往前增加一天.整数往后推,负数往前移动
		date = calendar.getTime(); // 这个时间就是日期往后推一天的结果
		SimpleDateFormat formatter = new SimpleDateFormat(format);
		return formatter.format(date);
	}
	
	/**
	 * 获得明天 
	 * @param format：返回的时间格式
	 * @return：按格式返回明天的时间
	 */
	public String GetTomorrow(String format) {
		Date date = new Date();// 取时间
		Calendar calendar = new GregorianCalendar();
		calendar.setTime(date);
		calendar.add(Calendar.DATE, 1);// 把日期往后增加一天.整数往后推,负数往前移动
		date = calendar.getTime(); // 这个时间就是日期往后推一天的结果
		SimpleDateFormat formatter = new SimpleDateFormat(format);
		return formatter.format(date);
	}
	
	/**
	 * 获得前天 
	 * @param format：返回的时间格式
	 * @return：按格式返回前天的时间
	 */
	public String GetBeforeYestoday(String format) {
		Date date = new Date();// 取时间
		Calendar calendar = new GregorianCalendar();
		calendar.setTime(date);
		calendar.add(Calendar.DATE, -2);// 把日期往前增加一天.整数往后推,负数往前移动
		date = calendar.getTime(); // 这个时间就是日期往后推一天的结果
		SimpleDateFormat formatter = new SimpleDateFormat(format);
		return formatter.format(date);
	}

}
