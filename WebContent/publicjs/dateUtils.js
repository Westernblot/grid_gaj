/**
 * 获得日期在年中的周数
 * @param date
 * @returns
 */

/*日期相关函数*/
function getWeekNumForYear(ymd) {
	var b = null;
	var year = null;
	if (ymd) {
		ymd = ymd.split("-");
		try {
			year = ymd[0];
			b = new Date(ymd[0], ymd[1] - 1, ymd[2], 0, 0, 0, 0);
			b = b.getDay() >= 0 ? b : false;
		} catch (e) {
			b = false;
		}
	}
	if (!b) {
		b = new Date();
		year = b.getFullYear();
	}
	
	var ds = 24 * 3600 * 1000;
	var a = new Date(year, 0, 1, 0, 0, 0, 0);
	var ad = a.getDay() == 0 ? 7 : a.getDay();
	var D = (b.getTime() - a.getTime()) / ds;// 跟1月1日有几天

	// 如果是年初几天
	if (ad <= 4) {
		if ((D + ad) <= 7)
			return 1;
		else
			D += a.getDay();
	} else {
		if ((D + ad) <= 7) {
			// 去年一年的周数
			year -= 1;
			for ( var i = 31; i > 24; i--) {
				var x = getW(year + "-12" + "-" + i);
				if (x > 10)return x;
			}
		} else {
			D -= 7 - ad;
		}
	}
	var W = D / 7;
	if (Math.ceil(W) == W)
		return W;
	//如果是年末几天
	var c = new Date(year, 11, 31, 0, 0, 0, 0);
	var cd = c.getDay() == 0 ? 7 : c.getDay();
	if (cd < 4) {
		var D2 = (c - b) / ds;//跟12月31日有几天
		if (D2 < cd)
			return 1;//移到下一年
	}
	//年中
	return Math.ceil(W);
}

function getYearWeek(datestr){
	var arr = datestr.split('-');
	var date = new Date(arr[0], arr[1]*1-1, arr[2], 0, 0, 0, 0);
    var date2 = new Date(arr[0], 0, 1);
    var day1 = date.getDay();
    if(day1==0) day1=7;
    var day2 = date2.getDay();
    if(day2==0) day2=7;
    d = Math.round((date.getTime() - date2.getTime()+(day2-day1)*(24*60*60*1000)) / 86400000);
    return Math.ceil(d /7)+1;
}

//---------------------------------------------------  
//判断闰年  
//---------------------------------------------------  
Date.prototype.isLeapYear = function()   
{   
	if(0 == this.getFullYear()%4 && ((this.getFullYear()%100 != 0) || (this.getFullYear()%400 == 0))){
		return true;
	}
	return false;   
};

function isLeapYear(year){
	if(0 == year%4 && ((year%100 != 0) || (year%400 == 0))){
		return true;
	}
	return false;
}
//---------------------------------------------------  
//日期格式化  
//格式 YYYY/yyyy/YY/yy 表示年份  
//MM/M 月份  
//W/w 星期  
//dd/DD/d/D 日期  
//hh/HH/h/H 时间  
//mm/m 分钟  
//ss/SS/s/S 秒  
//---------------------------------------------------  
Date.prototype.Format = function(formatStr) {
	var str = formatStr;
	var Week = [ '日', '一', '二', '三', '四', '五', '六' ];

	str = str.replace(/yyyy|YYYY/, this.getFullYear());
	str = str.replace(/yy|YY/,
			(this.getYear() % 100) > 9 ? (this.getYear() % 100).toString()
					: '0' + (this.getYear() % 100));

	str = str.replace(/MM/, this.getMonth() + 1 > 9 ? (this.getMonth() + 1)
			.toString() : '0' + (this.getMonth() + 1));
	str = str.replace(/M/g, this.getMonth() + 1);

	str = str.replace(/w|W/g, Week[this.getDay()]);

	str = str.replace(/dd|DD/, this.getDate() > 9 ? this.getDate().toString()
			: '0' + this.getDate());
	str = str.replace(/d|D/g, this.getDate());

	str = str.replace(/hh|HH/, this.getHours() > 9 ? this.getHours().toString()
			: '0' + this.getHours());
	str = str.replace(/h|H/g, this.getHours());
	str = str.replace(/mm/, this.getMinutes() > 9 ? this.getMinutes()
			.toString() : '0' + this.getMinutes());
	str = str.replace(/m/g, this.getMinutes());

	str = str.replace(/ss|SS/, this.getSeconds() > 9 ? this.getSeconds()
			.toString() : '0' + this.getSeconds());
	str = str.replace(/s|S/g, this.getSeconds());

	return str;
};

