package core.util;

import java.text.DateFormat;
import java.text.Format;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;

/**
 * 项目名称：his <br>
 * 类名称：DateUtils <br>
 * 类描述：日期操作类 <br>
 * 创建人：10yue <br>
 * 创建时间：2011-10-8 下午4:37:57 <br>
 * 修改人：10yue <br>
 * 修改时间：2011-10-8 下午4:37:57 <br>
 * 修改备注： <br>
 * 
 * @version 1.0
 */
public class DateUtils {
	
	/**
	 * 自定义时间格式
	 * 
	 * @param format
	 *            格式 如：yyyy-MM-dd HH:mm:ss,yyyy年MM月dd日_HH时mm分ss秒
	 * @return String
	 */
	public String showDate(String format) {
		Date dNow = new Date();
		SimpleDateFormat myformat = new SimpleDateFormat(format);
		String mydate = myformat.format(dNow);
		return mydate;
	}

	/**
	 * 格式化日期
	 * 
	 * @param String
	 *            data 格式化日期
	 * @return 格式化后日期
	 */
	public static String formatDate(String date) {
		return date.substring(5, 10);

	}

	/**
	 * 自定义格式化时间
	 * 
	 * @param format
	 *            格式 如：yyyy-MM-dd HH:mm:ss,yyyy年MM月dd日_HH时mm分ss秒
	 * @param datetime
	 *            需要格式的时间
	 * @return
	 */
	public String DateFormat(String format, String datetime) {
		SimpleDateFormat myformat = new SimpleDateFormat(format);
		DateFormat df = DateFormat.getDateInstance(DateFormat.DEFAULT,
				Locale.CHINESE);
		String mydatetime;
		try {
			mydatetime = myformat.format(df.parse(datetime));
		} catch (ParseException e) {
			e.printStackTrace();
			return "";
		}

		return mydatetime;
	}

	/**
	 * 自定义格式化时间
	 * 
	 * @param format
	 *            格式 如：yyyy-MM-dd HH:mm:ss,yyyy年MM月dd日_HH时mm分ss秒
	 * @param datetime
	 *            需要格式的时间
	 * @return
	 */
	/**
	 * 自定义日期格式前后n天
	 * 
	 * @param n
	 *            -1前一天; 1后一天
	 * @param format
	 *            日期格式
	 * @return String
	 */
	public String afterNDay(int n, String format) {
		Calendar c = Calendar.getInstance();
		DateFormat df = new SimpleDateFormat(format);
		c.setTime(new Date());
		c.add(Calendar.DATE, n);
		Date d2 = c.getTime();
		String s = df.format(d2);
		return s;
	}

	/**
	 * 自定义选定日期格式前后n天
	 * 
	 * @param n
	 *            -1前一天; 1后一天
	 * @param format
	 *            日期格式
	 * @param mydate
	 *            选定日期
	 * @return String
	 * @throws ParseException
	 */
	public String afterNDay(int n, String format, String mydate)
			throws ParseException {
		Calendar c = Calendar.getInstance();
		DateFormat df = new SimpleDateFormat(format);
		c.setTime(df.parse(mydate));
		c.add(Calendar.DATE, n);
		Date d2 = c.getTime();
		String s = df.format(d2);
		return s;
	}

	/**
	 * 计算从当前时间 到指定天数后的时间
	 * @param day  day为指定天数
	 * @return
	 */
	public String showNextDay(int day) {
		Format format = new SimpleDateFormat("yyyy-MM-dd");
		long time = 0;
		Date today = new Date();
		time = (today.getTime() / 1000) + 60 * 60 * 24 * day;
		Date newDate = new Date();
		newDate.setTime(time * 1000);
		String nextdate = format.format(newDate);
		return nextdate;
	}

