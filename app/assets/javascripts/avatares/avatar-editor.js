function setCropData(data){
  $("#crop_x").val(data.x);
  $("#crop_y").val(data.y);
  $("#crop_w").val(data.width);
  $("#crop_h").val(data.height);
}

$(document).ready(function(){
  const avataresPicture = document.getElementById("avataresPicture");
  let cropper = null;
  
  $("#avataresEdit").click( function(){
    $("#avataresInput").click();
  });

  $("#avataresInput").change(function(event){
    let files = event.target.files;
    let done = function(url){
      avataresPicture.src = url;
      $("#avataresPopup").modal("show");
    };

    if (URL){
      done(URL.createObjectURL(files[0]));
    } else if (FileReader){
      let reader = new FileReader();
      reader.onload = function(event){ done(e.target.result); };
      reader.readAsDataURL(files[0]);
    };
	});

  $("#avataresPopup").on("shown.bs.modal", function(){
    cropper = new Cropper(avataresPicture, {
      minContainerWidth: 250,
      minContainerHeight: 250,
      aspectRatio: 1,
      viewMode: 2
    });
  });
  
  $("#avataresPopup").on("hidden.bs.modal", function(){
    cropper.destroy();
    cropper = null;
  });

  $("#avataresCrop").click(function(){
    setCropData(cropper.getData());

    cropper.getCroppedCanvas().toBlob(function(blob){
      if (URL){ $("#avataresAvatar").src = URL.createObjectURL(blob); }
      else if (FileReader){
        let reader = new FileReader();
        reader.readAsDataURL(blob);
        reader.onloadend = function(event){ $("#avataresAvatar").attr("src", reader.result); };
      }
    });

    $("#avataresForm").submit();
  });
});
