jQuery(document).ready(function(){
				
				jQuery('.acc_trigger').each(function(){
		 			var childobj = $(".child_"+this.id);
					jQuery(this).click(function(){
						if(jQuery(childobj).length > 0) {
							if(jQuery(childobj).is(':visible')) {
										jQuery(childobj).slideUp(200);
										jQuery(this).removeClass('active');
							} else {
								jQuery('.menu ul ul').each(function(){
										jQuery(this).slideUp(200);
										jQuery('.acc_trigger').removeClass('active');
								});
										jQuery(childobj).slideDown(200);
										jQuery(this).addClass('active');
							}
							return false;	
						}
					});
				});

			});
			
			