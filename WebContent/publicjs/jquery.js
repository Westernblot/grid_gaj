/****************************************/
/**
 * Jquery公共库 V1.0
 * 作者:10yue
 * 创建时间：2012/10/25
 * 最后修改者:10yue
 */
/****************************************/

/**
 * 异步提交请求反回状态
 * 
 * @param url
 *            请求地址
 * @param form
 *            提交的form
 * @param message
 *            自定义错误消息
 */
function ajaxSubmit(url, form, message) {
	if (Validator.Validate(document.getElementById(form), 3)) {
		var options = {
			url : url,
			type : 'POST',
			dataType : 'text',

			success : function(text) {

				// 如果返回值为重复提示
				if (text == 'repeat') {
					alert("提示：" + message);
				}
				else if (text == "error") {
					// 如果反回值为错误提示
					alert("提示：" + message);
					// alert("提示：系统错误请联系管理员！");
				}
				else if (text == "NoReload") {
					window.location.href = "menuList";
				}
				else if (text == "Edit") {
					alert("修改成功!");
					window.location.href = "menuList";
				}
				else if (text == "sysInfo") {
					alert("提交成功!");
					window.location.href = "infoList";
				}
				else if (text == "sysList") {
					alert("提交成功!");
					window.location.href = "sysList";
				}
				else if (text == "pass") {
					alert("修改成功!请保护好您的密码!");
					window.location.href = "mainindex";
				}
				else if (text == "video") {
					alert("修改成功!");
					window.location.href = "videoList";
				}
				else {
					window.parent.location.reload();
					ownerDialog.close();
				}
			},
			error : function() {
				alert("提示：系统错误请联系管理员！");
			}
		};
		$("#" + form).ajaxSubmit(options);
	}
}

/**
 * 增加全选，反选功能
 * 
 * @param obj
 *            触发事件对像
 * @param name
 *            被选元素name值
 */
function selectAll(obj, name) {
	$('input[name=' + name + ']').attr("checked", obj.checked);
}

/**
 * 得到所有标签等于name属性等于name的值
 * 
 * @param name
 *            元素name
 * @returns 返回一个数组
 */
function getSelectValue(name) {
	var arr = new Array;
	var i = 0;
	$.each($("input[name=" + name + "]"), function(index, obj) {
		if (obj.checked == true) {
			arr[i] = obj.value;
			i++;
		}
	});
	return arr;
}

/**
 * 获取和失去焦点
 * 
 * @param target
 *            目标位置
 * @param render
 *            显示位置
 */
function getfocus(target, render) {
	$("#" + target).focus(function() {
		// 当焦点在target位置时，render位置显示
		$(this).addClass("focus");
		$("#" + render).show();
	}).blur(function() {
		// 当焦点离开target位置时，render位置隐藏
		$(this).removeClass("focus");
		$("#" + render).hide();
	});
};

/**
 * 
 * @param form
 *            页面form(方便传参)
 * @param url
 *            请求路径
 * @param target
 *            目标Select标签
 */
function selectAjaxInit(form, url, target) {
	var options = {
		url : url,
		type : 'POST',
		dataType : 'json',

		error : function() {
			alert("提示：系统错误请联系管理员！");
		},
		success : function(json) {
			$("#" + target).empty();
			$.each(json, function(st, v) {
				$("#" + target).append(
						"<option value=" + v.kspym + " nvalue=" + v.ksname + ">" + v.ksname + "</option>");
			});
			chvalue('keshi');
		}
	};
	$("#" + form).ajaxSubmit(options);
}

/**
 * 关闭窗口清除session
 * 
 * @param url
 *            路径
 */
function winclosed(url) {
	window.top.location.href = url;
	/*
	 * var options = { url:url, method:'GET', success:function(){
	 * window.parent.close(); }, error:function(){ alert("警告：系统错误请联系系统管理员！"); } };
	 * $.ajax(options);
	 */
}

/**
 * 跟据写出值更改选项
 * 
 * @param val
 *            当前元素值
 * @param obj
 *            要改变对像
 */
function inputToSel(val, obj) {
	$.each($("#" + obj).children(), function(index, option) {
		if ($(option).attr("title").match(val.toLocaleLowerCase())) {
			$(option).attr("selected", "selected");
			return false;
		}
	});
}

/**
 * 得到年龄
 * 
 * @param birthdayObj
 *            生日对象
 * @param ageObj
 *            年龄对象
 */