	/**
	 * 自定义月份格式前后n月
	 * 
	 * @param n
	 *            -1前一月; 1后一月
	 * @param format
	 *            月份格式
	 * @return String
	 */
	public String afterNMonth(int n, String format) {
		Calendar c = Calendar.getInstance();
		DateFormat df = new SimpleDateFormat(format);
		c.setTime(new Date());
		c.add(Calendar.MONTH, n);
		Date d2 = c.getTime();
		String s = df.format(d2);
		return s;
	}

	/**
	 * 自定义选定月份格式前后n月
	 * 
	 * @param n
	 *            -1前一月; 1后一月
	 * @param format
	 *            月份格式
	 * @param mydate
	 *            选定月份
	 * @return String
	 * @throws ParseException
	 */
	public String afterNMonth(int n, String format, String mydate)
			throws ParseException {
		Calendar c = Calendar.getInstance();
		DateFormat df = new SimpleDateFormat(format);
		c.setTime(df.parse(mydate));
		c.add(Calendar.MONTH, n);
		Date d2 = c.getTime();
		String s = df.format(d2);
		return s;
	}

	/**
	 * 自定义年份格式前后n年
	 * 
	 * @param n
	 *            -1前一年; 1后一年
	 * @param format
	 *            年份格式
	 * @return String
	 */
	public String afterNYear(int n, String format) {
		Calendar c = Calendar.getInstance();
		DateFormat df = new SimpleDateFormat(format);
		c.setTime(new Date());
		c.add(Calendar.YEAR, n);
		Date d2 = c.getTime();
		String s = df.format(d2);
		return s;
	}

	/**
	 * 自定义选定年份格式前后n年
	 * 
	 * @param n
	 *            -1前一年; 1后一年
	 * @param format
	 *            年份格式
	 * @param mydate
	 *            选定年份
	 * @return String
	 * @throws ParseException
	 */
	public String afterNYear(int n, String format, String mydate)
			throws ParseException {
		Calendar c = Calendar.getInstance();
		DateFormat df = new SimpleDateFormat(format);
		c.setTime(df.parse(mydate));
		c.add(Calendar.YEAR, n);
		Date d2 = c.getTime();
		String s = df.format(d2);
		return s;
	}

	/**
	 * 计算时间差 (时间单位,开始时间,结束时间) 调用方法
	 * howLong("h","2007-08-09 10:22:26","2007-08-09 20:21:30") ///9小时56分 返回9小时
	 * 
	 * @param unit
	 * @param time1
	 * @param time2
	 * @return
	 * @throws ParseException
	 */
	public long howLong(String unit, String time1, String time2)
			throws ParseException {
		// 时间单位(如：不足1天(24小时) 则返回0)，开始时间，结束时间
		Date date1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(time1);
		Date date2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(time2);
		long ltime = date1.getTime() - date2.getTime() < 0 ? date2.getTime()
				- date1.getTime() : date1.getTime() - date2.getTime();
		if (unit.equals("s")) {
			return ltime / 1000; // 返回秒
		} else if (unit.equals("m")) {
			return ltime / 60000; // 返回分钟
		} else if (unit.equals("h")) {
			return ltime / 3600000; // 返回小时
		} else if (unit.equals("d")) {
			return ltime / 86400000; // 返回天数
		} else {
			return 0;
		}
	}

