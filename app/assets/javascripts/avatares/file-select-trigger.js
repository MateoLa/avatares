$(document).ready(function(){
  Jcrop.attach("js-avatares-picture-preview");

  $("#js-upload-trigger").on('click', function(e){
    e.preventDefault();
    $("#js-avatares-picture").trigger('click');
  });
});