function getAge(birthday, ageObj) {
	if (birthday != "" && birthday != undefined) {
		var d = new Date();
		var year = d.getYear();
		var month = d.getMonth() + 1;
		var byear = birthday.substring(0, 4);
		var bmonth = birthday.substring(5, 7);
		$("#" + ageObj).val(Number(bmonth) <= month ? (year - byear) : (year - byear - 1));
	}
}

/**
 * 两级联动
 * 
 * @param targetObj
 *            选择项
 * @param changeObj
 *            联动项
 */
function twoLinkage(targetObj, changeObj) {
	var targetObjval = $("#" + targetObj).val();
	if ($("#" + changeObj).data("data") == undefined) {
		$("#" + changeObj).data("data", $("#" + changeObj + " option"));
	}
	var data = $("#" + changeObj).data("data");
	$("#" + changeObj).empty();
	$.each(data, function(index, obj) {
		var cvalue = $(obj).attr("cvalue").split(",");
		// 获取title值以便实现函数：inputToSel(val,obj)拼音码搜索成功
		var titlev = $(obj).attr("title").split(",");
		for ( var i = 0; i < cvalue.length; i++) {
			if (cvalue[i] == targetObjval | cvalue[i] == '0') {
				$("#" + changeObj).append(
						"<option value='" + obj.value + "' title='" + titlev[i] + "'>" + $(obj).text() + "</option>");
			}
		}
	});

	// 用setTimeout()函数设一个时间值，用来解决IE6无法设置selected属性的问题
	setTimeout(function() {
		$("#" + changeObj).children().eq(1).attr("selected", "selected");
	}, 1);
}

/**
 * 两级联动 (默认选择联动项的第一个)
 * 
 * @param targetObj
 *            选择项
 * @param changeObj
 *            联动项
 */
function twoLinkage2(targetObj, changeObj) {
	var targetObjval = $("#" + targetObj).val();
	if ($("#" + changeObj).data("data") == undefined) {
		$("#" + changeObj).data("data", $("#" + changeObj + " option"));
	}
	var data = $("#" + changeObj).data("data");
	$("#" + changeObj).empty();
	$.each(data, function(index, obj) {
		var cvalue = $(obj).attr("cvalue").split(",");
		var titlev = $(obj).attr("title").split(",");
		for ( var i = 0; i < cvalue.length; i++) {
			if (cvalue[i] == targetObjval | cvalue[i] == '0') {
				$("#" + changeObj).append(
						"<option value='" + obj.value + "'  title='" + titlev + "' >" + $(obj).text() + "</option>");
			}
		}
	});
}

/**
 * 两级联动 (默认选择联动项的第一个)
 * 
 * @param targetObj
 *            填写项
 * @param changeObj
 *            联动项
 */
function twoLinkage3(targetObj, changeObj) {
	var targetObjval = $("#" + targetObj).val().toLocaleLowerCase();

	if ($("#" + changeObj).data("data") == undefined) {
		$("#" + changeObj).data("data", $("#" + changeObj + " option"));
	}

	var data = $("#" + changeObj).data("data");
	$("#" + changeObj).empty();
	$.each(data, function(index, obj) {
		if ($(obj).attr("title").match(targetObjval)) {
			$("#" + changeObj).append(
					"<option value='" + obj.value + "'  title='" + obj.value + "' >" + $(obj).text() + "</option>");
		}
	});
}

/**
 * 进行自动补全，以及自动把后台传值进行自动注入相对应命名的input标签内
 * 
 * @param options
 *            url 请求路径 width 宽度 boldDis粗体显示字断 render 所须显示列 形如（a,b,c）
 *            a,b,c,分别代表列用，分隔
 */