	/**
	 * 以格式输出 howLong 方法的结果 小写单位符号 m 代表以分结尾 ，大写单位符号 M 代表以分开头 Hm 代表 以小时开头 以分结尾
	 * 
	 * @param unit
	 * @param time1
	 * @param time2
	 * @return
	 * @throws ParseException
	 */
	public String howLong2(String unit, String time1, String time2)
			throws ParseException {
		long Dnum = howLong("d", time1, time2);
		long Secnum = howLong("s", time1, time2);
		long Hnum = 0;
		long Mnum = 0;
		long Snum = 0;
		if (Secnum < 86400) {
			Dnum = 0;
		}
		long sd = Dnum * 24 * 3600;
		long sh = Secnum - sd;
		Hnum = sh / 3600;
		long sm = sh - Hnum * 3600;
		Mnum = sm / 60;
		Snum = sm - Mnum * 60;
		if (unit.equals("d")) {
			return Dnum + "天";
		} else if (unit.equals("h")) {
			return Dnum + "天" + Hnum + "小时";
		} else if (unit.equals("m")) {
			return Dnum + "天" + Hnum + "小时" + Mnum + "分";
		} else if (unit.equals("s")) {
			return Dnum + "天" + Hnum + "小时" + Mnum + "分" + Snum + "秒";
		} else if (unit.equals("H")) {
			return Dnum * 24 + Hnum + "小时" + Mnum + "分" + Snum + "秒";
		} else if (unit.equals("M")) {
			return (Dnum * 24 + Hnum) * 60 + "分" + Snum + "秒";
		} else if (unit.equals("Hm")) {
			return Dnum * 24 + Hnum + "小时" + Mnum + "分";
		} else {
			return Dnum + "天" + Hnum + "小时" + Mnum + "分" + Snum + "秒";
		}
	}

	/**
	 * 计算时间差 (时间单位,开始时间,结束时间) 调用方法
	 * howLong("h","2007-08-09 10:22:26","2007-08-09 20:21:30") ///9小时56分 返回9小时
	 * 
	 * @param unit
	 * @param time1
	 * @param time2
	 * @return
	 * @throws ParseException
	 */
	public long howLong3(String unit, String time1, String time2)
			throws ParseException {
		// 时间单位(如：不足1天(24小时) 则返回0)，开始时间，结束时间
		Date date1 = new SimpleDateFormat("yyyy-MM-dd").parse(time1);
		Date date2 = new SimpleDateFormat("yyyy-MM-dd").parse(time2);
		long ltime = date1.getTime() - date2.getTime() < 0 ? date2.getTime()
				- date1.getTime() : date1.getTime() - date2.getTime();
		if (unit.equals("s")) {
			return ltime / 1000; // 返回秒
		} else if (unit.equals("m")) {
			return ltime / 60000; // 返回分钟
		} else if (unit.equals("h")) {
			return ltime / 3600000; // 返回小时
		} else if (unit.equals("d")) {
			return ltime / 86400000; // 返回天数
		} else {
			return 0;
		}
	}

	/**
	 * 计算时间差 (时间单位,开始时间,结束时间) 调用方法
	 * howLong("h","2007-08-09 10:22:26","2007-08-09 20:21:30") ///9小时56分 返回9小时
	 * 
	 * @param unit
	 * @param time1
	 * @param time2
	 * @return
	 * @throws ParseException
	 */
	public long howLong4(String time1, String time2) throws ParseException {
		// 时间单位(如: 不足1天(24小时) 则返回0), 开始时间,结束时间
		Date date1 = new SimpleDateFormat("yyyy-MM-dd").parse(time1);
		Date date2 = new SimpleDateFormat("yyyy-MM-dd").parse(time2);
		long ltime = date2.getTime() - date1.getTime();
		return ltime / 86400000; // 返回天数
	}

	// 通过生日获取年龄
	public String getAge(String birthday) {
		int age = 0;
		String newAge = "0";
		if (birthday != null && birthday != "null" && birthday != " "
				&& birthday != "" && !birthday.equals("")
				&& !birthday.equals(" ") && !birthday.equals(null)
				&& !birthday.equals("null")) {
			int year = Integer.parseInt(showDate("yyyy"));// 当前年份
			int month = Integer.parseInt(showDate("MM"));// 当前月份
			int date = Integer.parseInt(showDate("dd"));// 当前日期
			int byear = Integer.parseInt(birthday.substring(0, 4));// 生日年份
			int bmonth = Integer.parseInt(birthday.substring(5, 7));// 生日月份
			int bdate = Integer.parseInt(birthday.substring(8, 10));// 生日年份

			if (year - byear == 1 && month < bmonth) {
				age = (12 - bmonth) + month;
				newAge = age + "月";

			} else if (year - byear == 0) {
				if (bmonth < month) {
					age = month - bmonth;
					newAge = age + "月";
				} else {
					age = date - bdate;
					newAge = age + "天";
				}
			} else {
				age = (bmonth <= month) ? (year - byear) : (year - byear - 1);// 获取年龄
				newAge = age + "岁";
			}
		}
		return newAge;
	}

