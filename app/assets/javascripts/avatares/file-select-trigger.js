$(document).ready(function(){
  const image = document.getElementById('js-avatares-picture-preview');

  new Cropper(image, {
    minContainerWidth: 250,
    minContainerHeight: 250,
    aspectRatio: 1,
    ready() {
      this.cropper.move(1, -1);
    }
  });

  $("#avatares-edit-trigger").on('click', function(e){
    e.preventDefault();
    $("#js-avatares-picture").trigger('click');
  });
});