function autocomplete(options, setFlag, boldDis) {
	// 是否使用缓存
	if (setFlag == undefined) {
		setFlag = true;
	}

	var scrollFlag = false;
	if (options.height != undefined) {
		scrollFlag = true;
	}

	$("#" + options.target).autocomplete(options.url, {
		width : options.width, // 宽度
		max : 100, // 显示最大条数
		cacheLength : 10, // 缓存大小，默认为10,不缓存设置为1
		scroll : scrollFlag, // 不允许滚动条
		scrollHeight : options.height,
		selectFirst : true, // 是否默认选择第1个
		highlight : false, // 是否高亮显示关键字
		dataType : "json", // 返回数据格式，默认为json
		matchSubset : setFlag, // 使用缓存数据
		extraParams : options.data,
		delay : 1, // 显示延迟数
		parse : function(data) { // 对数据时行解析
			return $.map(data, function(row) {
				return {
					data : row,
					value : function(options, row) {
						var result = "<table width=" + options.width + "><tr align='center'>";
						var renderArray = options.render.split(",");
						var wt = options.width / renderArray.length;
						var i = 0;
						var sz = renderArray.length;
						for (; i < sz; i++) {
							for ( var j in row) {
								if (j == renderArray[i]) {
									if (boldDis == renderArray[i]) {
										result += "<td width=" + wt + " style='font-weight:bold'>" + row[j] + "</td>";
									}
									else {
										result += "<td width=" + wt + ">" + row[j] + "</td>";
									}
								}
							}
						}
						result += "</tr></table>";
						return result;
					}(options, row)
				// 格式化值
				};
			});
		},
		formatItem : function(data, i, n, value) {
			return value;
		}
	}).result(function(event, data, obj) { // 选择后执行事件
		for (i in data) {
			// $.each($(":input"),function(index,obj){
			// if(i == obj.id){
			// obj.value = data[i];
			$("#" + i).val(data[i]);
			// }
			// });
		}
	});
}

/**
 * 进行自动补全，以及自动把后台传值进行自动注入相对应命名的input标签内
 * 
 * @param options
 *            url 请求路径 width 宽度 boldDis粗体显示字断 render 所须显示列 形如（a,b,c）
 *            a,b,c,分别代表列用，分隔
 */
function autocompleteyk(options, setFlag, boldDis) {
	// 是否使用缓存
	if (setFlag == undefined) {
		setFlag = true;
	}
	var scrollFlag = false;
	if (options.height != undefined) {
		scrollFlag = true;
	}
	$("#" + options.target).autocomplete(options.url, {
		width : options.width, // 宽度
		max : 100, // 显示最大条数
		cacheLength : 10, // 缓存大小，默认为10,不缓存设置为1
		scroll : scrollFlag, // 不允许滚动条
		scrollHeight : options.height,
		selectFirst : true, // 是否默认选择第1个
		highlight : false, // 是否高亮显示关键字
		dataType : "json", // 返回数据格式，默认为json
		matchSubset : setFlag, // 使用缓存数据
		extraParams : options.data,
		delay : 1, // 显示延迟数
		parse : function(data) { // 对数据时行解析
			return $.map(data, function(row) {
				return {
					data : row,
					value : function(options, row) {
						var result = "<table width=" + options.width + "><tr align='center'>";
						var renderArray = options.render.split(",");
						var wt = options.width / renderArray.length;
						var i = 0;
						var sz = renderArray.length;
						for (; i < sz; i++) {
							for ( var j in row) {
								if (j == renderArray[i]) {
									if (boldDis == renderArray[i]) {
										result += "<td width=" + wt + " style='font-weight:bold'>" + row[j] + "</td>";
									}
									else {
										result += "<td width=" + wt + ">" + row[j] + "</td>";
									}
								}
							}
						}
						result += "</tr></table>";
						return result;
					}(options, row)
				// 格式化值
				};
			});
		},
		formatItem : function(data, i, n, value) {
			return value;
		}
	}).result(function(event, data, obj) { // 选择后执行事件
		for (i in data) {
			// $.each($(":input"),function(index,obj){
			// if(i == obj.id){
			// obj.value = data[i];
			$("#" + i).val(data[i]);
			if (i == 'out_price') {
				if (data[i] != "" && data[i] != null) {
					$("#" + i).attr({
						readonly : 'readonly'
					});
				}
				else {
					$("#" + i).removeAttr("readonly");
				}
			}
			// }
			// });
		}
	});
}

/**
 * 进行自动补全，以及自动把后台传值进行自动注入相对应命名的input标签内
 * 
 * @param options
 *            url 请求路径 width 宽度 boldDis粗体显示字断 render 所须显示列 形如（a,b,c）
 *            a,b,c,分别代表列用，分隔
 */
