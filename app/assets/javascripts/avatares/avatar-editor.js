function setCropData(data){
  data = data.detail;
  let crop_x = document.getElementById("crop_x");
  let crop_y = document.getElementById("crop_y");
  let crop_w = document.getElementById("crop_w");
  let crop_h = document.getElementById("crop_h");

  crop_x.value = data.x;
  crop_y.value = data.y;
  crop_w.value = data.width;
  crop_h.value = data.height;
}

$(document).ready(function(){
  let avatar = document.getElementById("avataresAvatar");
  const trigger = document.getElementById("avataresEdit");

  let form = document.getElementById("avataresForm");
  let input = document.getElementById("avataresInput");

  const popup = document.getElementById("avataresPopup");
  const picture = document.getElementById("avataresPicture");
  const crop = document.getElementById("avataresCrop");
  let cropper;

  trigger.addEventListener("click", function(){ input.click(); });

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

  popup.addEventListener("shown.bs.modal", function(){
    cropper = new Cropper(picture, {
      minContainerWidth: 250,
      minContainerHeight: 250,
      aspectRatio: 1,
      viewMode: 2
    });
  });
  
  popup.addEventListener("hidden.bs.modal", function(){
    cropper.destroy();
    cropper = null;
  });

  crop.addEventListener("click", function(){
    setCropData(cropper.getData());
    setcanvas = cropper.getCroppedCanvas({
      width: 350,
      height: 350
    });
    canvas.toBlob(function(blob){
      if (URL){ avatar.src = URL.createObjectURL(blob); }
      else if (FileReader){
        let reader = new FileReader();
        reader.readAsDataURL(blob);
        reader.onloadend = function(event){ avatar.src = reader.result };
      }
    });
    form.submit();
  });

});
