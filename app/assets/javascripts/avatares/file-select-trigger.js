$(document).ready(function(){
  pic = $("#js-avatares-picture-preview");
  w = pic.width();
  h = pic.height();

  var rect = Jcop.Rect.from(pic)
  var jcp = Jcrop.attach(pic, {
    setSelect: [0, 0, 100, 100],
    aspectRatio: 1
  });

  $("#avatares-edit-trigger").on('click', function(e){
    e.preventDefault();
    $("#js-avatares-picture").trigger('click');
  });
});
