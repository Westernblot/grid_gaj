/*
 * 设置cookie函数				by ylw 2014.10.17
 * objName 	- 	cookie的名
 * objValue - 	cookie的值
 * objHours	-	cookie保存的时间(单位小时)
 * objPath  -	cookie保存的路径
 */
function addCookie(objName, objValue, objHours, objPath) { //添加cookie
	objValue = encodeURI(objValue);//进行URI编码，防止中文乱码 
	var str = objName + "=" + objValue;
	if (objHours > 0) { //为时不设定过期时间，浏览器关闭时cookie自动消失
		var date = new Date();
		var ms = objHours * 3600 * 1000;
		date.setTime(date.getTime() + ms);
		str += "; expires=" + date.toGMTString() + ((objPath == null) ? "" : ("; path=" + objPath));
	}
	document.cookie = str;
}

/*
 * 设置cookie函数				by ylw 2014.10.17
 * name 	- 	cookie的名
 * value 	- 	cookie的值
 */
function SetCookie(name, value) {//两个参数，一个是cookie的名子，一个是值
	objValue = encodeURI(value);//进行URI编码，防止中文乱码 
	var Days = 30; //此 cookie 将被保存 30 天
	var exp = new Date(); //new Date("December 31, 9998");
	exp.setTime(exp.getTime() + Days * 24 * 60 * 60 * 1000);
	document.cookie = name + "=" + value + ";expires=" + exp.toGMTString();
}

/*
 * 获取cookie函数				by ylw 2014.10.17
 * objName	-	cookie的名称
 */
function getCookies(objName) {//获取指定名称的cookie的值
	var arrStr = document.cookie.split("; ");//得到分割的cookie名值对
	for (var i = 0; i < arrStr.length; i++) {
		var temp = arrStr[i].split("=");//将名和值分开
		if (temp[0] == objName)
			return decodeURI(temp[1]);//如果是指定的cookie，则返回它的值
	}
	return "";
}

/*
 * 获取cookie函数				by ylw 2014.10.17
 * name	-	cookie的名称
 */
function getCookie(name) {//取cookies函数
	var arr = document.cookie.match(new RegExp("(^| )" + name + "=([^;]*)(;|$)"));
	if (arr != null){
		return decodeURI(arr[2]);
	}
	return null;
}

/*
 *删除cookie函数				by ylw 2014.10.17
 * objName	-	cookie的名称
 * objPath  -	cookie保存的路径
 */
function delCookie(objName,objPath) {//删除cookie
	var exp = new Date();
	exp.setTime(exp.getTime() - 10000);
	var cval = getCookie(objName);
	if (cval != null)
		document.cookie = objName + "=" + null + ";expires=" + exp.toGMTString() + ((objPath == null) ? "" : ("; path=" + objPath));
}
