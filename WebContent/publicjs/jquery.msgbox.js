/**
 *  网格软件js公共库
 *  jquery 弹出层插件 0.1
 *
 *  Author: hw
 *  
 * 
 *
 **/

(function($) {

	$.msgbox = function(opts) {

		// if a string directly given, make it a text type msgbox
		if (typeof(opts) == 'string') {
			var content = opts;
			opts = {content: content};
		}
		// extend opts, set default options
		opts = opts || {};
		// msgbox width, default 360px; $('body').width is set if width is greater than that.
		opts.width = (opts.width || 360) > $(window).width() ? $(window).width() : (opts.width || 360);
		// msgbox height, default 260px; $('body').height is set if height is greater than that.
		opts.height = (opts.height || 180) > $(window).height() ? $(window).height() : (opts.height || 180);
		// title
		opts.title = opts.title || 'Information';
		// content, should be url if type is either url or ajax
		opts.content = opts.content || 'Thanks for using jquery.msgbox';
		// background opacity, default 0.6
		opts.bgOpacity = opts.bgOpacity || 0.5;
		// cache, if set to false, remove the dom after close it, else just hide it
		opts.cache = typeof opts.cache == 'undefined' ? false : opts.cache;
		opts.refresh = typeof opts.refresh === 'undefined' ? false : opts.refresh;
		
		opts.showClose = typeof opts.showClose == 'undefined' ? true : opts.showClose;
		opts.showMin = typeof opts.showMin == 'undefined' ? true : opts.showMin;
		opts.showHide = typeof opts.showHide == 'undefined' ? true : opts.showHide;
		
		// plugins on and off
		opts.pluginsOn = opts.pluginsOn || [];
		opts.pluginsOff = opts.pluginsOff || [];
		opts.btns = opts.btns || [];

		opts.left = typeof(opts.left) == 'undefined' ? (($(window).width() - opts.width) / 2) : opts.left;
		
		opts.top = typeof(opts.top) == 'undefined' ? (($(window).height() - opts.height) / 2) : opts.top;
		
		opts.zIndex = opts.zIndex || 1999;
	
		if(typeof(opts.cheek) == 'undefined')
			opts.cheek = true;
		
		if(typeof(opts.lock) == 'undefined')
			opts.lock = false;
		this.opts = opts;

		this._hook_options();

		this.time(opts.time);

		if(this.opts.lock){
			this.background = $('<div />').css({
				'position': 'absolute',
				'width': $(window).width() + 'px',
				'height': $(window).height() + 'px',
				'z-index': this.opts.zIndex - 1,
				'opacity': this.opts.bgOpacity,
				'top': 0,
				'left': 0,
				'display': 'none',
				'background-color': '#B5B4B3'
			}).appendTo('body');
		}

		this.mainWrap = $('<table />').css({
			'width': this.opts.width + 'px',
			'height': this.opts.height + 'px',
			'position': 'absolute',
			'z-index': this.opts.zIndex,
			'display': 'none',
			'left': this.opts.left + 'px',
			'top' : this.opts.top + 'px',
			'border-collapse' : 'separate'
		}).attr('cellpadding','0').attr('cellspacing','0').attr('border','0').appendTo('body');
		
		if(this.opts.id){
			this.mainWrap.attr('id', this.opts.id);
			if(this.background != null)
				this.background.attr('id', 'bg_' + this.opts.id);
		}
		
		//dialog title行
		this.headWrap = $('<tr />').css({'height': '35px', 'cursor':'move'}).attr('align','middle');
		this.headWrap_td1 = $('<td />')
			.append('<img src="publicjs/msgbox/img/t_l.png" />').appendTo(this.headWrap);
		this.titleWrap = $('<td />').attr('align','left').attr('valign','middle')
			.append('<img src="publicjs/msgbox/img/logo.png" align="absmiddle"/>' + this.opts.title)
			.addClass('jMsgbox-titleWrap').appendTo(this.headWrap);
		this.closeWrap = $('<td />').addClass('jMsgbox-closeWrap')
			.append('<a href="javascript:;"><img src="publicjs/msgbox/img/refresh.png" /></a>')
			.append('<a href="javascript:;"><img src="publicjs/msgbox/img/hide.png" /></a>')
			.append('<a href="javascript:;" showType="min"><img src="publicjs/msgbox/img/to_max.png" /></a>')
			.append('<a href="javascript:;"><img src="publicjs/msgbox/img/close.png" /></a>')
			.appendTo(this.headWrap);
		
		this.headWrap_td4 = $('<td />')
			.append('<img src="publicjs/msgbox/img/t_r.png" />').appendTo(this.headWrap);
			
		if(this.opts.cheek){
			this.headWrap.appendTo(this.mainWrap);	
		}
		
		//dialog 内容行
		this.content = $('<tr />').appendTo(this.mainWrap).attr('height', '100%');
		
		//如果需要显示标题栏及边框样式
		if(this.opts.cheek){
			this.contentWrap_td1 = $('<td />').css({
				'background-image':'url(publicjs/msgbox/img/l_l.png)', 
				'background-repeat':'repeat-y'
			}).appendTo(this.content);
			
			this.contentWrap_td2 = $('<td />').attr('colspan','2').attr('valign', 'top').addClass('jMsgbox-contentWrap').appendTo(this.content);
			/*.css({ 
				'height': (this.opts.height - 35 - 7) + 'px',
				'width': (this.opts.width - 7 -7) + 'px'
			}).appendTo(this.content);*/
			
			this.contentWrap = $('<div />').appendTo(this.contentWrap_td2).css({
				'border': '0px solid #fff',
				'overflow': 'auto',
				'width' : (this.opts.width - 7 -7) + 'px',
				'height' : (this.opts.height - 35 - 7) + 'px'
			});
			this.contentWrap_td3 = $('<td />').css({
				'background-image':'url(publicjs/msgbox/img/l_r.png)',
				'background-repeat':'repeat-y'
			}).appendTo(this.content);
		
			//dialog footer行
			this.footerWrap = $('<tr />').appendTo(this.mainWrap);
			if(this.opts.btns.length > 0){
				this.footerWrap.css('height', '34px');
				this.footerWrap_td1 = $('<td />').css({
					'width': '7px'
				}).append('<img src="publicjs/msgbox/img/b_l.png" />').appendTo(this.footerWrap);
				this.footerWrap_td2 = $('<td />').attr('colspan','2').css({
					'background-image':'url(publicjs/msgbox/img/b_bg.png)'
				}).appendTo(this.footerWrap);
				this.footerWrap_td3 = $('<td />').css({
					'width': '7px'
				}).append('<img src="publicjs/msgbox/img/b_r.png" />').appendTo(this.footerWrap);
			}else{
				this.footerWrap.css('height', '7px');
				this.footerWrap_td1 = $('<td />').css({
					'width': '7px'
				}).append('<img src="publicjs/msgbox/img/b_l7.png" />').appendTo(this.footerWrap);
				this.footerWrap_td2 = $('<td />').attr('colspan','2').css({
					'background-image':'url(publicjs/msgbox/img/b_bg7.png)'
				}).appendTo(this.footerWrap);
				this.footerWrap_td3 = $('<td />').css({
					'width': '7px'
				}).append('<img src="publicjs/msgbox/img/b_r7.png" />').appendTo(this.footerWrap);
			}
				
			
		} else {//如果不需要
			this.mainWrap.css('background', '#fff');
			this.contentWrap_td2 = $('<td />').appendTo(this.content);
			/*.css({ 
				'width': '100%',
				'height': '100%'
			});*/
			
			this.contentWrap = $('<div />').appendTo(this.contentWrap_td2).css({
				'overflow': 'auto',
				'width' : '100%',
				'height': '100%'
			});
		}
				
		this._hook_domready();
		
		return this;  // to allow chain operation
	};

	$.msgbox.prototype = {

		/*****************************************
		 *  member functions
		 *  functions with prefix _ are supposed
		 *  to be private functions
		 *****************************************/

		getId : function(){
			return this.mainWrap.attr('id');
		},
		
		isShow: function(){
			if(this.mainWrap.css('display') == 'table')
				return true;
			else
				return false;
		},
		
		maxAndSmall: function(){
			var showType = this.closeWrap.find('a:eq(1)').attr('showType');
			if(showType == 'min'){
				var nowWidth = this.mainWrap.width();
				var nowHeight = this.mainWrap.height();
				this.closeWrap.find('a:eq(1)').attr('showType','max');
				this.closeWrap.find('a:eq(1)').attr('nw', nowWidth);
				this.closeWrap.find('a:eq(1)').attr('nh', nowHeight);
				this.mainWrap.animate({
					top: '0px',
					left: '0px',
					width: $(window).width() + 'px',
					height: ($(window).height() - 35) + 'px'
				});
				this.contentWrap.css({
					width: ($(window).width()- 7 -7) + 'px',
					height: ($(window).height() - 35) + 'px'
				});
			} else {
				var nowWidth = this.closeWrap.find('a:eq(1)').attr('nw');
				var nowHeight = this.closeWrap.find('a:eq(1)').attr('nh');
				this.closeWrap.find('a:eq(1)').attr('showType','min');
				this.mainWrap.animate({
					left: (($(window).width() - nowWidth) / 2) + 'px',
					top: (($(window).height() - nowHeight) / 2) + 'px',
					width: nowWidth + 'px',
					height: nowHeight + 'px'
				});
				this.contentWrap.css({
					width : (nowWidth - 7 -7) + 'px',
					height : (nowHeight - 35 - 7) + 'px'
				});
			}
			
		},
		add_index_show: function(maxIndex){
			this.mainWrap.css('z-index', maxIndex);
			this.mainWrap.show();
			return this;
		},
		
		show: function() {
			if(this.background != null)
				this.background.show();
			this.mainWrap.show();
			return this;
		},
		
		hidden: function(){
			if(this.background != null)
				this.background.hide();
			this.mainWrap.hide();
			return this;
		},

		close: function() {
			if( this.opts.cache ){
				if(this.background != null)
					this.background.hide();
				this.mainWrap.hide();
			} else {
				this.remove();
			}
			return this;
		},
		
		remove: function(){ // anyway remove it
			if(this.background != null)
				this.background.remove();
			this.mainWrap.remove();
			return this;
		},

		/*****************************************
		 *  hooks for plugins
		 *  To apply plugin actions to msgbox
		 *****************************************/

		// to handle extra options for plugins
		_hook_options: function() {
			for (var pluginName in $.msgbox)
				if (this.is_active(pluginName) && $.msgbox[pluginName].options)
					$.msgbox[pluginName].options.apply(this, arguments);
		},

		// after dom setup
		_hook_domready: function() {
			for (var pluginName in $.msgbox)
				if (this.is_active(pluginName) && $.msgbox[pluginName].domready)
					$.msgbox[pluginName].domready.apply(this, arguments);
		},
		
		/*****************************************
		 *  helpers for plugins
		 *****************************************/
		
		// helper for rewrite the existed member functions, or add opts
		extend: function(name, v){
			if( $.isFunction(this[name]) && !/^_|^extend$|^is_active$/.test(name) ){
				// inline functions and '_' prefixed functions  are not allowed to be extended
				var self = this[name];
				this[name] = function(){
					v.call(this, self);
					return this;
				};
			} else {
				if( typeof this.opts[name] == 'undefined' )
					this.opts[name] = v;
			}
			return this;
		},
		
		// if a plugin is activated, for plugin development
		is_active: function(pluginName){
			return !$.msgbox[pluginName] || $.inArray(pluginName, this.opts.pluginsOn) > -1 ||
				( $.inArray(pluginName, this.opts.pluginsOff) < 0 &&
				  ( typeof $.msgbox[pluginName].active == 'undefined' || $.msgbox[pluginName].active )
				);
		},
		
		/**
	     * 定时关闭
	     * @param	{Number}	单位毫秒, 无参数则停止计时器
	     */
	  time: function (time) {
	  	var that = this,
	    timer = this._timer;         
	    timer && clearTimeout(timer);   
	    if (time) {
	    	this._timer = setTimeout(function(){
	      	that.close();
	      }, time);
	    };
	       
	    	return this;
	    }

	};
	
	//////////////////////////////////////////////////
	//                                              //
	//    jquery.msgbox internal plugins start.     //
	//    You can put your plugins somewhere else,  //
	//    as well as these plugins ... ;)           //
	//                                              //
	//////////////////////////////////////////////////
	
	/**
	 * description: enable|disable drag and drop for msgbox
	 * options added: allowDrag(true|false)
	 * ! you need to refer jquery.dragndrop plugin
	 **/
	$.msgbox.dragndrop = {

		options: function() {
			this.extend('allowDrag', true);
		},

		domready: function() {
			var _this = this;
			if (this.opts.allowDrag) {
				this.mainWrap.Drags({
					handler: this.headWrap,
					range: 'window',
					onDrop: function() {
						// for resetposition plugin to keep the relative postion of msgbox
						_this.mainWrap.css('position', 'fixed');
						_this.relTop = _this.mainWrap.offset().top - $(window).scrollTop();
						_this.relLeft = _this.mainWrap.offset().left - $(window).scrollLeft();
					}
				});
			}
		}
	};
	
	/**
	 * description: reset the msgobx position while window is resizing or scrolling
	 **/
	$.msgbox.resetposition = {
		
		domready: function(){
			var _this = this;
			
			var resetPos = function(){
				if(_this.background != null){
					_this.background.css({
						width: $(window).width() + 'px',
						height: $(window).height() + 'px',
						top: 0,
						left: 0
					});
				}
				if( _this.relTop ){  // have been dragged
					_this.mainWrap.css({
						top: _this.relTop + 'px',
						left: _this.relLeft + 'px' 
					});
				} 
			};
			
			resetPos();
			
			$(window)
                .load(resetPos)    // just in case user is changing size of page while loading
                .resize(resetPos)
                .scroll(resetPos);
		}
		
	};
	
	/**
	 * description: add a callback when msgbox is closing
	 * options added: onClose(function)
	 * function modified: close
	 **/
	$.msgbox.onclose = {
		
		options: function(){
			this.extend('onClose', function(){});
		},
		
		domready: function(){
			this.extend('close', function(self){
				self.call(this);
				this.opts.onClose.apply(this, arguments);
			});
		}
	};
	
	/**
	 * description: add a function that msgbox will be automatically closed in autoclose seconds
	 * options added: autoclose(int), 0 to disable this function
	 * functions added:
	 * 	startAutoClose(int): manually start auto-closing
	 *		if autoclose is set to 0, you can use this function to start auto-closing
	 *	endAutoClose: to end auto-closing immediately
	 * functions modified:
	 *	close: to prevent timer running after close
	 **/
	$.msgbox.autoclose = {
		
		options: function() {
			this.extend('autoClose', 0);
		},
		
		domready: function(){
			
			var _this = this;
			this.closeMsg = '&nbsp; &nbsp; Closing in <strong>{seconds}</strong>s';
			var interval = null;
			var autoclose = function(sec){
				_this.titleWrap.append(_this.closeMsg.replace('{seconds}', sec));
				
				interval = setInterval(function(){
					if( sec==1 ){
						_this.close();
					} else {
						sec--;
						$('strong', _this.titleWrap).text(sec);
					}
				}, 1000);
			};
				
			// to prevent timer running after msgbox closed
			this.extend('close', function(self){
				self.call(this);
				clearInterval(interval);
			});
				
			this.startAutoClose = function(sec){
				if( sec > 0 )
					autoclose.call(_this, sec);
				return _this;
			};
			
			this.endAutoClose = function(){
				_this.titleWrap.html( this.opts.title );
				clearInterval(interval);
				return _this;
			};
			
			this.startAutoClose(this.opts.autoClose);
		}
	};
	
	/**
	 * description: add animation when opening and closing
	 * options added: anim(int) type of animation to add, default: 0
	 * functions modified:
	 * 	show
	 * 	close
	 **/
	$.msgbox.animate = {

		options: function(){
			this.extend('anim', 0);
		},
		
		domready: function(){
			var _this = this;
			this.extend('show', function(self){
				if(this.background != null)
					this.background.show();
				switch(this.opts.anim){
					case 0:
						if(this.opts.type == 'alert' || this.opts.type == 'confirm'){
							_this.mainWrap.show().css({
								top: (_this.mainWrap.offset().top - 50) + 'px',
								opacity: .3
							}).animate({
								top: (_this.mainWrap.offset().top + 50) + 'px',
								opacity: 1
							}, function(){
								// loading start, avoid choking when loading content and animation happen at the same time
								_this.startLoading = true; 
								self.call(_this);
							});
						}else{
							_this.mainWrap.show().css({
								top: (_this.mainWrap.offset().top + 150) + 'px',
								left:  (_this.mainWrap.offset().left - 300) + 'px',
								opacity: .3
							}).animate({
								top: (_this.mainWrap.offset().top - 150) + 'px',
								left:  (_this.mainWrap.offset().left + 300) + 'px',
								opacity: 1
							},'normal', function(){
								// loading start, avoid choking when loading content and animation happen at the same time
								_this.startLoading = true; 
								self.call(_this);
							});
						}
						break;
					case 1:
						_this.mainWrap.show().css({
							left: (_this.mainWrap.offset().left - 80) + 'px',
							opacity: .3
						}).animate({
							left: (_this.mainWrap.offset().left + 80) + 'px',
							opacity: 1
						}, function(){
							// loading start, avoid choking when loading content and animation happen at the same time
							_this.startLoading = true; 
							self.call(_this);
						});
						break;
					case 2:
						_this.mainWrap.show().css({
							left: (_this.mainWrap.offset().left + 80) + 'px',
							opacity: .3
						}).animate({
							left: (_this.mainWrap.offset().left - 80) + 'px',
							opacity: 1
						}, function(){
							// loading start, avoid choking when loading content and animation happen at the same time
							_this.startLoading = true; 
							self.call(_this);
						});
						break;
					default:
						self.call(_this);
						break;
				}
			});
			
			this.extend('close', function(self){
				switch(this.opts.anim){
					case 0:
						this.mainWrap.animate({
							top: (_this.mainWrap.offset().top - 50) + 'px',
							opacity: 0
						}, function(){
							self.call(_this);
						});
						break;
					case 1:
						this.mainWrap.animate({
							left: (this.mainWrap.offset().left - 80) + 'px',
							opacity: 0
						}, function(){
							self.call(_this);
						});
						break;
					case 2:
						this.mainWrap.animate({
							left: (this.mainWrap.offset().left + 80) + 'px',
							opacity: 0
						}, function(){
							self.call(_this);
						});
						break;
					default:
						self.call(_this);
						break;
				}
			});
			
			this.extend('hidden', function(self){
				this.mainWrap.animate({
					top: '+=100px',
					left: '-=100px',
					opacity: 0.3
				}, 'slow', function(){
					self.call(_this);
				});
			});
		}
	};
	
	/**
	  * description: fix the dimension
	  **/
	$.msgbox.fixdimen = {
		domready: function(){
			this.extend('show', function(self){
				// need to show first, because some of the dimensions cannot be got if they are hidden.
				self.apply(this, arguments);
				// fix titleWrap width
				var _this = this;
				var interval = null;
				interval = setInterval(function(){ // wait until the image loaded
					if( _this.closeWrap.outerWidth(true) > 0 ){
						clearInterval(interval);
						_this.titleWrap.width( _this.opts.width - 
											  _this.closeWrap.outerWidth(true) - 
											  parseInt(_this.headWrap.css('padding-left')) -
											  parseInt(_this.headWrap.css('padding-right')) -
											  parseInt(_this.headWrap.css('border-right-width')) -
											  parseInt(_this.headWrap.css('border-left-width')) -
											  parseInt(_this.headWrap.css('margin-left')) -
											  parseInt(_this.headWrap.css('margin-right')) - 5 );
					}
				}, 200);
				
				// fix content height
				//this.content.height(this.opts.height - this.headWrap.outerHeight(true));
			});
		}
	};
		
	/**
	 * description: add multiple type support for msgbox
	 * options added:
	 * 	type(string)
	 * 		alert: add a close button at the bottom
	 * 		confirm: add YES,NO button at the bottom
	 * 		input: add a input box and a OK button
	 * 		ajax/url: opts.content should be a url for ajax
	 * 		iframe: opts.content should be a url for iframe
	 * 		anything else: a plain text(HTML supported) string in content wrapper
	 * 	onAjaxed(function)
	 * 		callback when ajax request completed.
	 **/
	$.msgbox.contenttype = {
		
		options : function(){
			this.extend('type', 'text');
			this.extend('onAjaxed', function(){});
		},
		
		domready: function(){
			var _this = this;
			var _content = this.opts.content;
			var _closeFun = this.opts.closeFun;
			switch(this.opts.type){
				case 'alert':
					_this.contentWrap.html(_content);
					_this.closeWrap.find('a:eq(1)').bind('click',function(){
						_this.hidden();
					});
					_this.closeWrap.find('a:eq(2)').bind('click',function(){
						_this.maxAndSmall();
					});
					
					_this.closeWrap.find('a:last').bind('click',function(){
						_this.close();
					});
					break;
				case 'confirm':
					_this.closeWrap.find('a:eq(1)').bind('click',function(){
						_this.hidden();
					});
					_this.closeWrap.find('a:eq(2)').bind('click',function(){
						_this.maxAndSmall();
					});
					_this.closeWrap.find('a:last').bind('click',function(){
						_this.close();
					});
					_this.contentWrap.html(_content);
					this.setValue = function(v){
						_this.value = v;
						return _this;
					};
					this.getValue = function(){
						return _this.value;
					};
					var center = $('<center />');
					var len = _this.opts.btns.length;
					var btn;
					for (var i = 0; i < len; i++) {
						btn = $('<input class="buttonStyle" style="margin-left:10px;margin-right:10px;" type="button" value="' + _this.opts.btns[i].name + '" />').click(_this.opts.btns[i].fun);
						center.append(btn);
					}
					this.footerWrap_td2.append(center);
					break;
				case 'iframe':
					//this.contentWrap.css('padding',0).empty();
					_this.closeWrap.find('a:first').bind('click', function(){
						var iframe = _this.mainWrap.find('iframe:eq(0)');
						var src = iframe.attr('src');
						iframe.attr('src', src); 
					});
					
					_this.closeWrap.find('a:eq(1)').bind('click', function(){
						_this.hidden();
					});

					_this.closeWrap.find('a:eq(2)').bind('click', function(){
						_this.maxAndSmall();
					});
					if(typeof(_closeFun) == 'function'){
						_this.closeWrap.find('a:last').bind('click', _closeFun);
					}else{
						_this.closeWrap.find('a:last').bind('click', function(){
							_this.close();
						});
					}
					
					if( !_this.is_active('animate') )
						_this.startLoading = true;
					var interval = null;
					interval = setInterval(function(){
						if( _this.startLoading ){ 
							clearInterval(interval);
							$('<iframe border="0" frameborder="0" marginheight="0" marginwidth="0" scrolling="auto"></iframe>')
								.appendTo(_this.contentWrap)
								.css({
									'border': '0px',
									'height': '100%',
									'width': '100%'
								})
								.attr({
									'width'  : '100%',
									'height' : '100%',
									'src'    : _content
								});
						}
					}, 200);
					
					break;
				default:
					break;
				
			}
		}
	};
	
	/**
	 * description: flash the title when clicking the background
	 **/
	$.msgbox.flashtitle = {
		domready: function(){
			var _this = this;
			var timeout = null;
			var flash = null;
			flash = function(opacity, times, interval, flag){
				if( times > 0 ) {
					flag = !flag;
					op = flag ? opacity : 1;
					this.headWrap.css('opacity',op);    
					timeout = setTimeout(function(){ flash.call(_this, opacity, times-1, interval, flag); }, interval);
				} else clearTimeout(timeout);
			};
			if(this.background != null){
				this.background.click(function(){
					flash.call(_this, .5, 4, 80);
				});
			}
		}
	};
		

	/**
	 * description: allow option showClose to control if msgbox could be closed.
	 *				but it can still be closed by function(this.close)
	 * options added: showClose(true|false)
	 * functions added:
	 * 	setShowClose(true|false):
	 * 		show or hide close icon, if background dblclick close set, enable or disabled it
	 **/
	$.msgbox.showclose = {
		
		domready: function(){
			var _this = this;
			if(!this.opts.refresh){
				_this.closeWrap.find('a:first').css('visibility', 'hidden');
			}
			if(!this.opts.showHide){
				_this.closeWrap.find('a:eq(1)').css('visibility', 'hidden');
			}
			if(!this.opts.showMin){
				_this.closeWrap.find('a:eq(2)').css('visibility', 'hidden');
			}
			if(!this.opts.showClose){
				_this.closeWrap.find('a:last').css('visibility', 'hidden');
			}
			return _this;
		}
		
	};

})(jQuery);
