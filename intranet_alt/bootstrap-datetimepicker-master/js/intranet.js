/* tags */

function tag(node) {
    var ret = false;
    if ($(node).hasClass("tag_active")) {
        $(node).removeClass("tag_active");
	$(node).addClass("tag_inactive");
	ret = true;
    } else {
        $(node).removeClass("tag_inactive");
	$(node).addClass("tag_active");
    }
    return ret;
}



/* document upload */
var config = {
    // Valid file formats
    support : "image/jpg,image/png,image/bmp,image/jpeg,image/gif,application/pdf", 
    form: "demoFiler", // Form ID
    dragArea: "dragAndDropFiles", // Upload Area ID
    uploadUrl: "/intranet/upload" // Server side file url
}

/* init */

$(document).ready(function() {
   $("#docSearch").on("keyup", function() {
      var value = $(this).val().toLowerCase();
      $("#docs-box div").filter(function() {
          $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
      });
   });
   //$("#tabs").tabs();
   initMultiUploader(config); 
});

