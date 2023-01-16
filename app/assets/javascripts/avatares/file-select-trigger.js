$(document).ready(function(){
  $("#js-avatares-picture-preview").Jcrop();

  $("#js-upload-trigger").on('click', function(e){
    e.preventDefault();
    $("#js-avatares-picture").trigger('click');
  });
});
