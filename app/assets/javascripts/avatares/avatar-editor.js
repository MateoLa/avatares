function readURL(input, cropper){
  if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function(e){
      $('#js-avatares-picture-preview').attr('src', e.target.result);
      cropper.replace(e.target.result);
      cropper.move(1, -1);
    }
    reader.readAsDataURL(input.files[0]);
  }
}

$(document).ready(function(){
  const trigger = document.getElementById("js-avatares-trigger");
  let input = document.getElementById("js-avatares-input");
  const picture = document.getElementById("js-avatares-picture");
  const crop = document.getElementById("js-avatares-crop");

  cropper = new Cropper(picture, {
    minContainerWidth: 250,
    minContainerHeight: 250,
    aspectRatio: 1,
    ready() {
      this.cropper.move(1, -1);
    }
  });

  trigger.addEventListener("click", function(){
    input.trigger("click");
  });

  input.addEventListener("change", function(){
  	readURL(this, cropper);
	});

  crop.addEventListener("click", function(e){
    e.preventDefault();
    let imgurl = cropper.getCroppedCanvas().toDataURL();
    input.src = imgurl;
    e.target.submit;
  });
});
