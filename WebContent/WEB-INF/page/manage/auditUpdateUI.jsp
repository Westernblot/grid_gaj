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
<title>涉密审核修改</title>
<jsp:include page="../include.jsp"></jsp:include>
<link href="css/default.css" rel="stylesheet" type="text/css" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/goaler.js"></script>
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
	
	
	var fId='${news.fId}';
	if(fId!=''){
	    kindEditor.sync();
	    var fContent = $('#fContent').val();
		kindEditor.html(fContent);
	}
	
});

//一键排版
function quickformat(){
	$('span[data-name="quickformat"]:eq(0)').click();
}

//保存  AND 编辑
function doSave(){
	kindEditor.sync();
	
	//var fText=kindEditor.text();
	//$('#fPart').attr('value',fText);
	
	var checked = checkForm('#form1');
	if(checked==false){
		return;
	}

    var url=$('#form1').attr('action');
	var res=PublicAjax(url,$('#form1').serialize());
	if(res>0){
		alert('操作成功!');
		location.href="mNotAuditMain.do";
	}
    
}

//===========================图片上传===================================
function doImg(obj){
	var td=$(obj).parent();
	 $("#form1").ajaxSubmit({
		url:'sUpload/loopNews',
		dataType:'json',
		type:'post',
		success:function(data){
			var fAttachment=data.fAttachment;
			var fAttachmentUrl=data.fAttachmentUrl;
			var html='<span><a href="sDownload?fileName='+fAttachment+'&fileURL='+fAttachmentUrl+'" id="attachment">'+fAttachment+'</a>'
		     +'<input type="hidden" id="fImg" name="fImg" value="'+fAttachment+'" />'
		     +'<input type="hidden" id="fImgUrl" name="fImgUrl" value="'+fAttachmentUrl+'" />'
		     +'<a href="javascript:#" id="del" onclick="delDiv(this)"><img src="images/remove.png" /></a></span>'; 
	
		    $(td).find('#div_img').html(html);
			//$(td).find('#file').attr('value','');//清除file的内容
			resetFileInput($(td).find('#file'));
		},
		error:function(){
			alertMsg(2,'系统错误！');
		}
	}); 
}

//=========================附件上传=================================

function doUpload(obj){
	var td=$(obj).parent();
	 $("#form1").ajaxSubmit({
		url:'sUpload/news',
		dataType:'json',
		type:'post',
		success:function(data){
			var fAttachment=data.fAttachment;
			var fAttachmentUrl=data.fAttachmentUrl;
			var html='<span><a href="sDownload?fileName='+fAttachment+'&fileURL='+fAttachmentUrl+'" id="attachment">'+fAttachment+'</a>'
		     +'<input type="hidden" id="fAttachment" name="fAttachment" value="'+fAttachment+'" />'
		     +'<input type="hidden" id="fAttachmentUrl" name="fAttachmentUrl" value="'+fAttachmentUrl+'" />'
		     +'<a href="javascript:#" id="del" onclick="delDiv(this)"><img src="images/remove.png" /></a></span>'; 
	
		    $(td).find('#div_attachment').append(html);
			//$(td).find('#file').attr('value','');//清除file的内容
			resetFileInput($(td).find('#file'));
		},
		error:function(){
			alertMsg(2,'系统错误！');
		}
	}); 
}

