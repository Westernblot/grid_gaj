/**
 * 全局快捷键事件监听
 */
var mapKey=new Map();//所有键盘字符的CODE码
//这个是主键盘区域的数字
//mapKey.put("0","48");mapKey.put("1","49");mapKey.put("2","50");mapKey.put("3","51");mapKey.put("4","52");mapKey.put("5","53");mapKey.put("6","54");
//mapKey.put("7","55");mapKey.put("8","56");mapKey.put("9","57");
//26个字母
mapKey.put("a","65");mapKey.put("b","66");mapKey.put("c","67");mapKey.put("d","68");mapKey.put("e","69");mapKey.put("f","70");mapKey.put("g","71");
mapKey.put("h","72");mapKey.put("i","73");mapKey.put("j","74");mapKey.put("k","75");mapKey.put("l","76");mapKey.put("m","77");mapKey.put("n","78");
mapKey.put("o","79");mapKey.put("p","80");mapKey.put("q","81");mapKey.put("r","82");mapKey.put("s","83");mapKey.put("t","84");mapKey.put("u","85");
mapKey.put("v","86");mapKey.put("w","87");mapKey.put("x","88");mapKey.put("y","89");mapKey.put("z","90");
//小键盘的数字
mapKey.put("0","96");mapKey.put("1","97");mapKey.put("2","98");mapKey.put("3","99");mapKey.put("4","100");mapKey.put("5","101");mapKey.put("6","102");
mapKey.put("7","103");mapKey.put("8","104");mapKey.put("9","105");
//F功能键
mapKey.put("f1","112");mapKey.put("f2","113");mapKey.put("f3","114");mapKey.put("f4","115");mapKey.put("f5","116");mapKey.put("f6","117");
mapKey.put("f7","118");mapKey.put("f8","119");mapKey.put("f9","120");mapKey.put("f10","121");mapKey.put("f11","122");mapKey.put("f12","123");
//其他特殊字符（小键盘）
mapKey.put("*","106");mapKey.put("+","107");mapKey.put("enter","108");mapKey.put("-","109");mapKey.put(".","110");mapKey.put("/","111");
//控制符
mapKey.put("backspace","8");mapKey.put("tab","9");mapKey.put("clear","12");mapKey.put("enter","13");mapKey.put("shift","16");mapKey.put("ctrl","17");
mapKey.put("alt","18");mapKey.put("capslock","20");mapKey.put("esc","27");mapKey.put("space","32");mapKey.put("pageup","33");
mapKey.put("pagedown","34");mapKey.put("end","35");mapKey.put("home","36");mapKey.put("left","37");mapKey.put("up","38");
mapKey.put("right","39");mapKey.put("down","40");mapKey.put("insert","45");mapKey.put("delete","46");mapKey.put("numlocak","144");
mapKey.put("scrolllock","145");mapKey.put("pausebreak","19");mapKey.put("[{","219");mapKey.put("]}","221");mapKey.put(":;","186");
mapKey.put("\"'","222");mapKey.put("|\\","220");mapKey.put("<,","188");mapKey.put(">.","190");mapKey.put("?/","191");
mapKey.put("`","192");mapKey.put("win","92");mapKey.put("menu","93");
var keyListen=new Map();
var tempMap=new Map();
var defaults={
		key:"",
		keyseq:0,
		keyfun:""
};
function semiauto(opts){
	var options=$.extend({},defaults,opts);
	//获取肯定是keyListen.get(event.keyCode+"");这样子，那么我第一层封装肯定是一键盘CODE码进行
	//第二层，则是以keyseq为基准封装。当我键盘按下某个键得到CODE后即可获取到第二层封装中的对应键所有的绑定函数
	//那么我需要执行的顺序则就是以keyseq来进行。然后执行完成后删除对应方法。0属于页面全局，就不删除了
	if(keyListen.get(mapKey.get(options.key.replace(/\s+/g,"").toLowerCase()+""))==null){//当按键还没有绑定过任何事件
		var funMap=new Map();//新建一个Map对象
		funMap.put(options.keyseq,options.keyfun);
		keyListen.put(mapKey.get(options.key.replace(/\s+/g,"").toLowerCase())+"",funMap);
	}else{//此按键已经绑定过事件了
		tempMap=new Map();
		tempMap=keyListen.get(mapKey.get(options.key.replace(/\s+/g,"").toLowerCase())+"");//获取到相应的事件
		tempMap.put(options.keyseq,options.keyfun);//添加一个新的事件
		keyListen.remove(mapKey.get(options.key.replace(/\s+/g,"").toLowerCase())+"");//删除掉原事件
		keyListen.put(mapKey.get(options.key.replace(/\s+/g,"").toLowerCase())+"",tempMap);//把新的写进去
	}
}

$(document).live("keydown",function(){//遍历map，然后我还需要把键排个序。取最大的执行，然后删除，然后重新封装。
	var fun=keyListen.get(event.keyCode+"");//根据按键获取到了相应的事件了
	//-------------------判断fun是否存在-------------------
	if(fun==null || fun==""){ 
		return;
	}
	//-----------------------以上修改----------------------
	var max=0;
	var keys=fun.keys().split(",");
	for(var i=0;i<keys.length;i++){
		if(max*1<keys[i]*1){
			max=keys[i];
		}
	}
	eval(fun.get(max*1));
	if(max*1>0){
		fun.remove(max*1);
		keyListen.remove(event.keyCode+"");
		keyListen.put(event.keyCode+"",fun);
	}
});
