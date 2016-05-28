// for popups and show/hide parts
var ready = function(){

    // $(".clickable-row").click(function() {
    //     window.document.location = $(this).data("href");
    // });
  
    $(".popupButton").on('click',function(e){
        e.preventDefault();
        var id = "#" + $(this).attr('targetID');
        

        if ($(id).css('display') == 'none') {
            $(id).show('slow');
        } else {
            $(id).hide('slow');
        }
        

    });



    // highlight button corresponding to current page
    $("li.btn a").each(function(){              
        if($(this).attr("href")==location.pathname){ /* check relative href address to see which one is active*/
            $(this).parent().addClass('selected');
        }
        else{
            $(this).parent().removeClass("selected");
        }
    });

    // $('li.btn').click(function(){
    //     $('li.btn').removeClass('selected');
    //     $(this).addClass('selected');
    // })
}

$(document).ready(ready);
$(document).on('page:load', ready); // for turbo-links, which doesnt' re-load teh page
                                    // this way, popupButton will work properly after account update