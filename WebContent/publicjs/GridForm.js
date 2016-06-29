/**
 *  网格软件公用form验证js
 * 
 *  GridForm JS v0.1 (2014-04-11)
 *  Copyright (c) 2014 湖北网格
 *
 */
(function($){
	$.fn.GridFormInit = function(){
		var elems = new Array();
		var num = 0;
		var inputs = $(this).find('input[type=text]').toArray();
		for(;num < inputs.length; num++){
			elems[num] = inputs[num];
		}
		var selects = $(this).find('select').toArray();
		for(var i=0; i<selects.length; i++,num++){
			elems[num] = selects[i];
		}
		var areas = $(this).find('textarea').toArray();
		for(var i=0; i<areas.length; i++,num++){
			elems[num] = areas[i];
		}
		var show = '';
		for(var i=0; i<elems.length; i++){
			show = $(elems[i]).attr('show');
			if(typeof(show) !== 'undefined' && show !== ''){
				$(elems[i]).parent().css('position', 'relative');
				/*
				 * 元素获得焦点时提示信息
				 */
				$(elems[i]).bind('focus', function(){
					var text = $(this).val();
					text = text.replace(/(^\s*)|(\s*$)/g, "");
					if(text === ''){
						var div = $(this).parent().find('#div_gridform_msg');
						if(div.length < 1){
							div = $('<div/>').attr('id','div_gridform_msg').css({
								'white-space':'nowrap',
								'height': '20px',
								'width': 'auto',
								'position': 'absolute',
								'z-index': '99',
								'top':  '3px',
								'left': ($(this).width() + 20) + 'px',
								'border': '1px solid #FFAEB9',
								'-border-radius': '3px',
								'-moz-border-radius': '3px',
								'-webkit-border-radius': '3px'
							});
							div.html('<span  style="margin-left:3px;margin-right:3px;">' + $(this).attr('show') + '</span>');
							$(this).after(div);
						}
						else
							div.find('span').text($(this).attr('show'));
					}
				});
				/*
				 * 元素焦点离开时验证数据
				 */
				$(elems[i]).bind('blur', function(){
					var title = $(this).attr('title');
					var dataType = $(this).attr('dataType');
					var want = $(this).attr('want');
					var text = this.value;
					var flag = true;
					text = text.replace(/(^\s*)|(\s*$)/g, "");
					var alertMsg = '';
					if(want === 'yes' && text === ''){
						alertMsg = title + "不能为空！";
						flag = false;
					} else if(dataType === 'int'){
						var checkNum = /^\d+$/;
						if(!checkNum.test(text)){ //验证字符串是否一个正整数
							alertMsg = title+" 只能为数字类型！";
							flag = false;
						}
					} else if(dataType === 'number'){
						if(isNaN(text)){
							alertMsg = title+" 只能输入数字和小数点！";
							flag = false;
						}
					} else if(dataType === 'tel'){
						if(/^((\d{3,4}-)?(\d{3,8})(-(\d{3,4}))?)$/.test(text) === false){
							alertMsg = title + " 的输入格式不正确 ";
							flag = false;
						}
					} else if(dataType == 'mobile'){
						if(/^1[3|4|5|8][0-9]\d{4,8}$/.test(text)){
							alertMsg = title + " 的输入格式不正确 ";
							flag = false;
						}
					} else if(dataType == 'email'){
						var reg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;//email判断正则表达式
						if(!reg.test(text)){
							alertMsg = title + " 的输入格式不正确 ";
							flag = false;
						}
					}

					if(!flag){
						var div = $(this).parent().find('#div_gridform_msg');
						if(div.length < 1){
							div = $('<div/>').attr('id','div_gridform_msg').css({
								'white-space':'nowrap',
								'height': '20px',
								'width': 'auto',
								'position': 'absolute',
								'z-index': '99',
								'top':  '3px',
								'left': ($(this).width() + 20) + 'px',
								'border': '1px solid #FFAEB9',
								'-border-radius': '3px',
								'-moz-border-radius': '3px',
								'-webkit-border-radius': '3px'
							});
							div.html('<span  style="margin-left:3px;margin-right:3px;">' + alertMsg + '</span>');
							$(this).after(div);
						}
						else
							div.find('span').text(alertMsg);
					} else {
						var div = $(this).parent().find('#div_gridform_msg');
						if(div.length > 0)
							div.remove();
					}
				});
			}
		}
	};
})(jQuery);