	/**
	 * 根据日期获取星期
	 * 
	 * @param date
	 * @return
	 */
	public String getWeek(String date) {
		SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat sdw = new SimpleDateFormat("E");
		Date d = null;
		try {
			d = sd.parse(date);
			return sdw.format(d);
		} catch (ParseException e) {
			e.printStackTrace();
			return null;
		}
	}

	// 获得日期的周数
	public int getWeekNumber(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setFirstDayOfWeek(Calendar.MONDAY);

		calendar.setTime(date);
		return calendar.get(Calendar.WEEK_OF_YEAR);
	}

	// 获得年度周数
	@SuppressWarnings("unused")
	public int getWeeksOfYear(int year) {
		int week = 0;
		int days = 365;
		int day = 0;
		// 判断是否闰年，闰年366天
		if (year % 400 == 0 || (year % 4 == 0 && year % 100 != 0)) {
			days = 366;
		}
		// 得到一年所有天数然后除以7
		day = (days % 7 > 0 ? week += 1 : week);
		// 得到余下几天如果有余则周+1，否则不加
		week += days / 7;
		// 得到多少周
		return week;
	}

	// 根据年度和周数获得周一的日期字符串，注释部分可以获得周日
	public Date getWeekFirstDay(int year, int week) {
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.YEAR, year);
		cal.set(Calendar.WEEK_OF_YEAR, week);
		int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
		cal.add(Calendar.DATE, cal.getActualMinimum(Calendar.DAY_OF_WEEK)
				- dayOfWeek);
		cal.add(Calendar.DATE, 1);
		Date d = cal.getTime();
		return d;
	}

	// 根据年度和周数获得周一的日期字符串，注释部分可以获得周日
	public Date getWeekEndDay(int year, int week) {
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.YEAR, year);
		cal.set(Calendar.WEEK_OF_YEAR, week + 1);
		int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
		cal.add(Calendar.DATE, cal.getActualMinimum(Calendar.DAY_OF_WEEK)
				- dayOfWeek);
		cal.add(Calendar.DATE, 0);
		Date d = cal.getTime();
		return d;
	}

	public int getLastDay(int year, int month) {
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.YEAR, calendar.get(Calendar.YEAR));
		calendar.set(Calendar.MONTH, calendar.get(Calendar.MONTH));
		int endDay = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
		return endDay;
	}

	/****
	 * 格式化邮件时间
	 * 
	 * @param send_date
	 * @return
	 * @throws ParseException
	 */
	public String formatEmailDate(String send_date) throws ParseException {
		String today = this.showDate("yyyy-MM-dd HH:mm:ss");
		// 是不是今年
		if (send_date.substring(0, 4).equals(today.substring(0, 4))) {
			// 如果是今天
			if (send_date.substring(0, 10).equals(today.substring(0, 10))) {
				long tmpHour = this.howLong("h", send_date, today);
				if (tmpHour > 4L) {
					send_date = "今天 "
							+ send_date.substring(11, send_date.length() - 3);
				} else if (tmpHour >= 1L && tmpHour <= 4L) {
					// 计算小时差
					send_date = String.valueOf(this.howLong("h", send_date,
							today)) + "小时前";
				} else {
					// 计算分钟差
					String send_dates = String.valueOf(this.howLong("m",
							send_date, today));
					if (send_dates.equals("0")) {
						send_date = String.valueOf(this.howLong("s", send_date,
								today)) + "秒前";
					} else {
						send_date = String.valueOf(this.howLong("m", send_date,
								today)) + "分钟前";
					}
				}
			} else {// 如果不是今天
				String tmpdate = String.valueOf(this.howLong4(
						send_date.substring(0, 10), today.substring(0, 10))); // 计算时间差
				// 如果差距是一天,则显示昨天
				if (tmpdate.equals("1")) {
					send_date = "昨天 "
							+ send_date.substring(11, send_date.length() - 3);
				} else if (tmpdate.equals("2")) {
					// 如果差距是两天，则显示前天
					send_date = "前天 "
							+ send_date.substring(11, send_date.length() - 3);
				} else {
					// 否则显示日期
					send_date = this.DateFormat("yyyy年MM月dd日",
							send_date.substring(0, 10)).substring(5, 11);
					if (send_date.substring(0, 1).equals("0")) {
						send_date = send_date.substring(1, send_date.length());
						if (send_date.substring(2, 3).equals("0")) {
							send_date = send_date.substring(0, 2)
									+ send_date
											.substring(3, send_date.length());
						} else {

						}
					}
				}
			}
		} else {
			// 如果不是今年
			send_date = this.DateFormat("yyyy/MM/dd",
					send_date.substring(0, 10));
		}
		return send_date;
	}
	
	/**  
	* 根据传入的年份和月份获得该月份的天数  
	*   
	* @param year  
	*            年份-正整数  
	* @param month  
	*            月份-正整数  
	* @return 返回天数  
	*/    
	public int getDayNumber(int year, int month) {    
	    int days[] = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };    
	    if (2 == month && 0 == (year % 4) && (0 != (year % 100) || 0 == (year % 400))) {    
	        days[1] = 29;    
	    }    
	    return (days[month - 1]);
	}   

	/**
	 * @描述 根据年月获取当月天数，上文有一个方法也可以获取，这个方法使用的是系统Calendar方法实现，作为技术性补充
	 * @author 秦彪
	 * @param year
	 * @param month
	 * @return
	 */
	public int getDayNumberV2(int year,int month){
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.YEAR,year);
		cal.set(Calendar.MONTH, month-1);//Java月份才0开始算
		return cal.getActualMaximum(Calendar.DATE); 
	}
	
	/**
	 * @author 秦彪
	 * @描述 把毫秒数转换成日期
	 * @param time 毫秒数时间long型
	 * @param format 需要转换的格式
	 * @return
	 */
    public String getTimeMillisToDate(long time,String format){
    	 Date date=new Date(time);
    	 GregorianCalendar gc = new GregorianCalendar();   
    	 gc.setTime(date);
    	 java.text.SimpleDateFormat ft= new java.text.SimpleDateFormat(format);//日期格式化类型
    	return ft.format(gc.getTime());
    }
    
    /**
     * @author 秦彪
     * @描述 把日期转换成毫秒数
     * @param date
     * @param format
     * @return
     * @throws ParseException 
     */
    public long getDateToTimeMillis(String date,String format) throws ParseException{
    	SimpleDateFormat sdf = new SimpleDateFormat(format);
    	return sdf.parse(date).getTime();
    }
    
    /**
     * 某一个月第一天和最后一天
     * @param date
     * @return
     */
    public  static String getFirstdayByMonth(Date date) {
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        Date theDate = calendar.getTime();
        String firstDay = df.format(theDate);
        return firstDay;
    }
    
    /**
     * 某一个月第一天和最后一天
     * @param date
     * @return
     */
    public static String getLasdayByMonth(Date date) {
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        //上个月最后一天
        calendar.add(Calendar.MONTH, 1);    //加一个月
        calendar.set(Calendar.DATE, 1);        //设置为该月第一天
        calendar.add(Calendar.DATE, -1);    //再减一天即为上个月最后一天
        String lastDay = df.format(calendar.getTime());
        return lastDay;
    }
    
}