//+---------------------------------------------------  
//| 日期计算  
//+---------------------------------------------------  
Date.prototype.DateAdd = function(strInterval, Number) {   
  var dtTmp = this;  
  switch (strInterval) {
      case 's' :return new Date(Date.parse(dtTmp) + (1000 * Number));  
      case 'n' :return new Date(Date.parse(dtTmp) + (60000 * Number));  
      case 'h' :return new Date(Date.parse(dtTmp) + (3600000 * Number));  
      case 'd' :return new Date(Date.parse(dtTmp) + (86400000 * Number));  
      case 'w' :return new Date(Date.parse(dtTmp) + ((86400000 * 7) * Number));  
      case 'q' :return new Date(dtTmp.getFullYear(), (dtTmp.getMonth()) + Number*3, dtTmp.getDate(), dtTmp.getHours(), dtTmp.getMinutes(), dtTmp.getSeconds());  
      case 'm' :return new Date(dtTmp.getFullYear(), (dtTmp.getMonth()) + Number, dtTmp.getDate(), dtTmp.getHours(), dtTmp.getMinutes(), dtTmp.getSeconds());  
      case 'y' :return new Date((dtTmp.getFullYear() + Number), dtTmp.getMonth(), dtTmp.getDate(), dtTmp.getHours(), dtTmp.getMinutes(), dtTmp.getSeconds());  
  }  
};

//+---------------------------------------------------  
//| 把日期分割成数组  
//+---------------------------------------------------  
Date.prototype.toArray = function()  
{   
  var myDate = this;  
  var myArray = Array();  
  myArray[0] = myDate.getFullYear();  
  myArray[1] = myDate.getMonth();  
  myArray[2] = myDate.getDate();  
  myArray[3] = myDate.getHours();  
  myArray[4] = myDate.getMinutes();  
  myArray[5] = myDate.getSeconds();  
  return myArray;  
};

//+---------------------------------------------------  
//| 取得日期数据信息  
//| 参数 interval 表示数据类型  
//| y 年 m月 d日 w星期 ww周 h时 n分 s秒  
//+---------------------------------------------------  
Date.prototype.DatePart = function(interval)  
{   
  var myDate = this;  
  var partStr = '';  
  var Week = ['日','一','二','三','四','五','六'];  
  switch (interval)  
  {   
      case 'y' :partStr = myDate.getFullYear();break;  
      case 'm' :partStr = myDate.getMonth()+1;break;  
      case 'd' :partStr = myDate.getDate();break;  
      case 'w' :partStr = Week[myDate.getDay()];break;  
      case 'ww' :partStr = myDate.WeekNumOfYear();break;  
      case 'h' :partStr = myDate.getHours();break;  
      case 'n' :partStr = myDate.getMinutes();break;  
      case 's' :partStr = myDate.getSeconds();break;  
  }  
  var partStr2 = partStr;
  return partStr2;  
};


/*农历部分*/

