/**
 *  网格软件公用tree
 *  GridTree JS v0.1 (2014-04-11)
 *  Copyright (c) 2014 湖北网格
 *
 */
(function($){
	var _theChooseId = null;
	var _theChooseName = null;
	$.fn.setGridTree = function(opts) {
		if (typeof(opts) === 'string') {
			var content = opts;
			opts = {content: content};
		}
		opts = opts || {};
		opts.width = opts.width || '200px';
		opts.height = opts.height || '200px';
		opts.fid = opts.fid || 'fId';
		opts.pid = opts.pid || 'fPid';
		opts.level = opts.level || 'fLevel';
		opts.fname = opts.fname || 'fName';
		opts.checkbox = opts.checkbox || false;
		opts.click = opts.click || null;
		opts.showdel = opts.showdel || false;
		opts.delaction = opts.delaction || null;
		opts.showall = opts.showall || false;
	
		var fid = opts.fid;//获取对象属性ID名
		var fname = opts.fname;//获取对象属性名
		var pid = opts.pid;//获取对象属性父级ID名
		var level = opts.level;
		var checkbox = opts.checkbox;
		var showdel = opts.showdel;
		var showall = opts.showall;
		var list = opts.data;
		
		var divTree = $('<div/>').attr('id', 'gridTree').css({
			'width': opts.width,
			'height': opts.height,
		});
		var rootList = new Array();
		for(var i=0; i<list.length; i++){//先显示根级
			if(list[i][level]*1 === 1){
				rootList.push(list[i]);
			}
		}

		var assembleSubDataHtml = function (ul, parentId, list){
			var subList = new Array();
			for(var i = 0; i<list.length; i++) {
				if (list[i][pid] === parentId) {// 如果当前部门的上级id=传入的id
					subList.push(list[i]);
				}
			}/**
 *  网格软件公用tree
 *  GridTree JS v0.1 (2014-04-11)
 *  Copyright (c) 2014 湖北网格
 *
 */
(function($){
	var _theChooseId = null;
	var _theChooseName = null;
	$.fn.setGridTree = function(opts) {
		if (typeof(opts) === 'string') {
			var content = opts;
			opts = {content: content};
		}
		opts = opts || {};
		opts.width = opts.width || '200px';
		opts.height = opts.height || '200px';
		opts.fid = opts.fid || 'fId';
		opts.pid = opts.pid || 'fPid';
		opts.level = opts.level || 'fLevel';
		opts.fname = opts.fname || 'fName';
		opts.checkbox = opts.checkbox || false;
		opts.click = opts.click || null;
		opts.showdel = opts.showdel || false;
		opts.delaction = opts.delaction || null;
		opts.showall = opts.showall || false;
	
		var fid = opts.fid;//获取对象属性ID名
		var fname = opts.fname;//获取对象属性名
		var pid = opts.pid;//获取对象属性父级ID名
		var level = opts.level;
		var checkbox = opts.checkbox;
		var showdel = opts.showdel;
		var showall = opts.showall;
		var list = opts.data;
		
		var divTree = $('<div/>').attr('id', 'gridTree').css({
			'width': opts.width,
			'height': opts.height,
		});
		var rootList = new Array();
		for(var i=0; i<list.length; i++){//先显示根级
			if(list[i][level]*1 === 1){
				rootList.push(list[i]);
			}
		}

		var assembleSubDataHtml = function (ul, parentId, list){
			var subList = new Array();
			for(var i = 0; i<list.length; i++) {
				if (list[i][pid] === parentId) {// 如果当前部门的上级id=传入的id
					subList.push(list[i]);
				}
			}
			var li = null;
			var liHtml = '';
			for(var j = 0; j<subList.length; j++) {
				if(showall){
					li = $('<li/>').attr('id', subList[j][fid]).attr('pid', subList[j][pid]).css({
						'display': 'block'
					});
					liHtml = '';
					for ( var m = 1; m < subList[j][level]; m++) {
						liHtml += '<img src="images/dtree/line.gif" style="vertical-align: middle;"/>';
					}
					var imgSrc = '';
					if(subList.length === 1)
						imgSrc = 'images/dtree/single_minus.gif';
					else if(j === subList.length)
						imgSrc = 'images/dtree/bottom_minus.gif';
					else
						imgSrc = 'images/dtree/minus.gif';
					liHtml += '<img name="img_tree" src="' + imgSrc + '" show="true" style="vertical-align: middle;"/>&nbsp;';
				} else {
					li = $('<li/>').attr('id', subList[j][fid]).attr('pid', subList[j][pid]).css({
						'display': 'none'
					});
					liHtml = '';
					for ( var m = 1; m < subList[j][level]; m++) {
						liHtml += '<img src="images/dtree/line.gif" style="vertical-align: middle;"/>';
					}
					var imgSrc = '';
					if(subList.length === 1)
						imgSrc = 'images/dtree/single_plus.gif';
					else if(j === subList.length)
						imgSrc = 'images/dtree/bottom_plus.gif';
					else
						imgSrc = 'images/dtree/plus.gif';
					liHtml += '<img name="img_tree" src="' + imgSrc + '" show="false" style="vertical-align: middle;"/>&nbsp;';
				}
				
				
				if(checkbox)
					liHtml += '<input  type="checkbox" name="treeChk" value="' + subList[j][fid] + '" pid="' + subList[j][pid] + '" style="vertical-align: middle;"/>&nbsp;';
				liHtml += '<a href="javascript:;" name="a_tree_name">' + subList[j][fname] + '</a>';
				if(showdel)
					liHtml += '&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:;" name="a_tree_del" dataid="' + subList[j][fid] + '" style="display:none;">删除</a>';
				li.html(liHtml);
				if ($(ul).find('#tree_'+parentId).length > 0) {
					$(ul).find('#tree_'+parentId).after(li);
				} else {
					$(ul).append(li);
				}
				assembleSubDataHtml(ul, subList[j][fid], list);
			}
		};
		
		var ul = $('<ul/>');
		var imgSrc = '';
		for(var i=0; i<rootList.length; i++){//先显示根级
			var li = $('<li/>').attr('id', rootList[i][fid]).attr('pid', rootList[i][pid]);
			var html = '';
			if(showall){
				if(rootList.length === 1)
					imgSrc = 'images/dtree/single_minus.gif';
				else if(i === 0)
					imgSrc = 'images/dtree/top_minus.gif';
				else if(i === (rootList.length - 1))
					imgSrc = 'images/dtree/bottom_minus.gif';
				else
					imgSrc = 'images/dtree/minus.gif';
				html = '<img name="img_tree" src="' + imgSrc + '" show="true" style="vertical-align: middle;"/>&nbsp;';
			} else {
				if(rootList.length === 1)
					imgSrc = 'images/dtree/single_plus.gif';
				else if(i === 0)
					imgSrc = 'images/dtree/top_plus.gif';
				else if(i === (rootList.length - 1))
					imgSrc = 'images/dtree/bottom_plus.gif';
				else
					imgSrc = 'images/dtree/plus.gif';
				html = '<img name="img_tree" src="' + imgSrc + '" show="false" style="vertical-align: middle;"/>&nbsp;';
			}
			
			if(checkbox){
				html += '<input type="checkbox" name="treeChk" value="' + rootList[i][fid] + '" pid="' + rootList[i][pid] + '" style="vertical-align: middle;"/>&nbsp';
			}
			html += '<a href="javascript:;" name="a_tree_name">' + rootList[i][fname] + '</a>';
			if(showdel)
				html += '&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:;" name="a_tree_del" dataid="' + rootList[i][fid] + '" style="display:none;">删除</a>';
			li.html(html);
			ul.append(li);
			assembleSubDataHtml(ul, rootList[i][fid], list);
		}
		/*
		 * 选中子孙级checkbox
		 */
		var checkSubTree = function(box){
			var id = $(box).attr('value');
			var dis = $(box).attr('checked');
			if (dis === 'checked') {
				dis = true;
			} else {
				dis = false;
			}
			var lis = $(ul).find('li');
			for(var m=0; m<lis.length; m++){
				if ($(lis[m]).attr('pid') === id) {
					$(lis[m]).find('input[name="treeChk"]').attr('checked', dis);
					checkSubTree($(lis[m]).find('input[name="treeChk"]'));
				}
			}
		};
		
		var checkParentTree = function(box){
			var pid = $(box).attr('pid');
			var dis = $(box).attr('checked');
			if (dis === 'checked') {
				dis = true;
			} else {
				dis = false;
			}
			var lis = $(ul).find('li');
			for(var m=0; m<lis.length; m++){
				if ($(lis[m]).attr('id') === pid) {
					$(lis[m]).find('input[name="treeChk"]').attr('checked', dis);
					checkParentTree($(lis[m]).find('input[name="treeChk"]'));
				}
			}
		};
		
		if(checkbox){
			var boxs = $(ul).find('input[name=treeChk]');
			for(var i=0; i<boxs.length; i++){
				$(boxs[i]).bind('click', function(){
					checkSubTree(this);
					checkParentTree(this);
				});
			}
		}
		/*
		 * 显示树的子级
		 */
		var showSubTree = function(img){
			var pid = $(img).parent().attr('id');
			var isShow = $(img).attr("show");
			if (isShow === 'false') {// 如果是+显示-
				var lis = $(ul).find('li');
				for(var m=0; m<lis.length; m++){
					if ($(lis[m]).attr('pid') === pid) {
						$(lis[m]).show();
					}
				}
				var imgStr = $(img).attr('src');
				imgStr = imgStr.replace('plus', 'minus');
				$(img).attr("src", imgStr);
				$(img).attr("show", "true");
			} else{// 如果是-显示+
				hideSubTree(img);
			}
		};
		/*
		 * 隐藏树的子孙级
		 */
		var hideSubTree = function(img){
			var pid =$(img).parent().attr('id');
			var lis = $(ul).find('li');
			for(var m=0; m<lis.length; m++){
				if($(lis[m]).attr('pid') === pid){
					$(lis[m]).hide();
					hideSubTree($(lis[m]).find('img[name=img_tree]'));
				}
			}
			var imgStr = $(img).attr('src');
			imgStr = imgStr.replace('minus', 'plus');
			$(img).attr("src", imgStr);
			$(img).attr("show", "false");
		};
		
		var imgs = $(ul).find('img[name=img_tree]');
		for(var i=0; i<imgs.length; i++){
			$(imgs[i]).bind('click', function(){
				showSubTree(this);
			});
		}
		/*
		 * 为li中的a标签绑定点击函数
		 */
		var as = $(ul).find('a[name="a_tree_name"]');
		for(var i=0; i<as.length; i++){
			$(as[i]).bind('click', function(){
				_theChooseId = $(this).parent().attr('id');
				_theChooseName = $(this).text();
				$(ul).find('a[name="a_tree_name"]').css('color', '');
				$(this).css('color', 'red');
				if(opts.click)
					opts.click();
			});
		}
		/*
		 * 为删除图片绑定删除函数
		 */
		if(opts.delaction){
			var as = $(ul).find('a[name="a_tree_del"]');
			for(var i=0; i<as.length; i++){
				$(as[i]).bind('click', function(e){
					opts.delaction(e);
				});
			}
			var lis = $(ul).find('li');
			for(var m=0; m<lis.length; m++){
				$(lis[m]).bind('mousemove', function(){
					$(this).find('a[name="a_tree_del"]').show();
				});
				$(lis[m]).bind('mouseout', function(){
					$(this).find('a[name="a_tree_del"]').hide();
				});
			}
		}
		
		ul.appendTo(divTree);
		divTree.appendTo(this);
	};
	
	/*
	 * 获得选中的id
	 */
	$.fn.getChooseId = function(){
		return _theChooseId;
	};
	
	/*
	 * 获得选中的name
	 */
	$.fn.getChooseName = function(){
		return _theChooseName;
	};
	
	/*
	 * 获得树中选中checkbox的id字符串，以,隔开
	 */
	$.fn.getTheBoxIds = function(){
		var ids = new Array();
		var chks = $(this).find('input[name=treeChk]:checked');
		for(var i=0; i<chks.length; i++){
			ids[i] = $(chks[i]).val();
		}
		return ids.join(',');
	};
	/*
	 * 获得树中选中checkbox的name字符串，以,隔开
	 */
	$.fn.getTheBoxNames = function(){
		var names = new Array();
		var chks = $(this).find('input[name=treeChk]:checked');
		for(var i=0; i<chks.length; i++){
			names[i] = $(chks[i]).parent().text();
		}
		return names.join(',');
	};
	
})(jQuery); 
			var li = null;
			var liHtml = '';
			for(var j = 0; j<subList.length; j++) {
				if(showall){
					li = $('<li/>').attr('id', subList[j][fid]).attr('pid', subList[j][pid]).css({
						'display': 'block'
					});
					liHtml = '';
					for ( var m = 1; m < subList[j][level]; m++) {
						liHtml += '<img src="images/dtree/line.gif" style="vertical-align: middle;"/>';
					}
					var imgSrc = '';
					if(subList.length === 1)
						imgSrc = 'images/dtree/single_minus.gif';
					else if(j === subList.length)
						imgSrc = 'images/dtree/bottom_minus.gif';
					else
						imgSrc = 'images/dtree/minus.gif';
					liHtml += '<img name="img_tree" src="' + imgSrc + '" show="true" style="vertical-align: middle;"/>&nbsp;';
				} else {
					li = $('<li/>').attr('id', subList[j][fid]).attr('pid', subList[j][pid]).css({
						'display': 'none'
					});
					liHtml = '';
					for ( var m = 1; m < subList[j][level]; m++) {
						liHtml += '<img src="images/dtree/line.gif" style="vertical-align: middle;"/>';
					}
					var imgSrc = '';
					if(subList.length === 1)
						imgSrc = 'images/dtree/single_plus.gif';
					else if(j === subList.length)
						imgSrc = 'images/dtree/bottom_plus.gif';
					else
						imgSrc = 'images/dtree/plus.gif';
					liHtml += '<img name="img_tree" src="' + imgSrc + '" show="false" style="vertical-align: middle;"/>&nbsp;';
				}
				
				
				if(checkbox)
					liHtml += '<input  type="checkbox" name="treeChk" value="' + subList[j][fid] + '" pid="' + subList[j][pid] + '" style="vertical-align: middle;"/>&nbsp;';
				liHtml += '<a href="javascript:;" name="a_tree_name">' + subList[j][fname] + '</a>';
				if(showdel)
					liHtml += '&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:;" name="a_tree_del" dataid="' + subList[j][fid] + '" style="display:none;">删除</a>';
				li.html(liHtml);
				if ($(ul).find('#tree_'+parentId).length > 0) {
					$(ul).find('#tree_'+parentId).after(li);
				} else {
					$(ul).append(li);
				}
				assembleSubDataHtml(ul, subList[j][fid], list);
			}
		};
		
		var ul = $('<ul/>');
		var imgSrc = '';
		for(var i=0; i<rootList.length; i++){//先显示根级
			var li = $('<li/>').attr('id', rootList[i][fid]).attr('pid', rootList[i][pid]);
			var html = '';
			if(showall){
				if(rootList.length === 1)
					imgSrc = 'images/dtree/single_minus.gif';
				else if(i === 0)
					imgSrc = 'images/dtree/top_minus.gif';
				else if(i === (rootList.length - 1))
					imgSrc = 'images/dtree/bottom_minus.gif';
				else
					imgSrc = 'images/dtree/minus.gif';
				html = '<img name="img_tree" src="' + imgSrc + '" show="true" style="vertical-align: middle;"/>&nbsp;';
			} else {
				if(rootList.length === 1)
					imgSrc = 'images/dtree/single_plus.gif';
				else if(i === 0)
					imgSrc = 'images/dtree/top_plus.gif';
				else if(i === (rootList.length - 1))
					imgSrc = 'images/dtree/bottom_plus.gif';
				else
					imgSrc = 'images/dtree/plus.gif';
				html = '<img name="img_tree" src="' + imgSrc + '" show="false" style="vertical-align: middle;"/>&nbsp;';
			}
			
			if(checkbox){
				html += '<input type="checkbox" name="treeChk" value="' + rootList[i][fid] + '" pid="' + rootList[i][pid] + '" style="vertical-align: middle;"/>&nbsp';
			}
			html += '<a href="javascript:;" name="a_tree_name">' + rootList[i][fname] + '</a>';
			if(showdel)
				html += '&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:;" name="a_tree_del" dataid="' + rootList[i][fid] + '" style="display:none;">删除</a>';
			li.html(html);
			ul.append(li);
			assembleSubDataHtml(ul, rootList[i][fid], list);
		}
		/*
		 * 选中子孙级checkbox
		 */
		var checkSubTree = function(box){
			var id = $(box).attr("value");
			var dis = $(box).attr('checked');
			if (dis === 'checked') {
				dis = true;
			} else {
				dis = false;
			}
			var lis = $(ul).find('li');
			for(var m=0; m<lis.length; m++){
				if ($(lis[m]).attr('pid') === id) {
					$(lis[m]).find('input[name="treeChk"]').attr('checked', dis);
					checkSubTree($(lis[m]).find('input[name="treeChk"]'));
				}
			}
		};
		
		if(checkbox){
			var boxs = $(ul).find('input[name=treeChk]');
			for(var i=0; i<boxs.length; i++){
				$(boxs[i]).bind('click', function(){
					checkSubTree(this);
				});
			}
		}
		/*
		 * 显示树的子级
		 */
		var showSubTree = function(img){
			var pid = $(img).parent().attr('id');
			var isShow = $(img).attr("show");
			if (isShow === 'false') {// 如果是+显示-
				var lis = $(ul).find('li');
				for(var m=0; m<lis.length; m++){
					if ($(lis[m]).attr('pid') === pid) {
						$(lis[m]).show();
					}
				}
				var imgStr = $(img).attr('src');
				imgStr = imgStr.replace('plus', 'minus');
				$(img).attr("src", imgStr);
				$(img).attr("show", "true");
			} else{// 如果是-显示+
				hideSubTree(img);
			}
		};
		/*
		 * 隐藏树的子孙级
		 */
		var hideSubTree = function(img){
			var pid =$(img).parent().attr('id');
			var lis = $(ul).find('li');
			for(var m=0; m<lis.length; m++){
				if($(lis[m]).attr('pid') === pid){
					$(lis[m]).hide();
					hideSubTree($(lis[m]).find('img[name=img_tree]'));
				}
			}
			var imgStr = $(img).attr('src');
			imgStr = imgStr.replace('minus', 'plus');
			$(img).attr("src", imgStr);
			$(img).attr("show", "false");
		};
		
		var imgs = $(ul).find('img[name=img_tree]');
		for(var i=0; i<imgs.length; i++){
			$(imgs[i]).bind('click', function(){
				showSubTree(this);
			});
		}
		/*
		 * 为li中的a标签绑定点击函数
		 */
		var as = $(ul).find('a[name="a_tree_name"]');
		for(var i=0; i<as.length; i++){
			$(as[i]).bind('click', function(){
				_theChooseId = $(this).parent().attr('id');
				_theChooseName = $(this).text();
				$(ul).find('a[name="a_tree_name"]').css('color', '');
				$(this).css('color', 'red');
				if(opts.click)
					opts.click();
			});
		}
		/*
		 * 为删除图片绑定删除函数
		 */
		if(opts.delaction){
			var as = $(ul).find('a[name="a_tree_del"]');
			for(var i=0; i<as.length; i++){
				$(as[i]).bind('click', function(e){
					opts.delaction(e);
				});
			}
			var lis = $(ul).find('li');
			for(var m=0; m<lis.length; m++){
				$(lis[m]).bind('mousemove', function(){
					$(this).find('a[name="a_tree_del"]').show();
				});
				$(lis[m]).bind('mouseout', function(){
					$(this).find('a[name="a_tree_del"]').hide();
				});
			}
		}
		
		ul.appendTo(divTree);
		divTree.appendTo(this);
	};
	
	/*
	 * 获得选中的id
	 */
	$.fn.getChooseId = function(){
		return _theChooseId;
	};
	
	/*
	 * 获得选中的name
	 */
	$.fn.getChooseName = function(){
		return _theChooseName;
	};
	
	/*
	 * 获得树中选中checkbox的id字符串，以,隔开
	 */
	$.fn.getTheBoxIds = function(){
		var ids = new Array();
		var chks = $(this).find('input[name=treeChk]:checked');
		for(var i=0; i<chks.length; i++){
			ids[i] = $(chks[i]).val();
		}
		return ids.join(',');
	};
	/*
	 * 获得树中选中checkbox的name字符串，以,隔开
	 */
	$.fn.getTheBoxNames = function(){
		var names = new Array();
		var chks = $(this).find('input[name=treeChk]:checked');
		for(var i=0; i<chks.length; i++){
			names[i] = $(chks[i]).parent().text();
		}
		return names.join(',');
	};
	
})(jQuery); 