//清除file的内容
function resetFileInput(file){   
    file.after(file.clone().val(""));   
    file.remove();   
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
					<span>涉密审核修改</span>
				</div>
				<div class="title"> 
					<a href="javascript:doSave()"  class="btn btn-green">审核通过</a> 
					<a href="javascript:history.back()" class="btn btn-default" >返回</a>
				</div>
				
		<div class="develop">
		<form action="${news==null?'mNewsInsert.do':'mNewsUpdate.do'}"  id="form1">
		   <input type="hidden" id="fId" name="fId" value="${news.fId}">
		   <input type="hidden" id="fStatus" name="fStatus" value="审核通过">
		   
		   <table width="100%" border="0" class="mtable" >
		   <tr>
		   <td align="right" width="15%">主标题：</td>
		   <td colspan="3" >
		   <input type="text" size="80" id="fSubject" name="fSubject" value="${news.fSubject }" want="yes" title="主标题" >
		   <font color="red">*</font>
		   </td>
		   </tr>
		   <tr>
		   <td align="right" width="15%">副标题：</td>
		   <td colspan="3" >
		   <input type="text" size="100" id="fSubhead" name="fSubhead" value="${news.fSubhead }" >
		   </td>
		   </tr>
		   <tr>
		   <td align="right" width="15%">排序号：</td>
		   <td width="35%">
		   <input type="text" id="fSort" name="fSort" value="${news.fSort }" want="yes" title="排序号" >

		   </td>
		   <td align="right" width="15%">发布日期：</td>
		   <td width="35%">
		   <input type="text" id="fDate" name="fDate" class="Wdate" value="${news==null?nowDate:news.fDate }" want="yes" title="发布日期" onclick="WdatePicker()" >
		   <font color="red">*</font>
		   </td>
		   </tr>
		   <tr>
		   <td align="right" >来源：</td>
		   <td >
		    <input type="text" id="fSource" name="fSource" value="${news.fSource}">
		   </td>
		   <td align="right" >查看范围：</td>
		   <td >
		    <select id="fScope" name="fScope">
		    <c:forEach items="${scopeList }" var="scope">
	<option value="${scope.fName }" <c:if test="${news.fScope==scope.fName}">selected</c:if> >${scope.fName }</option>
		    </c:forEach>
		     
		    </select>
		   </td>
		   </tr>
		  <c:if test="${fn:contains('轮播图新闻,最近新闻,通知公告,重要文件,办公室,政治部,反贪局,反渎局,指挥中心,侦监处,公诉处,民行处,监所处,控申处,案管办,预防处,研究室,技术处,法警支队,监察处,行装处,人监办,机关党委,老干办',news.fGroup)}">
		   <tr>
		   <td align="right" width="15%">选项：</td>
		   <td colspan="3" >
		   <input type="checkbox" id="fAttention" name="fAttention" value="是" <c:if test="${news.fAttention=='是'}">checked</c:if> ><label for='fAttention'>今日关注</label>
		   <input type="checkbox" id="fImportant" name="fImportant" value="是" <c:if test="${news.fImportant=='是'}">checked</c:if> ><label for='fImportant'>要闻排行</label>
		   <input type="checkbox" id="fRecommend" name="fRecommend" value="是" <c:if test="${news.fRecommend=='是'}">checked</c:if> ><label for='fRecommend'>编辑推荐</label>
		   </td>
		   </tr>
		   </c:if>
		   <tr>
		   <td align="right" width="15%">摘要：</td>
		   <td colspan="3" >
		   <textarea rows="3" cols="50" id="fSummary" name="fSummary">${news.fSummary}</textarea>
		   </td>
		   </tr>
		   <tr>
		   <td align="right">内容：</td>
		   <td colspan="3">
		   <textarea id="fContent" name="fContent" style="width: 100%; height:300px;visibility: hidden;"> ${news.fContent}</textarea>
		   <br>
		  
		   
		   </td>
		   </tr>
		   <c:if test="${news.fGroup=='轮播图新闻'}">
		   <tr>
		   <td align="right">
		        轮播图片：
		   </td>
		   <td colspan="3">
		   <input type="file" id="file" name="file" value="" onchange="doImg(this)"> 
		    <div id="div_img">
		     <!-- 如果有轮播就显示 -->
		     <c:if test="${news.fImg!=null and news.fImg !=''}">
		     <span>
		       <a href="sDownload?fileName=${news.fImg}&fileURL=${news.fImgUrl}" id="img">${news.fImg}</a>
		       <input type="hidden" id="fImg" name="fImg" value="${news.fImg}" want="yes" title="轮播图" />
		       <input type="hidden" id="fImgUrl" name="fImgUrl" value="${news.fImgUrl}" />
		       <a href="javascript:#" id="del" onclick="delDiv(this)"><img src="images/remove.png" /></a>
		     </span>
		     </c:if>
		    </div>
		   </td>
		   </tr>
		    </c:if>
		   <c:if test="${news.fGroup!='轮播图新闻'}">
		   <tr>
		   <td align="right">附件：</td>
		   <td colspan="3">
		   <input type="file" id="file" name="file" value="" onchange="doUpload(this)"> 
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
		   </c:if>
		   </table>
		   <!-- 截取部分文章摘要 -->
		   <input type="hidden" id="fPart" name="fPart" value="" />
		</form>
		</div>
		
</div>
</body>
</html>