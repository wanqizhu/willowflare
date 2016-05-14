// for popups and show/hide parts

$(document).ready(function(){

    // $(".clickable-row").click(function() {
    //     window.document.location = $(this).data("href");
    // });
  
    $(".popupButton").on('click',function(e){
        e.preventDefault();
        var id = $(this).attr('targetID');
        

        var elem = document.getElementById(id)
        if (elem.style.display == 'none') {
        	elem.style.display = 'flex';
        } else {
        	elem.style.display = 'none';
        }
        

    });
});
