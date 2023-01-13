$(document).ready(function(){
  $("#js-upload-trigger").on('click', function(e){
    e.preventDefault();
    alert("Mateo");
    console.log("Mateo");
    $(".avatar-popup-form").css("display", "flex");
    $("#js-avatar-file").trigger('click');
  });
});
