# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

datepickerOpc =
  minDate    : 0
  dateFormat : "yy-mm-dd" 
  changeYear : true

$(document).ready ->
  $("#documento_fecha_vencimiento").datepicker datepickerOpc
  $("#documento_TipoDocumento_attributes_descripcion").change ->
    if $(this).val() == "Otro"
      input = '<input id="Otro_tipo_input" type="text" maxlength="255" name="documento[TipoDocumento_attributes][descripcion]"/>'
      $("#Otro").prepend input
    else
      $("#Otro_tipo_input").remove()
