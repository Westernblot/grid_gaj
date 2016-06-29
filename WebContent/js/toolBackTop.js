$(document).ready(function () {
        var bt = $('#toolBackTop');
        var sw = $(document.body)[0].clientWidth;

        var limitsw = 12;
        if (limitsw > 0){
                limitsw = parseInt(limitsw);
                bt.css("right",limitsw);
        }

        $(window).scroll(function() {
                var st = $(window).scrollTop();
                if(st > 320){
                        bt.show();
                }else{
                        bt.hide();
                }
        });
		
		
		
		var ia = $('#index_nav');
        $(window).scroll(function() {
                var sa = $(window).scrollTop();
                if(sa < 1){
                        bt.hide();
                }else{
                        bt.show();
                }
        });
	
})