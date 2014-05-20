# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

alert("js loaded");

#editor = {} || editor
#
#editor.stage = new Kinetic.Stage({
#  container: 'container',
#  width: 400,
#  height: 400
#});
#editor.layer = new Kinetic.Layer();

# editor.imageObj = new Image();
# editor.imageObj.onload = function() {
#   editor.image = new Kinetic.Image({
#     x: 10,
#    y: 10,
#    image: editor.imageObj,
#    width: 400,
#    height: 400
#  });
#
#editor.message = function() {
#  return $('#message').val();
#}
#
#updateText = function() {
#  editor.simpleText = new Kinetic.Text({
#  x: editor.stage.width() / 2,
#  y: 200,
#  width: 200,
#  text: editor.message(),
#  fontSize: 55,
#  fontStyle: 'bold',
#  fontFamily: 'Calibri',
#  fill: 'green',
#  strokeWidth: 2,
#  strokeRed: 255,
#  strokeBlue: 255,
#  strokeGreen: 255,
#  wrap: 'word'
#});
#}
#
#updateText();
#
#editor.createData = function() {
#  var canvas = $('canvas')[0];
#  editor.dataToServer = canvas.toDataURL('image/png');
#  $('#datainput').val(editor.dataToServer);
#}
#
#editor.simpleText.offsetX(editor.simpleText.width()/2);
#
#  // add the image to the layer
#  editor.layer.add(editor.image);
#  editor.layer.add(editor.simpleText)
#
#  // add the layer to the stage
#  editor.stage.add(editor.layer);
#};
#editor.imageObj.src = $('#container').attr('data');
#
#editor.setup = function() {
#    $('#message').keyup(function() {
#        editor.simpleText.setText(editor.message());
#        editor.layer.draw();
#        editor.createData();
#  });
#}
#
#$(editor.setup);