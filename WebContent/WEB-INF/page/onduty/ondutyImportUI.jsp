<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>..</title>
<jsp:include page="../include.jsp"></jsp:include>
<link href="css/default.css" rel="stylesheet" type="text/css" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/goaler.js"></script>
<script type="text/javascript" src="<%=basePath%>publicjs/ajaxfileupload.js"></script>

<script type="text/javascript">


//保存  AND 编辑
function doSave(){
	
	var checked = checkForm('#form1');
	if(checked==false){
		return;
	}
	
	
	
	if('${onduty.fId}'==''){
		
     	//判断月份是否添加重复
	   var time=new Date().getTime();
	   var fMonth=$('#fMonth').val();
	   var data=PublicAjax('mOndutyCheckMonth.do?time='+time,{'fMonth':fMonth});
	   if(data>0){
		   alert('当前月份值班表已添加，请勿重复操作!');
		   return ;
	    }
	}
	
	var url=$('#form1').attr('action');
	var res=PublicAjax(url,$('#form1').serialize());
	if(res>0){
		alert('操作成功!');
		location.href="mOndutyMain.do";
	}
	
	//向LED屏幕写命令
	$.post("sendLedMsg.do");
}




//=========================附件上传=================================

//值班数据导入
function doImport(){
	
	var fMonth=$('#fMonth').val();
	if(fMonth==''){
		alert('月份必填！');
		return ;
	}
	
	//判断月份是否添加重复
	   var time=new Date().getTime();
	   var data=PublicAjax('mOndutyCheckMonth.do?time='+time,{'fMonth':fMonth});
	   if(data>0){
		   alert('当前月份值班表已添加，请勿重复操作!');
		   return ;
	    }
	
	
	$.ajaxFileUpload
    (
        {
            url: 'mOndutyImportExcel.do', //用于文件上传的服务器端请求地址
            type: 'post',
            data: { 'fMonth': fMonth }, //此参数非常严谨，写错一个引号都不行
            secureuri: false, //一般设置为false
            fileElementId: 'file', //文件上传空间的id属性  <input type="file" id="file" name="file" />
            dataType: 'json', //返回值类型 一般设置为json
            success: function (data, status)  //服务器成功响应处理函数
            {
            
            	var flag=data.flag;
            	
            	if(flag>0){
            		alert('导入成功!');
            		location.href="mOndutyMain.do";
            		
            		//向LED屏幕写命令
            		$.post("sendLedMsg.do");
            		
            	}else{
            		alert('导入失败!');
            	}
            	
            },
            error: function (data, status, e)//服务器响应失败处理函数
            {
                //alert(e);
                alert('访问失败!');
            }
        }
    );
	
	
	
}

</script>
</head>
<body style="overflow: auto;">
<div id="div_right">
	<div class="right_top">
					<span>支队月份值班表</span>
				</div>
				<div class="title">
				<%--
					<a href="javascript:doSave()"  class="btn btn-green">保存</a> 
				 --%>
					<a href="javascript:self.location=document.referrer;" class="btn btn-default" >返回</a>
				</div>
				
		<div class="develop">
		<form action=""  id="form1">
		
		   <table width="100%" border="0" class="mtable" >
		   <caption>
		   月份：<input type="text" id="fMonth" name="fMonth" value="" class="Wdate"  onclick="WdatePicker({dateFmt:'yyyy-MM'})">
		<font color="red">*</font>
		   </caption>
		   <tr>
		   <td align="right">Excel附件：</td>
		   <td><input type="file" name="file" id="file"></td>
		   </tr>
		   
		   <tr>
		   <td align="right">说明：</td>
		   <td>
		   <font color="red">导入附件为.xls的文件，标题头为：《月号；带班领导；值班人员》。</font>
		   <a href="tpl/excel001.xls" >导入模板下载</a>
		   </td>
		   </tr>
		   
		   <tr>
		   <td ></td>
		   <td><input type="button" value="导入数据"  onclick="doImport()" ></td>
		   </tr>
		   
		   
		   </table>
		</form>
		</div>
		
</div>
</body>
</html>