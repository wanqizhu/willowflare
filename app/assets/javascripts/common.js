
jQuery(document).ready(function($) {
			$('.smobitrigger').smplmnu();
			 $('.bxslider').bxSlider();
			 
});

 /*  Sticky Header */
$(window).scroll(function() {
if ($(this).scrollTop() > 150){  
	$('.header-main').addClass("sticky");
}
else{
	$('.header-main').removeClass("sticky");
}
});
/*  Sticky Header */
/* amination */

/* amination */