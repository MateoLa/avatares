$(document).ready(function(){
  let avatar = document.getElementById("avataresAvatar");
  const trigger = document.getElementById("avataresEdit");

  let form = document.getElementById("avataresForm");
  let input = document.getElementById("avataresInput");
  let base64data = document.getElementById("avatares64Data");

  const popup = document.getElementById("avataresPopup");
  const picture = document.getElementById("avataresPicture");
  const crop = document.getElementById("avataresCrop");
  let cropper;

  trigger.addEventListener("click", function(){ input.trigger("click"); });

  input.addEventListener("change", function(event){
    let files = event.target.files;
    let done = function(url){
      picture.src = url;
      popup.modal("show");
    };

    if (files && files[0]){
      if (URL){ done(URL.createObjectURL(files[0])); }
      else if (FileReader){
        let reader = new FileReader();
        reader.onload = function(event){
          done(event.result); 
        };
        reader.readAsDataURL(files[0]);
      };
    }
	});

  popup.on("shown.bs.modal", function(){
    cropper = new Cropper(picture, {
      minContainerWidth: 250,
      minContainerHeight: 250,
      aspectRatio: 1,
      viewMode: 2
    });
  }).on("hidden.bs.modal", function(){
    cropper.destroy();
    cropper = null;
  });

  crop.addEventListener("click", function(){
    let canvas;

    if (cropper){
      canvas = cropper.getCroppedCanvas({
        width: 350,
        height: 350
      });
      avatar.src = canvas.toDataURL();
      canvas.toBlob(function(blob){
        if (URL){ 
          base64data.val() = URL.createObjectURL(blob);
          form.submit();
        } else if (FileReader){
          let reader = new FileReader();
          reader.readAsDataURL(blob);
          reader.onloadend = function(){ 
            base64data.val() = reader.result; 
            form.onsubmit();
          };
        };
      });
    };
  });

});
