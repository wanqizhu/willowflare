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
}

$(document).ready(ready);
$(document).on('page:load', ready); // for turbo-links, which doesnt' re-load teh page
                                    // this way, popupButton will work properly after account update