var CalendarData = new Array(100);
var madd = new Array(12);
var tgString = "甲乙丙丁戊己庚辛壬癸";
var dzString = "子丑寅卯辰巳午未申酉戌亥";
var numString = "一二三四五六七八九十";
var monString = "正二三四五六七八九十冬腊";
var weekString = "日一二三四五六";
var sx = "鼠牛虎兔龙蛇马羊猴鸡狗猪";
var cYear, cMonth, cDay, TheDate;
CalendarData = new Array(0xA4B, 0x5164B, 0x6A5, 0x6D4, 0x415B5, 0x2B6, 0x957,
		0x2092F, 0x497, 0x60C96, 0xD4A, 0xEA5, 0x50DA9, 0x5AD, 0x2B6, 0x3126E,
		0x92E, 0x7192D, 0xC95, 0xD4A, 0x61B4A, 0xB55, 0x56A, 0x4155B, 0x25D,
		0x92D, 0x2192B, 0xA95, 0x71695, 0x6CA, 0xB55, 0x50AB5, 0x4DA, 0xA5B,
		0x30A57, 0x52B, 0x8152A, 0xE95, 0x6AA, 0x615AA, 0xAB5, 0x4B6, 0x414AE,
		0xA57, 0x526, 0x31D26, 0xD95, 0x70B55, 0x56A, 0x96D, 0x5095D, 0x4AD,
		0xA4D, 0x41A4D, 0xD25, 0x81AA5, 0xB54, 0xB6A, 0x612DA, 0x95B, 0x49B,
		0x41497, 0xA4B, 0xA164B, 0x6A5, 0x6D4, 0x615B4, 0xAB6, 0x957, 0x5092F,
		0x497, 0x64B, 0x30D4A, 0xEA5, 0x80D65, 0x5AC, 0xAB6, 0x5126D, 0x92E,
		0xC96, 0x41A95, 0xD4A, 0xDA5, 0x20B55, 0x56A, 0x7155B, 0x25D, 0x92D,
		0x5192B, 0xA95, 0xB4A, 0x416AA, 0xAD5, 0x90AB5, 0x4BA, 0xA5B, 0x60A57,
		0x52B, 0xA93, 0x40E95);
madd[0] = 0;
madd[1] = 31;
madd[2] = 59;
madd[3] = 90;
madd[4] = 120;
madd[5] = 151;
madd[6] = 181;
madd[7] = 212;
madd[8] = 243;
madd[9] = 273;
madd[10] = 304;
madd[11] = 334;

function getBit(m, n) {
	return (m >> n) & 1;
}

function e2c() {
	TheDate = (arguments.length != 3) ? new Date() : new Date(arguments[0],
			arguments[1], arguments[2]);
	var total, m, n, k;
	var isEnd = false;
	var tmp = TheDate.getYear();
	if (tmp < 1900) {
		tmp += 1900;
	}
	total = (tmp - 1921) * 365 + Math.floor((tmp - 1921) / 4)
			+ madd[TheDate.getMonth()] + TheDate.getDate() - 38;

	if (TheDate.getYear() % 4 == 0 && TheDate.getMonth() > 1) {
		total++;
	}
	for (m = 0;; m++) {
		k = (CalendarData[m] < 0xfff) ? 11 : 12;
		for (n = k; n >= 0; n--) {
			if (total <= 29 + getBit(CalendarData[m], n)) {
				isEnd = true;
				break;
			}
			total = total - 29 - getBit(CalendarData[m], n);
		}
		if (isEnd)
			break;
	}
	cYear = 1921 + m;
	cMonth = k - n + 1;
	cDay = total;
	if (k == 12) {
		if (cMonth == Math.floor(CalendarData[m] / 0x10000) + 1) {
			cMonth = 1 - cMonth;
		}
		if (cMonth > Math.floor(CalendarData[m] / 0x10000) + 1) {
			cMonth--;
		}
	}
}

function getcDateString() {
	var tmp = "";
	tmp += tgString.charAt((cYear - 4) % 10);
	tmp += dzString.charAt((cYear - 4) % 12);
	tmp += "(";
	tmp += sx.charAt((cYear - 4) % 12);
	tmp += ")年 ";
	if (cMonth < 1) {
		tmp += "(闰)";
		tmp += monString.charAt(-cMonth - 1);
	} else {
		tmp += monString.charAt(cMonth - 1);
	}
	tmp += "月";
	tmp += (cDay < 11) ? "初" : ((cDay < 20) ? "十" : ((cDay < 30) ? "廿" : "三十"));
	if (cDay % 10 != 0 || cDay == 10) {
		tmp += numString.charAt((cDay - 1) % 10);
	}
	return tmp;
}

function getLunarDay(solarYear, solarMonth, solarDay) {
	if (solarYear < 1921 || solarYear > 2020) {
		return "";
	} else {
		solarMonth = (parseInt(solarMonth) > 0) ? (solarMonth - 1) : 11;
		e2c(solarYear, solarMonth, solarDay);
		return getcDateString();
	}
}
//判断数据是否包含值
function inArray(arr, e){
	for (var i = 0; i<arr.length; i++) {
		if (arr[i] == e){
			return true;
		}
	}
	return false;
}
function getMaxDayForMonth(year,month){
	if(month == 12){
		year = year*1 + 1;
		month = 0;
	}
	var date = new Date(year,month,0);
	return date.getDate();
}

