$( document ).ready( function() {

  editor = {} || editor;

  editor.layer = new Kinetic.Layer();

  editor.imageObj = new Image();
  editor.imageObj.onload = function() {
    editor.image = new Kinetic.Image({
      x: 0,
      y: 0,
      image: editor.imageObj,
      width: 510,
      height: 510
    });
  

    if(editor.image) {

      editor.layer.add(editor.image);
      updateText();
      editor.layer.add(editor.simpleText)
      editor.stage.add(editor.layer);
    }
  }
  editor.message = function() {
    return $('#cheerup_message').val();
  };


updateText = function() {
  editor.simpleText = new Kinetic.Text({
    x: editor.stage.width() / 2,
    y: editor.stage.height() / 2,
    width: editor.stage.width() * 0.8,
    text: "",
    fontSize: 35,
    fontStyle: 'bold',
    fontFamily: 'Helvetica',
    fill: 'black',
    strokeWidth: 1,
    strokeRed: 255,
    strokeBlue: 255,
    strokeGreen: 255,
    wrap: 'word',
    align: 'center',
    draggable: true
  });
}



  editor.createData = function() {
    var canvas = $('canvas')[0];
    editor.dataToServer = canvas.toDataURL('image/png');
    $('#cheerup_image_data').val(editor.dataToServer);
  };

  

  editor.stage = new Kinetic.Stage({
    container: 'canvas',
    width: 510,
    height: 510
  });


  if ($('#canvas').attr('data')) {
    editor.imageObj.src = $('#canvas').attr('data');
  };

  editor.setup = function() {
   $('#cheerup_message').keyup(function() {
         editor.simpleText.setText(editor.message());
         editor.simpleText.offsetX(editor.simpleText.width()/2);
         editor.simpleText.offsetY(editor.simpleText.height()/2);
         editor.layer.draw();
         editor.stage.draw();
       });
    $('#submit').mousedown(function() {
        var x = editor.simpleText.getAbsolutePosition()["x"];
        var y = editor.simpleText.getAbsolutePosition()["y"];
        editor.simpleText.setAttr("x", x);
        editor.simpleText.setAttr("y", y);
        editor.layer.draw();
        editor.stage.draw();
        editor.createData();
    })
 }

 editor.setup();

});