function PrintPage(){
	this.Title="";//文件标题
	this.SubTitleLeft="";//副标题左
	this.SubTitleRight="";//副标题右
	this.MainBody="";//主体部分
	this.PageTailLeft="";//页尾左
	this.PageTailRight="";//页尾右
	this.printAchieve=function(){
		var tabHeader="<tr><td align=\"center\" colspan=\"2\"><font size='5' face='楷体_gb2312'>"+this.Title+"</font></td></tr>";
				tabHeader+="<tr><td align=\"left\"  height=\"30\">"+this.SubTitleLeft+"</td></tr>";
				tabHeader+="<tr><td align=\"right\"  height=\"30\">"+this.SubTitleRight+"<!--ct--></td></tr>";//打印需要的文件头
		var tabDetail=this.MainBody+"<tr></tr>";//打印页面的主体内容
		var tabFooter="<tr height=\"0\" background=\"red\"><td align=\"left\">"+this.PageTailLeft+"</td><td align=\"right\">"+this.PageTailRight+"</td></tr>";
		$("<form id=\"printform1\" name=\"printform1\" action=\""+$("base").attr("href")+"PrintPage\" target=\"_blank\" method=\"post\" style=\"display:none;\">"+
				"<input name=\"title\" type=\"hidden\" value=\"\">"+
				"<input name=\"tabHeader\" type=\"hidden\" value=\"\">"+
				"<input name=\"tabDetail\"> type=\"hidden\" value=\"\""+
				"<input name=\"tabFooter\" type=\"hidden\" value=\"\">"+
				"</form>").appendTo("body");
		$("input[name='title']").attr("value",this.Title);
		$("input[name='tabHeader']").attr("value",tabHeader);
		$("input[name='tabDetail']").attr("value",tabDetail);
		$("input[name='tabFooter']").attr("value",tabFooter);
		$("#printform1").submit();
		$("#printform1").remove();
	};
}


