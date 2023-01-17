function readURL(input, cropper) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function(e) {
      $('#js-avatares-picture-preview').attr('src', e.target.result);
      cropper.replace(e.target.result);
      cropper.move(1, -1);
    }
    reader.readAsDataURL(input.files[0]);
  }
}

$(document).ready(function() {
  const image = document.getElementById('js-avatares-picture-preview');

  cropper = new Cropper(image, {
    minContainerWidth: 250,
    minContainerHeight: 250,
    aspectRatio: 1,
    ready() {
      this.cropper.move(1, -1);
    }
  });

  $("#js-avatares-trigger").on('click', function(e) {
    e.preventDefault();
    $("#js-avatares-picture").trigger('click');
  });

  $("#js-avatares-picture").change(function() {
  	readURL(this, cropper);
	});
});
