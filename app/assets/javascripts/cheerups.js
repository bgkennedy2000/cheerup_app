$( document ).ready( function() {

  editor = {} || editor;

// create layer to house images and text

  editor.layer = new Kinetic.Layer();

// create image from the editor.imageObj

  editor.imageObj = new Image();
  editor.imageObj.onload = function() {
    editor.image = new Kinetic.Image({
      x: 0,
      y: 0,
      image: editor.imageObj,
      width: 510,
      height: 510
    });
  
// only exectute creating and adding the text and image to the layer and then the layer to the stage if an image is present

    if(editor.image) {

      editor.layer.add(editor.image);
      updateText();
      editor.layer.add(editor.simpleText)
      editor.stage.add(editor.layer);
    }
  }

// set the text to the value in the cheerup message input field

  editor.message = function() {
    return $('#cheerup_message').val();
  };


// creates the basic text

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

// a function to update the data attribute of the image_data hidden field with a base64 representation of the canvase image.  Through the hidden field, the data is added to the params

  editor.createData = function() {
    var canvas = $('canvas')[0];
    editor.dataToServer = canvas.toDataURL('image/png');
    $('#cheerup_image_data').val(editor.dataToServer);
  };

  
  // creates a canvas element inside the div w/ id"canvas" and sets this element as the stage

  editor.stage = new Kinetic.Stage({
    container: 'canvas',
    width: 510,
    height: 510
  });

// if the data element in the div#canvas exists, set this data as the imageObj.  The data is a url to the locally hosted image file

  if ($('#canvas').attr('data')) {
    editor.imageObj.src = $('#canvas').attr('data');
  };

// setup keyup functions to update the canvase with the text

  editor.setup = function() {
   $('#cheerup_message').keyup(function() {
         editor.simpleText.setText(editor.message());
         editor.simpleText.offsetX(editor.simpleText.width()/2);
         editor.simpleText.offsetY(editor.simpleText.height()/2);
         editor.layer.draw();
         editor.stage.draw();
       });

   // on mousedown, redraw the image with the updated x and y coordinates of the text location then execute the assignment of base64 data
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