function setCropData(data){
  $("#crop_x").val(data.x);
  $("#crop_y").val(data.y);
  $("#crop_w").val(data.width);
  $("#crop_h").val(data.height);
}

$(document).ready(function(){
  const trigger = $("#avataresEdit");
  const input = $("#avataresInput");

  const popup = $("#avataresPopup");
  const picture = document.getElementById("avataresPicture");
  const crop = $("#avataresCrop");
  let cropper = null;

  trigger.click(function(){ input.click(); });

  input.change(function(event){
    let files = event.target.files;
    let done = function(url){
      picture.src = url;
      popup.modal("show");
    };

    if (URL){
      done(URL.createObjectURL(files[0]));
    } else if (FileReader){
      let reader = new FileReader();
      reader.onload = function(event){
        done(e.target.result);
      };
      reader.readAsDataURL(files[0]);
    };
	});

  popup.on("shown.bs.modal", function(){
    cropper = new Cropper(picture, {
      minContainerWidth: 250,
      minContainerHeight: 250,
      aspectRatio: 1,
      viewMode: 2
    });
  });
  
  popup.on("hidden.bs.modal", function(){
    cropper.destroy();
    cropper = null;
  });

  crop.click(function(){
    const avatar = document.getElementById("avataresAvatar");
    setCropData(cropper.getData());

    let canvas = cropper.getCroppedCanvas({ width: 350, height: 350 });
    canvas.toBlob(function(blob){
      if (URL){ avatar.src = URL.createObjectURL(blob); }
      else if (FileReader){
        let reader = new FileReader();
        reader.readAsDataURL(blob);
        reader.onloadend = function(event){ avatar.src = reader.result; };
      }
    });

    $("#avataresForm").submit();
  });

});