/**
 * 获取星期集合
 * 
 * */
function getWeekDayArray(sDate) {
	var date = new Date(sDate);
	var week = new Array();
	var currentWeek = date.getDay();
	if (currentWeek == 0) {
		currentWeek = 7;
	}
	var monday = date.getTime() - (currentWeek - 1) * 24 * 60 * 60 * 1000; // 星期一
	week[0] = new Date(monday);
	var tuesday = date.getTime() - (currentWeek - 2) * 24 * 60 * 60 * 1000; // 星期二
	week[1] = new Date(tuesday);
	var wednesday = date.getTime() - (currentWeek - 3) * 24 * 60 * 60 * 1000; // 星期三
	week[2] = new Date(wednesday);
	var thursday = date.getTime() - (currentWeek - 4) * 24 * 60 * 60 * 1000; // 星期四
	week[3] = new Date(thursday);
	var friday = date.getTime() - (currentWeek - 5) * 24 * 60 * 60 * 1000; // 星期五
	week[4] = new Date(friday);
	var saturday = date.getTime() - (currentWeek - 6) * 24 * 60 * 60 * 1000; // 星期六
	week[5] = new Date(saturday);
	var sunday = date.getTime() + (7 - currentWeek) * 24 * 60 * 60 * 1000; //星期日
	week[6] = new Date(sunday);
	
	return week;
}

/**
 * 计算两时间相差的天数
 * 
 * @param bigDate
 *            大时间的id
 * @param smallDate
 *            小时间的id
 * @param ts
 *            存放时间差的id
 */
function countDateDiffDay(dStr1, dStr2){
	// dStr1,dStr2必须为yyyy-mm-dd格式
	var arr = dStr1.split('-');
	var bDate = new Date(arr[0], arr[1]-1, + arr[2], 0, 0, 0, 0);
	arr = dStr2.split('-');
	var sDate = new Date(arr[0], arr[1]-1, + arr[2], 0, 0, 0, 0);
	iDays = parseInt(Math.abs(bDate.getTime() - sDate.getTime()) / 1000 / 60 / 60 / 24); // 把相差的毫秒数转换为天数
	iDays++;
	return iDays;
}

/**
 * 显示时间
 * @param oldtime
 * 		是一个id集合，将输入框的id用,连接起来传至该js
 * @param time
 * 		显示新的时间的输入框id
 */
function getDate(oldtime,time){
	var arr = oldtime.split(",");
	var newtime = "";
	for(var i=0;i<arr.length;i++){
		var date = document.getElementById(arr[i]).value;
		if(Number(date) > 0){
			newtime += date + "-";
		}
		else{
			setfocus(arr[i]);
			break;
		}
	}
	document.getElementById(time).value = newtime.substring(0,newtime.length - 1);
}

/**
 * 计算特定时间后的3个月的时间
 * @param felid1
 * 		时间id
 * @param felid2
 * 		三个月后显示时间的id
 */
function countDate(felid1,felid2){
	var thisDayVal = $("#"+ felid1).val();
	if(thisDayVal == undefined){//如果找不到id=felid1的值，则返回
		return;
	}
	thisDayVal = thisDayVal.split("-");	//获取时间的值
	
	var time1 = new Date(thisDayVal[0],thisDayVal[1],thisDayVal[2]); //将这个值转换为一个时间对象
	var time2 = new Date(time1.getTime() + 7776000000);			//new 一个新的时间对象,并加上 90 天(毫秒数)
	
	var month = time2.getMonth() < 10 ? "0" + time2.getMonth() : time2.getMonth();
	var day = time2.getDate() < 10 ? "0" + time2.getDate() : time2.getDate();
	if(month == '00'){
		month = '01';
	}
	var nextDay = time2.getFullYear() + "-" + month + "-" + day;  //将时间对象转换成我们需要的格式
	$("#" + felid2).val(nextDay);		//把时间赋值给新的input
}


