
var ready = function(){

    // hide the forum announcement page when the user is actually using the forum (e.g. viewing topics)

    if ($(".thredded--private-topics").length != 0) {
        $("#forum_announcement").hide();
    }

    if ($(".thredded--topic").length != 0) {
        $("#forum_announcement").hide();
    }
}

$(document).ready(ready);
$(document).on('page:load', ready); // for turbo-links, which doesnt' re-load teh page
                                    // this way, popupButton will work properly after account update