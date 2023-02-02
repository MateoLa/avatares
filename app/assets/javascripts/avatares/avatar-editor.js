function setCropData(data){
  document.getElementById("crop_x").value = data.x;
  document.getElementById("crop_y").value = data.y;
  document.getElementById("crop_w").value = data.width;
  document.getElementById("crop_h").value = data.height;
}

$(document).ready(function(){
  const avataresAvatar = document.getElementById("avataresAvatar");
  const avataresEdit = document.getElementById("avataresEdit");

  const avataresInput = document.getElementById("avataresInput");
  const avataresPopup = document.getElementById("avataresPopup");
  const modalEl = new bootstrap.Modal(avataresPopup);
  const avataresPicture = document.getElementById("avataresPicture");
  const avataresCrop = document.getElementById("avataresCrop");
  let cropper = null;
  
  avataresEdit.addEventListener("click", function(){ avataresInput.click(); });

  avataresInput.addEventListener("change", function(event){
    let files = event.target.files;
    let done = function(url){
      avataresPicture.src = url;
      modalEl.show();
    };

    if (URL){
      done(URL.createObjectURL(files[0]));
    } else if (FileReader){
      let reader = new FileReader();
      reader.onload = function(event){ done(e.target.result); };
      reader.readAsDataURL(files[0]);
    };
	});

  modalEl._element.addEventListener("shown.bs.modal", function(){
    cropper = new Cropper(avataresPicture, {
      minContainerWidth: 250,
      minContainerHeight: 250,
      aspectRatio: 1,
      viewMode: 2
    });
  });
  
  modalEl._element.addEventListener("hidden.bs.modal", function(){
    cropper.destroy();
    cropper = null;
  });

  avataresCrop.addEventListener("click", function(){
    setCropData(cropper.getData());

    cropper.getCroppedCanvas().toBlob(function(blob){
      if (URL){ avataresAvatar.src = URL.createObjectURL(blob); }
      else if (FileReader){
        let reader = new FileReader();
        reader.readAsDataURL(blob);
        reader.onloadend = function(event){ avataresAvatar.src = reader.result; };
      }
    });

    document.getElementById("avataresForm").submit();
  });

});
