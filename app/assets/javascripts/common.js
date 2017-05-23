
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



// editUser show/hide profile fields
// $(".showHideButton").on('click',function(e){
//     e.preventDefault();
//     var id = "#" + $(this).attr('targetID');
    

//     if ($(id).css('display') == 'none') {
//         $(id).show('slow');
//     } else {
//         $(id).hide('slow');
//     }
    

// });



// highlight navbar button corresponding to current page
$("li.btn a").each(function(){              
    if($(this).attr("href")==location.pathname){ /* check relative href address to see which one is active*/
        $(this).parent().addClass('selected');
    }
    else{
        $(this).parent().removeClass("selected");
    }
});


$("#storeConfirm").on('submit', function(e){
    if ($('#infographicPopup').length) {

        e.preventDefault;
    

        if(device_width > 767 && sessionStorage.getItem('social_media') == null && sessionStorage.getItem('visited') != 2) {
            
            // popup prompting social share
            var social_share = "<p>Thanks for redeeming! Share it with your friends and invite them to WillowFlare for bonus points! </p>" + $("#socialShare").html();

            $("#newsContainer > .box-wrapper > .box").html(social_share);
            sessionStorage.setItem('visited', 2);


            $("#infographicPopup").css({'display': '-webkit-flex'
                                           ,'display': 'flex'});
            $("#infographicImage").css({'margin': '0'});        
            $('body').css('overflow', 'hidden');

            display_image = false;

            $("#infographicPopup:not(#infographicPopup > #popupContainer)").on('click',function(){
                sessionStorage.setItem('social_media', 1);
                // $('html, body').animate({
                //     scrollTop: $("#page").offset().top
                // }, 500);
            });
        }

        // delay form submission until user hides the social share news
        if (sessionStorage.getItem('social_media') == null) {
            
            setTimeout(function(){ $('#storeConfirm').submit(); }, 500);
            return false;
        } else {
            
            //sessionStorage.setItem('visited', 1);
            return true;
        }
    }
 })