function autocompletelsyz(options, setFlag, boldDis) {
	// 是否使用缓存
	if (setFlag == undefined) {
		setFlag = true;
	}
	$("#" + options.target).autocomplete(options.url, {
		width : options.width, // 宽度
		max : 100, // 显示最大条数
		cacheLength : 10, // 缓存大小，默认为10,不缓存设置为1
		scroll : true, // 不允许滚动条
		scrollHeight : 420,
		selectFirst : true, // 是否默认选择第1个
		highlight : false, // 是否高亮显示关键字
		dataType : "json", // 返回数据格式，默认为json
		matchSubset : setFlag, // 使用缓存数据
		delay : 1, // 显示延迟数
		parse : function(data) { // 对数据时行解析
			return $.map(data, function(row) {
				return {
					data : row,
					value : function(options, row) {
						var result = "<table width=" + options.width + "><tr align='center'>";
						var renderArray = options.render.split(",");
						var wt = options.width / renderArray.length;
						var i = 0;
						var sz = renderArray.length;
						for (; i < sz; i++) {
							for ( var j in row) {
								if (j == renderArray[i]) {
									if (boldDis == renderArray[i]) {
										result += "<td width=" + wt + " style='font-weight:bold'>" + row[j] + "</td>";
									}
									else {
										result += "<td width=" + wt + ">" + row[j] + "</td>";
									}
								}
							}
						}
						result += "</tr></table>";
						return result;
					}(options, row)
				// 格式化值
				};
			});
		},
		formatItem : function(data, i, n, value) {
			return value;
		}
	}).result(function(event, data, obj) { // 选择后执行事件
		for (i in data) {
			$("#" + i).val(data[i]);
			if (i == "ybmrate") {
				var bl = Number(data[i]) * 100;
				$("#ybxsmrate").val(bl);
			}
			if (i == "ybcode") {
				if (data[i] == null || data[i] == "0" || data[i] == "null") {
					alert("此项目或药品未比对，请比对后再使用！");
					$("#showyp input").val("");
					break;
				}
			}
		}
		if ($("#tabletype").val() != "合项") {
			var hzlx = $("#hzlx").val();
			if (hzlx != "普通患者") {
				if ($("#mzyy").val() == "是") {
					alert("此药品是门诊专用药，护士站没有权限使用此药");
					$("#showyp input").val("");
				}
			}
		}
	});
}

/**
 * 进行自动补全，以及自动把后台传值进行自动注入相对应命名的input标签内
 * 
 * @param options
 *            url 请求路径 width 宽度 boldDis粗体显示字断 render 所须显示列 形如（a,b,c）
 *            a,b,c,分别代表列用，分隔
 */
function autocomplete2(options, setFlag, boldDis) {
	// 是否使用缓存
	if (setFlag == undefined) {
		setFlag = true;
	}
	$("#" + options.target).autocomplete(options.url, {
		width : options.width, // 宽度
		max : 100, // 显示最大条数
		cacheLength : 0, // 缓存大小，默认为10,不缓存设置为1
		scroll : false, // 不允许滚动条
		selectFirst : true, // 是否默认选择第1个
		highlight : false, // 是否高亮显示关键字
		dataType : "json", // 返回数据格式，默认为json
		matchSubset : setFlag, // 使用缓存数据
		delay : 1, // 显示延迟数
		parse : function(data) { // 对数据时行解析
			return $.map(data, function(row) {
				return {
					data : row,
					value : function(options, row) {
						var result = "<table width=" + options.width + "><tr align='center'>";
						var renderArray = options.render.split(",");
						var wt = options.width / renderArray.length;
						var i = 0;
						var sz = renderArray.length;
						for (; i < sz; i++) {
							for ( var j in row) {
								if (j == renderArray[i]) {
									if (boldDis == renderArray[i]) {
										result += "<td width=" + wt + " style='font-weight:bold'>" + row[j] + "</td>";
									}
									else {
										result += "<td width=" + wt + ">" + row[j] + "</td>";
									}
								}
							}
						}
						result += "</tr></table>";
						return result;
					}(options, row)
				// 格式化值
				};
			});
		},
		formatItem : function(data, i, n, value) {
			return value;
		}
	}).result(function(event, data, obj) { // 选择后执行事件
		for (i in data) {
			// $.each($(":input"),function(index,obj){
			// if(i == obj.id){
			// obj.value = data[i];
			$("#" + i).val(data[i]);
			// }
			// });
		}
	});
}

/**
 * 表格添加行
 * 
 * @param arrayField
 *            需要在表格里显示的参数所组合的数组
 * @tableId 目标表id
 * @param addFunction(附加的功能函数)
 * @param fieldvalue：只有input
 *            里面的class值为fieldvalue时，才能获取input里的value值添加到表格里
 */
