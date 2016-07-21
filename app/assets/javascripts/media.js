$(function() {
  var mediaDropzone = new Dropzone("#media-dropzone");
  Dropzone.options.mediaDropzone = false;
  mediaDropzone.options.uploadMultiple = true;
  mediaDropzone.maxFiles =  10;

  mediaDropzone.on("sending", function(files) {
    $("#count").val(this.files.length);
  })

  mediaDropzone.on("complete", function(files) {
    var _this = this;
    if (_this.getUploadingFiles().length === 0 && _this.getQueuedFiles().length === 0) {
      setTimeout(function(){
        $('#myModal').modal('hide');
        var acceptedFiles = _this.getAcceptedFiles();
        var rejectedFiles = _this.getRejectedFiles();

        for(var index = 0; index < acceptedFiles.length; index++) {
          var file = acceptedFiles[index];
        }

        response = JSON.parse(file.xhr.response);
        $.each( response, function(key, value){
          appendContent(value.file_name.url, value.id);
        });

        if(acceptedFiles.length != 0) {
          alertify.success('Uploaded ' + acceptedFiles.length + ' files successfully.');
        }
        if(rejectedFiles.length != 0) {
          alertify.error('Error uploading ' + rejectedFiles.length + ' files. Only image files are accepted.');
        }

        _this.removeAllFiles();

      }, 2000);
    }
  });
});



var appendContent = function(imageUrl, mediaId) {
  $("#media-contents").append('<div class="col-lg-4">' +
    '<div class="thumbnail"><img src="' + imageUrl + '"/>' +
    '<div class="caption">' +
    '<input id="media_" name="media[]" value="' + mediaId +'" type="checkbox">' +
    '</div>' +
    '</div></div>');
  $("#delete").removeAttr('disabled');
  $("#delete-all").removeAttr('disabled');
  $(".btn-create-slideshow").removeAttr('disabled');
  $("#no-media").html("");
};
