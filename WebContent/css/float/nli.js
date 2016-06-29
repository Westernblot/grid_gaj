var box=document.getElementById("nli_con"),can=true;
box.innerHTML+=box.innerHTML;
box.onmouseover=function(){can=false};
box.onmouseout=function(){can=true};
new function (){
	var stop=box.scrollTop%21==0&&!can;
	if(!stop)box.scrollTop==parseInt(box.scrollHeight/2)?box.scrollTop=0:box.scrollTop++;
	setTimeout(arguments.callee,box.scrollTop%21?10:4000);
};