function addRow(arrayField, tableId, addFunction) {
	// 添加列表
	var sz = arrayField.length;
	var trResult = "<tr align='center'>";
	// 传递隐藏域
	$.each($(".fieldvalue"), function(index, obj) {
		trResult += "<input type='hidden' name='" + obj.name + "' value='" + obj.value + "'>";
	});
	// 表格显示内容
	for ( var i = 0; i < sz; i++) {
		$.each($(".fieldvalue"), function(index, obj) {
			if (obj.name == arrayField[i]) {
				trResult += "<td>" + obj.value + "</td>";
			}
		});
	}
	if (addFunction == undefined) {
		trResult += "<td><input type='button' class='button' value='删除' onclick='removeTr(this)'/></td></tr>";
	}
	else {
		trResult += "<td><input type='button' class='button' value='删除' onclick='removeTr(this);" + addFunction
				+ "'/></td></tr>";
	}
	$("#" + tableId).append(trResult);

}

/**
 * 移除行
 * 
 * @param obj
 */
function removeTr(obj) {
	$(obj).parent('td').parent('tr').remove();
	if (id != undefined) {
		id--;
	}
}

function removeTr2(obj) {
	$(obj).parent('td').parent('tr').remove();
}

// Ajax搜索，显示页面s
function insertDiv(options, setFlag) {
	$("#" + options.target).bind(options.type, function() {
		var idArr = options.keyword.split(',');
		var i = 0;
		var data = {};
		for (; i < idArr.length; i++) {
			if ($("#" + idArr[i]).val() == "") {
				return;
			}
			data["key" + i] = $("#" + idArr[i]).val();
		}

		// 设置缓存,默认为使用缓存
		if (setFlag == undefined) {
			setFlag == true;
		}
		$.ajax({
			type : "get",
			url : options.url,
			cache : setFlag,// 设置缓存
			data : data, // dataArr.substring(0,dataArr.length-1),

			success : function(data) {
				$("#" + options.showResult).html(data);
			}
		});
	});
}

// 没有绑定事件的Ajax搜索，显示页面
function insertDiv2(options, setFlag) {
	var idArr = options.keyword.split(',');
	var i = 0;
	var data = {};
	for (; i < idArr.length; i++) {
		if ($("#" + idArr[i]).val() == "") {
			return;
		}
		data["key" + i] = $("#" + idArr[i]).val();
	}
	// 设置缓存,默认为使用缓存
	if (setFlag == undefined) {
		setFlag == true;
	}
	$.ajax({
		type : "POST",
		url : options.url,
		cache : setFlag,// 设置缓存
		data : data,

		success : function(data) {
			$("#" + options.showResult).html(data);
		}
	});
}
/**
 * 框架提交验证
 * 
 * @param frmobj
 *            表单id
 * @param url
 *            链接地址
 * @param field
 *            控件的值
 * @param target
 *            设置焦点
 * @param txt
 *            提示信息
 */
function submitForm(frmobj, url, field, target, txt) {// 表单动态验证(添加)
	if (Validator.Validate(document.getElementById(frmobj), 3)) {
		var getName = document.getElementById(field).value;
		// alert("addIsExist2_" + tableName +"?tname="+tname);
		$.post(url, {
			name : getName
		}, function(data) {
			if (data == 0) {
				document.getElementById(frmobj).submit();
				refresh();
			}
			else {
				alert(txt);
				document.getElementById(target).focus();
			}
		});
	}
}

function xfind(url) {
	var val = $("#keyword").val();
	if (val != "" && val != " ") {
		var options = {
			url : url,
			type : 'POST',
			dataType : 'html',

			success : function(text) {
				$("#showsearch").html(text);
			},
			error : function() {
				alert("提示：系统错误请联系管理员！");
			}
		};
		$("#searchform").ajaxSubmit(options);
	}
}

// 没有绑定事件的Ajax搜索，显示页面
function del(msg, url) {
	if (confirm(msg)) {
		$.ajax({
			type : "get",
			url : url,
			dataType : 'text',

			success : function(data) {
				if (data != "删除成功！") {
					alert(data);
				}
				refresh();
			},
			error : function() {
				alert("提示：系统错误请联系管理员！");
			}
		});
	}
}

