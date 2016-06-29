<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<jsp:include page="../include.jsp"></jsp:include>
<link href="css/default.css" rel="stylesheet" type="text/css" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/goaler.js"></script>

<script type="text/javascript">


//发送短信
function sendMail(){
	
	    var phones=$('#phones').val();
	    var msg=$('#msg').val();
	    //alert(phones+"---"+msg);
	    
	    if(phones==''){
	    	alert("电话号码必填!");
	    	return;
	    }
	     
		var data=PublicAjax("sendMessagePhone.do", { "phones":phones, "msg": msg} );
		if(data>0){
			alert('发送成功!');
			location.reload();
		}else{
			alert("发送失败");
		}
	
}


</script>
</head>
<body style="overflow: auto;">
<div id="div_right">
	<div class="right_top">
					<span>发送短信</span>
				</div>
				<div class="title">
					
					
				</div>
				
		<div class="develop">
		<form action=""  id="form1">
		   <table width="100%" border="0" class="mtable" >
		   <tr>
		   
		   <td  width="50px">电话号码</td>
		   <td  >
		 <font color="red"> 提示：如需发送多个。请使用字母,号分隔。如13211110000,13499990000</font>
		  <br>
		   <textarea rows="3" cols="30" id="phones" name="phones"  ></textarea>
		   
		   </td>
		   
		   </tr>
		    
		   <tr id="tr_msg">
		   <td >短信内容</td>
		   <td >
		 <textarea rows="3" cols="30" id="msg" name="msg"></textarea>
		 
		<div align="center">
		 <a href="javascript:sendMail()" class="btn btn-bule" >发送</a>
		</div>
		   </td>
		   </tr>
		   
		 
		   </table>
		</form>
		</div>
		
		
</div>
</body>
</html>