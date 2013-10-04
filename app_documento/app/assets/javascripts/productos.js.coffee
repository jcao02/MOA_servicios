# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#Seteando atributos de la dataTable
dataTable_opc =
  bScrollInfinite: true
  bScrollCollapse: true
  bPagination    : false
  bScrollAutoCss : true
  sScrollY       : "300px"
  oLanguage :
    sSearch      : ""
    sInfo        : ""
    sInfoFiltered: ""
    sInfoEmpty   : ""
    sZeroRecords : "No se encontraron coincidencias"

datepickerOpc =
  minDate    : 0
  dateFormat : "yy-mm-dd" 
  dayNamesMin: ["Do","Lu","Ma","Mie","Jue","Vie","Sab"]
  monthNames : ["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"]
  changeYear : true

  
$(document).ready ->
  $("#producto_grado_alcoholico_input").hide()
  $("#productos").dataTable dataTable_opc 
  $("#marcas").dataTable dataTable_opc
  marcasDisponibles      = $("#autocomplete").data("marcasdisponibles")
  fabricantesDisponibles = $("#autocomplete").data("fabricantesdisponibles")
  $("#producto_marca").autocomplete source : marcasDisponibles
  $("#producto_fabricante").autocomplete source : fabricantesDisponibles
  #Fltrado
  #Por marca
  $("#marcas tbody tr").click ->
    $(this).toggleClass "success"
    
    coleccion = document.getElementsByClassName "success"
    if (coleccion.length == 0)
      inputs = document.getElementsByClassName "producto_marca"
      for index, elem of inputs
        if elem.parentNode
          elem.parentNode.removeChild(elem);
    else
      input = '<input class="producto_marca" type="hidden" '
      n = coleccion.length - 1
      for i in [0..n]
        input += 'name="producto[marca]['+i+']" '+'value="'+coleccion[i].innerText+'"'+' />'
        input += ' <input class="producto_marca" type="hidden" '
      $("#marca_inputs").html input

    $("#marca_form").submit()
    $("#marca_form").bind "ajax:success", (event, data, status, xhr) -> 
      $("#body_prod").html xhr.responseText
  
  #Por procedencia
  $("#Procedencia_prod tbody").click (event) ->
    $("#arrow_proc").remove()
    imagen = '<img id="arrow_proc" src="/assets/flecha_select.png"/>'
    $(event.target).append imagen
    proc = event.target.innerText
    elem = document.getElementById "proc_input"
    elem.value = proc
    value = elem.value
    $("#proc_form").submit()
    #En caso de exito se filtran las tablas
    $("#proc_form").bind "ajax:success", (event, data, status, xhr) -> 
      $("#body_prod").html xhr.responseText

  #Por tipo
  $("#Tipo_prod tbody").click (event) ->
    $("#arrow_tipo").remove()
    imagen = '<img id="arrow_tipo" src="/assets/flecha_select.png"/>'
    $(event.target).append imagen
    tipo = event.target.innerText
    input = document.getElementById "type_input"
    input.value = tipo
    $("#type_form").submit()
    $("#type_form").bind "ajax:success", (event, data, status, xhr) -> 
      $("#body_prod").html xhr.responseText
  
  $("#producto_alimento_true").change ->
    if $(this).val() == "true"
      $("#producto_grado_alcoholico_input").hide()
      $("#producto_grado_alcoholico_input").val 0

  $("#producto_alimento_false").change ->
    if $(this).val() == "false"
      $("#producto_grado_alcoholico_input").show()

  #AJAX para pestañas en show
  $("#show-importadores").bind "ajax:success", (event, data, status, xhr) -> 
    $("#extra-productos").html xhr.responseText
  $("#show-documentos").bind "ajax:success", (event, data, status, xhr) -> 
    $("#extra-productos").html xhr.responseText
  $("#show-presentaciones").bind "ajax:success", (event, data, status, xhr) -> 
    $("#extra-productos").html xhr.responseText

  #Importador existente
  $("#importador-existente-form").bind "ajax:success", (event, data, status, xhr) -> 
    $("#extra-productos").html xhr.responseText
  $("#importador-existente-form").submit -> 
    $("#importador-existente").dialog "close"

 
  #JavaScript para expedientes

  $(".add_nested_fields").mouseup ->
    inputs = $(".vence_documento")
    n      = inputs.length
    for x in [0..n+1]
      $(inputs[x]).datepicker datepickerOpc
