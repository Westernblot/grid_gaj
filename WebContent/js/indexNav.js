$(document).ready(function () {
        var bt = $('#index_nav');
		
        $(window).scroll(function() {
                var st = $(window).scrollTop();
                if(st < 1){
                        bt.hide();
                }else{
                        bt.show();
                }
        });
	
	
})