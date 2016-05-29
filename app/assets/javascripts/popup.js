// for popups and show/hide parts
var ready = function(){

    // $(".clickable-row").click(function() {
    //     window.document.location = $(this).data("href");
    // });
  

    // editUser show/hide profile fields
    $(".showHideButton").on('click',function(e){
        e.preventDefault();
        var id = "#" + $(this).attr('targetID');
        

        if ($(id).css('display') == 'none') {
            $(id).show('slow');
        } else {
            $(id).hide('slow');
        }
        

    });



    // highlight navbar button corresponding to current page
    $("li.btn a").each(function(){              
        if($(this).attr("href")==location.pathname){ /* check relative href address to see which one is active*/
            $(this).parent().addClass('selected');
        }
        else{
            $(this).parent().removeClass("selected");
        }
    });





    // for displaying an image overlay
    // used for terms-of-service

    $(".popupButton").on('click',function(e){
        e.preventDefault();
        $("#infographicImage").attr('src',$(this).attr('imagesrc'));
        
        var h = $(this).attr('img_height');
        var w = $(this).attr('img_width');

        if (typeof h == typeof undefined || h == false ) {
            h = "100%";
        }

        // if width is set, use that instead
        if (typeof w == typeof undefined || w == false ) {
            w = "auto";
        } else {
            h = "auto";
        }

        $("#infographicImage").attr('height', h);
        $("#infographicImage").attr('width', w);
        
        $("#infographicPopup").css({'display': '-webkit-flex'
                                   ,'display': 'flex'});
        $('body').css('overflow', 'hidden');
    });
    $('#infographicImage').on('click',function(e){
        e.stopPropagation();
    });
    $("#infographicPopup:not(#infographicImage)").on('click',function(){
        $('#infographicPopup').hide();
        $('body').css('overflow', 'scroll');
        
        $('html, body').animate({
            scrollTop: $("#text").offset().top
        }, 500);
    });


}

$(document).ready(ready);
$(document).on('page:load', ready); // for turbo-links, which doesnt' re-load teh page
                                    // this way, popupButton will work properly after account update