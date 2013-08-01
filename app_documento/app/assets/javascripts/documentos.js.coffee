# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

datepickerOpc =
  minDate    : 0
  dateFormat : "yy-mm-dd" 
  dayNamesMin: ["Do","Lu","Ma","Mie","Jue","Vie","Sab"]
  monthNames : ["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"]
  changeYear : true
dataTable_opc =
  bScrollInfinite : true
  bScrollCollapse : true
  bPagination     : false
  bScrollAutoCss  : true
  bSort           : false
  sScrollY        : "250px"
  oLanguage       :
    sSearch       : ""
    sInfo         : ""
    sInfoFiltered : ""
    sInfoEmpty    : ""
    sZeroRecords  : "No se encontraron coincidencias"


$(document).ready ->
  $("#documento_fecha_vencimiento").datepicker datepickerOpc
  $("#documento_TipoDocumento_attributes_descripcion").change ->
    if $(this).val() == "Otro"
      input = '<input id="Otro_tipo_input" type="text" maxlength="255" name="documento[TipoDocumento_attributes][descripcion]"/>'
      $("#Otro").prepend input
    else
      $("#Otro_tipo_input").remove()
  $("#show_documentos").dataTable(dataTable_opc)
