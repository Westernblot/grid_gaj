<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>后台管理系统</title>
<link href="css/frame.css" rel="stylesheet" type="text/css"/>
</head>
<body style=" background:url(images/sys/top_bg.png) repeat-x bottom #FFF;">
	<div id="div_top">
			<div class="top_left">后台管理系统</div>
			<div class="top_right">
				<div class="top_inner">
					<div class="curst">
						<span>当前用户：${sessionScope.user.fCname}</span>
					</div>
					<a href="mIndex.do" target="_parent"><img
						src="images/sys/house.png" />返回首页</a> <a href="mUpdatePasswordUI.do?fId=${sessionScope.user.fId}"
						target="mainFrame"><img src="images/sys/lock_unlock.png" />修改密码</a>
					<a onclick="if(	confirm('你确定退出系统吗？')){winclosed('logout_zygl');}"
						href="logout"  target="_parent"  ><img src="images/sys/television.png" />退出系统</a>
				</div>
			</div>
		</div>
</body>
</html>