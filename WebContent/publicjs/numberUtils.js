/****************************************/
/**
 * 网格软件js公共库 number处理库
 */
/****************************************/

/**
 * 输入的数量是否能整除换算关系
 * 
 * @param inamount
 *            数量
 * @param num
 *            换算关系
 * @returns {Boolean}
 */
function hsgx(inamount,num){
	var flag = true;
	var i = document.getElementById(inamount).value;
	var n = document.getElementById(num).value;
	var a = Number(i);
	var b = Number(n);
	if(a % b != 0){
		flag = false;
	}
	return flag;
}


/*******************************************************************************
 * 去除数字以外字符
 * 
 * @param obj
 * input中使用       
 * 可以用于onBlur(失去焦点时触发)
 *        onkeyup(按键跳起时触发)
 */
function clearForInt(obj){
	obj.value = obj.value.replace(/[^\d.]/g,""); // 清除“数字”和“.”以外的字符
	obj.value = obj.value.replace(/^\./g,""); // 验证第一个字符是数字而不是.
	obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
}

/*******************************************************************************
 * 去除数字和点以外字符
 * 
 * @param obj
 * input中使用       
 * 可以用于onBlur(失去焦点时触发)
 *        onkeyup(按键跳起时触发)
 */
function clearForFloat(obj){
	obj.value = obj.value.replace(/[^\d.]/g,""); // 清除“数字”和“.”以外的字符
	obj.value = obj.value.replace(/^\./g,""); // 验证第一个字符是数字而不是.
	obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
}

/**
 * 判断对象是否为0或空
 * 
 * @param obj
 * @returns {Boolean}
 */
function NumIsZero(obj){
	var num = document.getElementById(obj).value;
	var flag = true;
	if(Number(num) <= 0){
		alertMsg(3,"数量不能为0！");//【页面上要同时引用systemUtils.js】
		onselect(obj);/*该方法在systemUtils.js中*/
		flag = false;
	}
	return flag;
}

/**
 * 只能输入整数
 * 在onkeydown中使用
 */
function onlyNum(){
	// 在这里添加想要保留键的键值
	var keys = [8,9,13,48,49,50,51,52,53,54,55,56,57,96,97,98,99,100,101,102,103,104,105];
	var keyCode = event.keyCode;
	for( var i = 0;i < keys.length;i++){
		if(keyCode == keys[i]){
			event.returnValue = true;
			break;
		}else{
			event.returnValue = false;
		}
	}
}

/**
 * 只能输入实数
 * 在onkeydown中使用
 */
function DoubleNum(){
	// 在这里添加想要保留键的键值
	var keys = [8,9,13,48,49,50,51,52,53,54,55,56,57,96,97,98,99,100,101,102,103,104,105,110,190];
	var keyCode = event.keyCode;
	for( var i = 0;i < keys.length;i++){
		if(keyCode == keys[i]){
			event.returnValue = true;
			break;
		}else{
			event.returnValue = false;
		}
	}
}

/**
 * js中运算（带浮点型）
 * @param a
 * @param how
 * @param b
 * @returns
 */
function yunsuan(a,how,b){  
    if(a.toString().indexOf(".")<0 && b.toString().indexOf(".")<0){//没小数   
          return  eval(a+how+b);   
    }   
    //至少一个有小数   
    var alen = a.toString().split(".");   
    if(alen.length == 1){//没有小数   
        alen = 0;   
    }else{   
        alen = alen[1].length;   
    }   
    var blen = b.toString().split(".");   
    if(blen.length == 1){   
        blen = 0;   
    }else{   
        blen = blen[1].length;   
    }   
    if(blen > alen)alen = blen;   
    blen = "1";
    for(; alen> 0;alen--){//创建一个相应的倍数   
         blen = blen+ "0";
    } 
    switch(how){   
          case "+":   
          		return (a * blen + b * blen)/blen;   
                break;   
          case "-":   
                return (a * blen - b * blen)/blen;   
                break;   
          case "*":   
                return ((a * blen)*(b *  blen))/(blen * blen);   
                break;   
          default:   
                alert("你要求的\t" + how + "\t运算未完成!");   
                return eval(a + how + b);   
    }   
}  


//四舍五入
function numberToFixed(num,size){
	var fixNum = new Number(num*1+1).toFixed(size);//四舍五入之前加1  
	var fixedNum = new Number(fixNum - 1).toFixed(size);//四舍五入之后减1，再四舍五入一下  
	return fixedNum;//弹出的数字就是正确的四舍五入结果啦 
}

//大小写转换
function numberToChinese(n) {
    if (!/^(0|[1-9]\d*)(\.\d+)?$/.test(n))
        return "数据非法";
    var unit = "仟佰拾亿仟佰拾万仟佰拾元角分", str = "";
        n += "00";
    var p = n.indexOf('.');
    if (p >= 0)
        n = n.substring(0, p) + n.substr(p+1, 2);
        unit = unit.substr(unit.length - n.length);
    for (var i=0; i < n.length; i++)
        str += '零壹贰叁肆伍陆柒捌玖'.charAt(n.charAt(i)) + unit.charAt(i);
    return str.replace(/零(仟|佰|拾|角)/g, "零").replace(/(零)+/g, "零").replace(/零(万|亿|元)/g, "$1").replace(/(亿)万|壹(拾)/g, "$1$2").replace(/^元零?|零分/g, "").replace(/元$/g, "元整");
}
