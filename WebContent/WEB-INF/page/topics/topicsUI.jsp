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
var kindEditor;
$(document).ready(function(){
	
	kindEditor = KindEditor.create('#fContent', {
		themeType : 'simple',
		allowPreviewEmoticons : false,
		allowFileManager : false,
		allowImageUpload : true,
		uploadJson : 'manage/upload',
		urlType: 'relative',
		items : [
			'source', 'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
			'removeformat', 'strikethrough', 'lineheight', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
			'insertunorderedlist', '|', 'emoticons', 'image', 'table', 'hr', 'link', '|', 'wordpaste', 'quickformat', 'fullscreen']
	});
	
	/* var fId='${news.fId}';
	if(fId!=''){
	    kindEditor.sync();
	    var fContent = $('#fContent').val();
		kindEditor.html(fContent);
	} */
	
});

//一键排版
function quickformat(){
	$('span[data-name="quickformat"]:eq(0)').click();
}


//保存  AND 编辑
function doSave(){
	kindEditor.sync();
	
	var checked = checkForm('#form1');
	if(checked==false){
		return;
	}

	var fType='${fType}';
    var url=$('#form1').attr('action');
	var res=PublicAjax(url,$('#form1').serialize());
	if(res>0){
		alert('操作成功!');
		location.href="mTopicsMain.do?fType="+fType;
	}
}



//=========================附件上传=================================

function doUpload(){
	
	$.ajaxFileUpload
    (
        {
            url: 'sUpload/topicsNews', //用于文件上传的服务器端请求地址
            type: 'post',
            data: { Id: '123', name: 'lunis' }, //此参数非常严谨，写错一个引号都不行
            secureuri: false, //一般设置为false
            fileElementId: 'file', //文件上传空间的id属性  <input type="file" id="file" name="file" />
            dataType: 'json', //返回值类型 一般设置为json
            success: function (data, status)  //服务器成功响应处理函数
            {
            
            	var fAttachment=data.fAttachment;
    			var fAttachmentUrl=data.fAttachmentUrl;
    			var html='<span><a href="sDownload?fileName='+fAttachment+'&fileURL='+fAttachmentUrl+'" id="attachment">'+fAttachment+'</a>'
    		     +'<input type="hidden" id="fAttachment" name="fAttachment" value="'+fAttachment+'" />'
    		     +'<input type="hidden" id="fAttachmentUrl" name="fAttachmentUrl" value="'+fAttachmentUrl+'" />'
    		     +'<a href="javascript:#" id="del" onclick="delDiv(this)"><img src="images/remove.png" /></a></span>'; 
    	
    		    $('#div_attachment').append(html);
            },
            error: function (data, status, e)//服务器响应失败处理函数
            {
                alert(e);
            }
        }
    );
	
}


//删除附件
function delDiv(obj){
	$(obj).parent().remove();
}

</script>
</head>
<body style="overflow: auto;">
<div id="div_right">
	<div class="right_top">
					<span>专题文章</span>
				</div>
				<div class="title">
					<a href="javascript:doSave()"  class="btn btn-green">保存</a> 
					<a href="javascript:self.location=document.referrer;" class="btn btn-default" >返回</a>
				</div>
				
		<div class="develop">
		<form action="${news==null?'mNewsInsert.do':'mNewsUpdate.do'}"  id="form1">
		   <input type="hidden" id="fId" name="fId" value="${news.fId}">
		   <input type="hidden" id="fStatus" name="fStatus" value="未审核">
		   
		   <table width="100%" border="0" class="mtable" >
		   <tr>
		   <td align="right" width="15%">专题栏目：</td>
		   <td colspan="3" >
		   <select id="fGroup" name="fGroup"> 
		   <c:forEach items="${groupList }" var="group">
		  
		   <option value="${group.fName }"    <c:if test="${news.fGroup==group.fName }">selected</c:if>   >${group.fName }</option>
		   </c:forEach>
		   </select>
		   <font color="red">*</font>
		   </td>
		   </tr>
		   <tr>
		   <td align="right" width="15%">主标题：</td>
		   <td colspan="3" >
		   <input type="text" size="80" id="fSubject" name="fSubject" value="${news.fSubject }" want="yes" title="主标题" >
		   <font color="red">*</font>
		   </td>
		   </tr>
		   <tr>
		   <td align="right" width="15%">来源：</td>
		   <td colspan="3" >
		    <input type="text" size="100" id="fSource" name="fSource" value="${news==null?'黄石市公安局治安户政支队':news.fSource }" >
		   </td>
		   </tr>
		   <tr>
		   <td align="right" width="15%">排序号：</td>
		   <td width="35%">
		   <input type="text" id="fSort" name="fSort" value="${news.fSort==null?maxNumber:news.fSort }" readOnly >
		   </td>
		   <td align="right" width="15%">发布日期：</td>
		   <td width="35%">
		   <input type="text" id="fDate" name="fDate" class="Wdate" value="${news==null?nowDate:news.fDate }" want="yes" title="发布日期" onclick="WdatePicker()" >
		   <font color="red">*</font>
		   </td>
		   </tr>
		  
		   <tr>
		   <td align="right" width="15%">摘要：</td>
		   <td colspan="3" >
		   <textarea rows="3" cols="50" id="fSummary" name="fSummary">${news.fSummary}</textarea>
		   </td>
		   </tr>
		  
		   <tr>
		   <td align="right">
		      内容：
		      <%--
		    <br>  <input type="button" id="btn_pb" name="btn_pb"  value="一键排版" onclick="quickformat()" />
		       --%>
		      </td>
		   <td colspan="3">
		   <textarea id="fContent" name="fContent" style="width: 100%; height:300px;visibility: hidden;"> ${news.fContent}</textarea>
		   <br>
		   </td>
		   </tr>
		  
		  
		   <tr>
		   <td align="right">附件：</td>
		   <td colspan="3">
		   <input type="file" id="file" name="file" value="" onchange="doUpload()"> 
		    <div id="div_attachment">
		    <c:if test="${news.fAttachment!=null and news.fAttachment !=''}">
		    <c:forEach items="${news.fAttachmentUrl.split(',') }" var="url" varStatus="vs">
		       <span>
		       <a href="sDownload?fileName=${news.fAttachment.split(',')[vs.index] }&fileURL=${url}" id="attachment">${news.fAttachment.split(',')[vs.index] }</a>
		       <input type="hidden" id="fAttachment" name="fAttachment" value="${news.fAttachment.split(',')[vs.index] }" />
		       <input type="hidden" id="fAttachmentUrl" name="fAttachmentUrl" value="${url}" />
		       <a href="javascript:#" id="del" onclick="delDiv(this)"><img src="images/remove.png" /></a>
		       </span>
		    </c:forEach>
		    </c:if>
		    </div>
		   </td>
		   </tr>
		   
		   </table>
		</form>
		</div>
		
</div>
</body>
</html>