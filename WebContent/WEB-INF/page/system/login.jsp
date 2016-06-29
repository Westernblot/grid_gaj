<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="renderer" content="webkit" /><!-- 开启360浏览器极速模式，其他浏览器未测试 -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户登陆</title>

<script type="text/javascript" src="<%=basePath%>js/jquery.js"></script>
<script type="text/javascript" src="<%=basePath%>publicjs/systemUtils.js"></script>
<link href="css/default.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/goaler.js"></script>
<style type="text/css">
 body{background:url(images/sys/log_bg.jpg) repeat; }
 .m_log{background:url(images/sys/log_tbg.jpg) top repeat-x #F9F9F9; border:1px solid #C8C8CA; margin:16% auto 0 auto; font-weight:bold; color:#5E5E5E;}
 .m_log input[type="text"],
 .m_log input[type="password"]{ width:90%;}
</style>
</head>
<script type="text/javascript">

$(function(){
	$('#account').focus();
});


function toPwd(obj) {
    $('#password').focus();	
}


function doLogin(){
	
	var checked = checkForm('#form1');
	if(checked==false){
		return;
	}
	
	$.ajax({
		url:'userLogin',
		data:$('#form1').serialize(),
		dataType:'json',
		type:'post',
		success:function(data){
			if(data>0){
			    location.href='mIndex.do';
			}else{
				alert("账户或密码错误");
			}
		},
		error:function(){
			alert("系统错误");
		}
	});
	
}

//系统使用说明
function doTip(){
	//var html=$('#div1').html();
	
	var url="web_useTip";
	window.showModalDialog(url);
	
	//window.open(url);
	
	/* var d = new $.msgbox({
		id: 'sys_alert_msg',
		type: 'confirm',
		showMin: false,
		showHide: false,
		time: 2000,
		title: "系统提示",
		zIndex: 10011,
		content: "11111",
		width: 280,
		height: 120
	});
	d.show(); */
	
 	/* var d = new jQuery.msgbox({
		id: 11,
		type: 'confirm',
		lock: true,
		showMin: false,
		showHide: false,
		zIndex: 10011,
		title: '系统提示',
		content: "hhdfdfdfdf",
		width: 280,
		height: 120,
		btns: [{name: '确定', fun: function(){}},{name: '取消',fun: function(){
				closeDialog(11);
			}}]
	});
	d.show();  */
}


</script>
<body>

<form action="" id="form1">
<table width="400" height="240" border="0"  class="m_log">
  <tr>
  <td height="40" style="font-size:14px;background:url(images/sys/user_silhouette.png) no-repeat 10px center;">　　用户登陆</td>
  </tr>
    <tr>
  <td align="center">
  <div style="display: none"><a href="javascript:doTip()"><font color="blue">[系统使用说明]</font></a></div>
  </td>
  </tr>
    <tr>
  <td align="center">
      <table width="80%" height="160" border="0" align="center">
        <tr>
      <td width="60"><span style="display:block;">用户名</span>　</td>
      <td><input type="text" id="fUname" name="fUname" want="yes" title="账号" onkeydown="if(event.keyCode==13)toPwd()" ></td>
      </tr>
      <tr>
      <td><span style="display:block;">密　码</span>　</td>
      <td><input type="password" id="fPassword" name="fPassword" want="yes" title="密码" onkeydown="if(event.keyCode==13)doLogin();" ></td>
      </tr>
      <tr>
      <td></td>
      <td>
          <input type="button"  name="submit" value="登陆" class="btn btn-red" onclick="doLogin()" >
          <input type="reset"  name="reset" value="重置" class="btn btn-default" >
      </td>
      </tr>
    </table>
  </td>
  </tr>  
</table>
</form>

</body>
</html>