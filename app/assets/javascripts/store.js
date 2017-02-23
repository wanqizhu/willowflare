
// for aligning store items
var ready = function(){
	var device_width = (window.innerWidth > 0) ? window.innerWidth : screen.width;

	// reset the height so that it adjusts to screen width
	$("#store .info-block").css("height", "auto");

	if (device_width > 767) {
		
		var maxHeight = Math.max.apply(null, $("#store .info-block:not(.coming-soon)").map(function ()
		    {
		        return $(this).height();
		    }).get());


		$("#store .info-block").css("height", maxHeight);
		//console.log(maxHeight);
	}
}

window.onload = ready; // use window.onload rather than $(document).ready so that images will load
window.onresize = ready;
$(document).on('page:change', function() { setTimeout(ready, 500);}); // for turbo-links, which doesnt' re-load the page
// delay time to allow images to load, since Turbolinks seem to not have a window.onload equivalent;
// IDEALLY FIX IT