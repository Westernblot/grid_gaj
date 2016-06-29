<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>黄石市公安局治安户政支队</title>
<link href="css/ZAstyle.css" rel="stylesheet" type="text/css" />
<link href="css/ZAny.css" rel="stylesheet" type="text/css" />
<jsp:include page="../include.jsp"></jsp:include>
<script type="text/javascript" src="js/jquery.js"></script>
<script src="js/time.js" type="text/javascript"></script>
<script type="text/javascript">

function doLogin(){
	
	var checked = checkForm('#form1');
	if(checked==false){
		return;
	}
	
	var data = PublicAjax('userLogin', $('#form1').serialize());
		if (data > 0) {
			location.href = 'home';
		} else {
			alert("账户或密码错误");
		}

}
</script>
</head>

<body>
<div id="container">
  
      
      <!-- 底部-->
      <%@ include file="../website/public/head.jsp"%> 
    
  
  
 <div id="content">
  	 	<div class="web-login">  
        	<div style="text-align:left;height:35px;line-height:35px;color: red; font-size:16px; font-weight:bold; text-indent:1em; border-bottom:1px solid #FFF;">用户登录</div>
        	<form action="" id="form1">
        	<table border="0" cellspacing="0" cellpadding="0" style="margin:0 20px;">
			<tbody>
            <tr>
              <td align="right">账　号：</td>
              <td style="padding-top:13px;"><input name="fUname" id="fUname" type="text" value=""></td>
            </tr>
            <tr>
              <td align="right" style="padding-top:13px;">密　码：</td>
              <td style="padding-top:13px;"><input name="fPassword" id="fPassword" type="password" value=""></td>
            </tr>
            <tr>
              <td colspan="2" align="center" style="padding-top:16px;">
              <input type="button" name="but" class="button" value="登 录" onclick="doLogin()" />
			  </td>
              </tr>
          </tbody>
          </table>
        	</form>
      	</div>      
   </div>

  
   <!-- 底部-->
      <%@ include file="../website/public/foot.jsp"%> 
</div>
<div id="bgblock"></div>
 <script type="text/javascript" src="js/scrolltop.js"></script>
</body>

</html>