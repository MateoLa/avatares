function readURL(input) {
  if (input.files && input.files[0]) {
    if (URL){
      $('#js-avatares-picture-preview').attr('src', URL.createObjectURL(input.files[0]));
    } else if (FileReader){
      let reader = new FileReader();
      reader.onload = function(event){
        $('#js-avatares-picture-preview').attr('src', e.target.result);
      };
      reader.readAsDataURL(input.files[0]);
    };
  }
}

$(document).ready(function(){
  $("#js-avatares-picture").change(function(){
  	readURL(this);
	});
});