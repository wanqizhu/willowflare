
// for aligning store items
var ready = function(){
	var maxHeight = Math.max.apply(null, $("#store .info-block:not(.coming-soon)").map(function ()
	    {
	        return $(this).height();
	    }).get());


	$("#store .info-block").css("height", maxHeight);
}

window.onload = ready; // use window.onload rather than $(document).ready so that images will load
$(document).on('page:load', ready); // for turbo-links, which doesnt' re-load the page