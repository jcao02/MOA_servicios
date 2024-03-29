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
  $("#presentacion_id_form").hide()
  $("#importador_id_form").hide()
  $("#documento_fecha_vencimiento").datepicker datepickerOpc
  $("#documento_TipoDocumento_attributes_descripcion").change ->
    if $(this).val() == "Otro"
      input = '<div class="string input required stringish control-group" '
      input += 'id="documento_TipoDocumento_attributes_descripcion_input">'
      input += '<label class=" control-label" for="Otro_tipo_input">Otro</label>'
      input += '<div class="controls">'
      input += '<input id="Otro_tipo_input" type="text" maxlength="255" name="documento[TipoDocumento_attributes][descripcion]"/>'
      input += '</div></div>'
      $("#Otro").html input
      $("#presentacion_id_form").hide()
      $("#presentacion_id_input").prop 'disable', true
      $("#importador_id_form").hide()
      $("#importador_id_input").prop 'disable', true
    else if $(this).val() == "Inclusión de Importador"
      $("#importador_id_form").show()
      $("#importador_id_input").prop 'disable', false
      $("#Otro").html ''
      $("#presentacion_id_form").hide()
      $("#presentacion_id_input").prop 'disable', true

    else if $(this).val() == "Cambio o inclusión de nueva presentación"
      $("#presentacion_id_form").show()
      $("#presentacion_id_input").prop 'disable', false
      $("#Otro").html ''
      $("#importador_id_form").hide()
      $("#importador_id_input").prop 'disable', true
    else
      $("#Otro").html ''
      $("#presentacion_id_form").hide()
      $("#presentacion_id_input").prop 'disable', true
      $("#importador_id_form").hide()
      $("#importador_id_input").prop 'disable', true
  $("#show_documentos").dataTable(dataTable_opc)

  $(".link_documento").click -> 
      $(this).closest('form').submit()
