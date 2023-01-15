function readURL(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
      $('#js-avatares-picture-preview').attr('src', e.target.result);
    }
    reader.readAsDataURL(input.files[0]);
  }
}

$(document).ready(function(){
  $("#js-avatares-picture").change(function(){
  	readURL(this);
	});
});