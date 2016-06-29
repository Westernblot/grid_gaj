	jQuery(document).ready(function(){
	
	jQuery('.acc_housing').each(function(){
		var childobj = $(".housing_"+this.id);
		jQuery(this).click(function(){
			if(jQuery(childobj).length > 0) {
				if(jQuery(childobj).is(':visible')) {
							jQuery(childobj).hide();
							jQuery(this).removeClass('active');
				} else {
							jQuery(childobj).show();
							jQuery(this).addClass('active');
				}
				return false;	
			}
		});
	});

				
	jQuery('.acc_new').each(function(){
		var childobj = $(".child_"+this.id);
		jQuery(this).click(function(){
			if(jQuery(childobj).length > 0) {
				if(jQuery(childobj).is(':visible')) {
							jQuery(childobj).hide();
							jQuery(this).removeClass('active');
				} else {
					jQuery('.new_title li .child').each(function(){
							jQuery(this).hide();
							jQuery('.acc_new').removeClass('active');
					});
							jQuery(childobj).show();
							jQuery(this).addClass('active');
				}
				return false;	
			}
		});
	});
	
				
	jQuery('.left01 span').each(function(){
		var childobj = $(".right_"+this.id);
		jQuery(this).click(function(){
			if(jQuery(childobj).length > 0) {
				if(jQuery(childobj).is(':visible')) {
				} else {
					jQuery('.term01 .div_more .right').each(function(){
							jQuery(this).hide();
							jQuery('.left01 span').removeClass('active02');
					});
							jQuery(childobj).show();
							jQuery(this).addClass('active02');
				}
				return false;	
			}
		});
	});
		
				
	jQuery('.left02 span').each(function(){
		var childobj = $(".right_"+this.id);
		jQuery(this).click(function(){
			if(jQuery(childobj).length > 0) {
				if(jQuery(childobj).is(':visible')) {
				} else {
					jQuery('.term02 .div_more .right').each(function(){
							jQuery(this).hide();
							jQuery('.left02 span').removeClass('active02');
					});
							jQuery(childobj).show();
							jQuery(this).addClass('active02');
				}
				return false;	
			}
		});
	});
	
	

});