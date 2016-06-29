/****************************************/
/**
 * 网格软件js公共库 字符串处理js
 * 2013.08.30
 */
/****************************************/

/**
 * @json字符串和对象互转函数
 * @普通字符串处理函数
 * 添加String对象属性，
 */
String.prototype.Trim = function() {
	return this.replace(/(^\s*)|(\s*$)/g, ""); //去除左右两边空格
}; 
String.prototype.LTrim = function() { 
	return this.replace(/(^\s*)/g, "");//去除左空格 
}; 
String.prototype.RTrim = function() { 
	return this.replace(/(\s*$)/g, ""); //去除右空格
};
String.prototype.Format = function(formatRule){
	var spString;
	var spFormate;
	var spFormateValue;
	var res = '';
	var condition = '';
	var flg = true;
	var count = 0;
	if(this.length==0 || formatRule.split("#").length==0){
		return this;
    }
	spString = this.split("");
	spFormate = formatRule.split(",");
	var arr = new Array(spFormate.length);   

	for(var j=0;j<spFormate.length;j++){
       spFormateValue=spFormate[j].split("#");
       if(j==spFormate.length-1){
    	   arr[j]=spFormateValue.length-1;
       }else{
    	   for(var k=j;k<spFormate.length;k++){
    		   spFormateValue=spFormate[k].split("#");
               if(k==j){
            	   arr[j]=spFormateValue.length-1;
               }else{
                   arr[j]=arr[j]+spFormateValue.length-1;
               }
           }
       }
       if(j==spFormate.length-1){
    	   condition=condition+"i=="+arr[j];
       } else {
    	   condition=condition+"i=="+arr[j]+" "+"||"+" ";
       }
	}

	for(var i = this.length-1; i >=0 ; i--){
		count=count+1;
		for(j=0;j<spFormate.length;j++){
			if((count==arr[j]) && count !=this.length){
				res=","+spString[i]+res;
				flg="false"; 
			}
		}
        if(flg=="false"){
            flg="true";
        }else{
        	res=spString[i]+res;
        }
	}
	return res;
};
/*
 * 
 * 获得子字符串在字符串中的最后出现位置
 */
String.prototype.EndWith=function(s){
  if(s==null||s==""||this.length==0||s.length>this.length)
     return false;
  if(this.substring(this.length-s.length)==s)
     return true;
  else
     return false;
  return true;
};
/*
 * 获得子字符串在字符串中的起始出现位置
 */
String.prototype.StartWith=function(s){
  if(s==null||s==""||this.length==0||s.length>this.length)
   return false;
  if(this.substr(0,s.length)==s)
     return true;
  else
     return false;
  return true;
};
/**********验证是否是手机号码和电话号码用到(详见：systemUtils.js中的formSubmit(form1))*******/
String.prototype.Trim2 = function() {
	var m = this.match(/^\s*(\S+(\s+\S+)*)\s*$/);
	return (m == null) ? "" : m[1];
};
String.prototype.isMobile = function() {
	/*return (/^(?:13\d|15[89])-?\d{5}(\d{3}|\*{3})$/.test(this.Trim()));*///原本的，但是有问题(有些号码是对的报错)
	return (/^1[3|4|5|8][0-9]\d{4,8}$/.test(this.Trim()));
};
String.prototype.isTel = function(){
	//"兼容格式: 400热线电话，国家代码(2到3位)-区号(2到3位)-电话号码(7到8位)-分机号(3位)"
	//return (/^(([0\+]\d{2,3}-)?(0\d{2,3})-)?(\d{7,8})(-(\d{3,}))?$/.test(this.Trim()));
	return (/^((\d{3,4}-)?(\d{3,8})(-(\d{3,4}))?)$/.test(this.Trim()));
};

/*****************************************************************************************/
//判断字符串在去除左右空格后是否为空
function isEmpty(str, isTrim){
	if (typeof(isTrim) == 'undefined') {
		isTrim = true;
	}
	
	var type = typeof(str);
	if (type == 'undefined') {
		return true;
		
	} else if (type == 'string'){
		if (isTrim) {
			return str.Trim() == '';
			
		} else {
			return str == '';
		}
		
	} else {
		return true;
	}
}
/*
 * 将json字符串转为对象类型
 * 转换后可以使用 obj.key的方式获得数据
 */
function str2obj(str) {
	var obj;
	try {
		obj = eval("(" + str + ")");
	} catch (e) {
		obj = new Object();
	}
	
	return obj;
}
/*
 * 将对象转为json字符串
 * 
 */
function obj2json(obj) {
	var json = '{';
	var len = map.arr.length;
	
	if (len > 0) {
		json += '"';
		json += map.arr[0].key;
		json += '":"';
		json += encodeURI(map.arr[0].value);
		json += '"';
	}
	
	for (var i = 1; i < len; i++) {
		json += ',';
		json += '"';
		json += map.arr[i].key;
		json += '":"';
		json += encodeURI(map.arr[i].value);
		json += '"';
	}
	json += '}';
	
	return json;
}
