
<script type="text/javascript">
	//翻页
	function goPage(pageNo) {
		var url = $('#formQuery').attr('action');
		$('#formQuery').attr('action', url + "?pageNo=" + pageNo);
		$('#formQuery').submit();
	}

	//页面跳转
	function gotoJump() {
		var jumpPage = $('#jumpPage').val();
		var totalPage = '${page.totalPage}';
		//alert(jumpPage+","+totalPage);
		if (parseInt(jumpPage) <= parseInt(totalPage) && parseInt(jumpPage) > 0) {
			goPage(jumpPage);
		} else {
			alert('页码输入有误！');
		}
	}
</script>

<div id="div_page" class="page_btm">
   &nbsp;
	  ${page.pageNo }/${page.totalPage }页 
	  <a href="javascript:goPage(1);"  title="首页"><img align="absmiddle" src="images/sys/first_btn.png" /></a>
	  <a href="javascript:goPage(${page.pageNo>1?page.pageNo-1:1 });"  title="上一页"><img align="absmiddle" src="images/sys/prev_btn.png" /></a>
	  <a href="javascript:goPage(${page.pageNo<page.totalPage?page.pageNo+1:(page.totalPage==0?1:page.totalPage) });"  title="下一页"><img align="absmiddle" src="images/sys/next_btn.png" /></a>
	  <a href="javascript:goPage(${page.totalPage==0?1:page.totalPage });"  title="末页"><img align="absmiddle" src="images/sys/last_btn.png" /></a>
	     共 ${page.totalRecord }条 每页 ${page.pageSize}&nbsp;条&nbsp; 第&nbsp;
	 <input type="text" name="jumpPage" id="jumpPage" style="width: 30px; height: 15px;" onkeyup="this.value=this.value.replace(/[^\d]/g,'')" value="" onkeydown="if(event.keyCode==13)gotoViewPage('jump');" />&nbsp;页 
	 <img src="images/sys/go_to.png" onClick="gotoJump()" title='跳转' align="absmiddle" />
</div>


<!-- 
<div class='page_btm'>
     &nbsp;
      共${page.totalRecord }条记录，每页${page.pageSize}条，当前第${page.pageNo }/${page.totalPage }页
	<div style="float: right;">
	  <a href="javascript:goPage(1)" >第一页</a>|
	  <a href="javascript:goPage(${page.pageNo>1?page.pageNo-1:1 })" >上一页</a>|
	  <a href="javascript:goPage(${page.pageNo<page.totalPage?page.pageNo+1:(page.totalPage==0?1:page.totalPage)})" >下一页</a>|
	  <a href="javascript:goPage(${page.totalPage==0?1:page.totalPage})" >最末页</a>|
	    转到第<input type='text' name='jumpPage' id='jumpPage' style='width:30px;height:16px;' class='efViewTextBox' onkeyup="this.value=this.value.replace(/[^\d]/g,'')"/>&nbsp;页
	  <input type="button" onclick="gotoJump()" value="跳转"> 
	  &nbsp; 
	</div>
</div>
 -->