/**
 * 打印表格
 * 
 * @param targetId
 *            目标区域Id
 * @param tableId
 *            目标区域内的表格Id
 * @param lastCol
 *            需要移除表格最后一列的标志为true
 */
function getPrint(targetId, tableId, lastCol) {
	var obj = "#" + tableId + " tr";
	var rowlen = $(obj).length;// 获取行

	// 当行数大于1时，执行打印
	if (rowlen > 1) {
		// lastCol= true时，移除表格最后一列
		if (lastCol == true) {
			$(obj).eq(0).find("th").last().remove();
			for ( var i = 0; i < rowlen; i++) {
				$(obj).eq(i).find("td").last().remove();
			}
		}
		// 设置表格属性
		$("#" + tableId).removeClass();
		$("#" + tableId).attr("border", "1");
		// 打印的内容
		$("body").html($("#" + targetId).html());
		window.print();// 打印
		document.location.reload();
	}
	else {
		alert("没有可打印的数据！");
	}
}

function getPrint2(targetId, tableId, lastCol) {
	var obj = "#" + tableId + " tr";
	var rowlen = $(obj).length;// 获取行
	var colen = $(obj).find("th").length;// 获取列

	// 当行数大于1时，执行打印
	if (rowlen > 1) {
		// lastCol= true时，移除表格最后一列
		if (lastCol == true) {
			$(obj).eq(1).find("th").eq(colen - 1).remove();
			for ( var i = 0; i < rowlen; i++) {
				$(obj).eq(i).find("td").eq(colen - 1).remove();
			}
		}
		// 设置表格属性
		$("#" + tableId).removeClass();
		$("#" + tableId).attr("border", "1");
		// 打印的内容
		$("body").html($("#" + targetId).html());
		window.print();// 打印
	}
	else {
		alert("没有可打印的数据！");
	}
}

// 根据截至日期获取报警日期(报警日期比截至日期的提前6个月)
function getcalldate(obj1, obj2) {
	var enddate = $("#" + obj1).val();
	var date = enddate.split("-");
	var calldate = $("#" + obj2).val();
	if (Number(date[1]) > 6) {
		date[1] = Number(date[1]) - 6;
		calldate = date[0] + "-0" + date[1] + "-" + date[2];
		$("#" + obj2).val(calldate);
	}
	if (Number(date[1]) <= 6) {
		if (Number(date[1]) == 6) {
			date[1] = 12;
			date[0] = Number(date[0]) - 1;
			calldate = date[0] + "-" + date[1] + "-" + date[2];
		}
		if (Number(date[1]) == 5) {
			date[1] = 11;
			date[0] = Number(date[0]) - 1;
			calldate = date[0] + "-" + date[1] + "-" + date[2];
		}
		if (Number(date[1]) == 4) {
			date[1] = 10;
			date[0] = Number(date[0]) - 1;
			calldate = date[0] + "-" + date[1] + "-" + date[2];
		}
		if (Number(date[1]) == 3) {
			date[1] = 9;
			date[0] = Number(date[0]) - 1;
			calldate = date[0] + "-0" + date[1] + "-" + date[2];
		}
		if (Number(date[1]) == 2) {
			date[1] = 8;
			date[0] = Number(date[0]) - 1;
			calldate = date[0] + "-0" + date[1] + "-" + date[2];
		}
		if (Number(date[1]) == 1) {
			date[1] = 7;
			date[0] = Number(date[0]) - 1;
			calldate = date[0] + "-0" + date[1] + "-" + date[2];
		}
		$("#" + obj2).val(calldate);
	}
}

//-----------------cooike操作-----------------------------
function saveUser() {
	var username = $("#username").val();
	
	if (!isEmptyValue(username)) {
		//设置cooike,保存30天
		$.cookie('ucooike', username, {
			expires: 30
		});
	}
}

function saveSupp() {
	var username = $("#username").val();
	
	if (!isEmptyValue(username)) {
		//设置cooike,保存30天
		$.cookie('suppcooike', username, {
			expires: 30
		});
	}
}

function readUser(){
	var ucooike = $.cookie('ucooike');
	$("#username").val(ucooike);
	
	if (!isEmptyValue(ucooike)) {
		$("#save_user").attr("checked","checked");
	}
}

function readSupp(){
	var suppcooike = $.cookie('suppcooike');
	$("#username").val(suppcooike);
	
	if (!isEmptyValue(suppcooike)) {
		$("#save_user").attr("checked","checked");
	}
}
