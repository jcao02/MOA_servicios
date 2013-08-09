# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
datepickerOpc =
  minDate    : 0
  dateFormat : "yy-mm-dd" 
  dayNamesMin: ["Do","Lu","Ma","Mie","Jue","Vie","Sab"]
  monthNames : ["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"]
  changeYear : true

$(document).ready ->
  $("#presentacion_fecha_vencimiento").datepicker datepickerOpc
  $("#presentacion_documentos_attributes_0_fecha_vencimiento").datepicker datepickerOpc
