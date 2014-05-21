$( document ).ready( function() {

  editor = {} || editor;

  editor.layer = new Kinetic.Layer();

  editor.imageObj = new Image();
  editor.imageObj.onload = function() {
    editor.image = new Kinetic.Image({
      x: 0,
      y: 0,
      image: editor.imageObj,
      width: 400,
      height: 400
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
    y: 200,
    width: 200,
    text: "test",
    fontSize: 55,
    fontStyle: 'bold',
    fontFamily: 'Calibri',
    fill: 'black',
    strokeWidth: 2,
    strokeRed: 255,
    strokeBlue: 255,
    strokeGreen: 255,
    wrap: 'word'
  });
}



  editor.createData = function() {
    var canvas = $('canvas')[0];
    editor.dataToServer = canvas.toDataURL('image/png');
    $('#datainput').val(editor.dataToServer);
  };

  // editor.simpleText.offsetX(editor.simpleText.width()/2);

  editor.stage = new Kinetic.Stage({
    container: 'canvas',
    width: 400,
    height: 400
  });


  if ($('#canvas').attr('data')) {
    editor.imageObj.src = $('#canvas').attr('data');
  };

  editor.setup = function() {
   $('#message').keyup(function() {
         editor.simpleText.setText(editor.message());
         editor.layer.draw();
         editor.createData();
       });
 }

 editor.setup();

});