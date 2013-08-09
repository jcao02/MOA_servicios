// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .
//= require jquery.formalize
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.bootstrap
//= require jquery.ui.all

$(document).ready(function() {
  $('body').css("background-image", "url(/assets/fondo" + (Math.round(1 * Math.random())) + ".png)");
})

//Toggle menus de usuario
$(document).ready(function() {
  $('#compania').click(function () {
    $('#companiaAppear').toggle();
  });
  $('#alertas').click(function () {
    $('#alertasAppear').toggle();
  });
})

//Si presiona una tecla
$(document).keyup(function(e) {
  if (e.keyCode == 27) {  //esc
    $('#companiaAppear').toggle(false);
    $('#alertasAppear').toggle(false);
  }
});

//Toggle si clickea otro sitio
$('html').click(function(event) {
  if (event.target.id != 'compania') {
    $('#companiaAppear').toggle(false);
  }
  if (event.target.id != 'alertas') {
    $('#alertasAppear').toggle(false);
  }
});

$(document).ready( function() {
  $('#deletesuccess').delay(5000).fadeOut();
});
