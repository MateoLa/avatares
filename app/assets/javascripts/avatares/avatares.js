$(document).ready(function(){
  $("#js-upload-trigger").on('click', function(e){
    e.preventDefault();
    alert("Mateo");
    $(".avatar-popup-form").css("display", "block");
    $("#js-avatar-file").trigger('click');
  });
});
