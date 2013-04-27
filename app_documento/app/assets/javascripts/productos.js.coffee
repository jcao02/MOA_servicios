# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#Seteando atributos de la dataTable
dataTable_opc =
  bScrollInfinite: true
  bScrollCollapse: true
  bPagination    : false
  bScrollAutoCss : true
  sScrollY       : "269px"
  oLanguage :
    sSearch      : ""
    sInfo        : ""
    sInfoFiltered: ""
    sInfoEmpty   : ""
    sZeroRecords : "No se encontraron coincidencias"

dataTableM_opc =
  bScrollInfinite: true
  bScrollCollapse: true
  bPagination    : false
  bScrollAutoCss : true
  sScrollY       : "269px"
  oLanguage :
    sSearch      : ""
    sInfo        : ""
    sInfoFiltered: ""
    sInfoEmpty   : ""
    sZeroRecords : "No se encontraron coincidencias"
  oTableTools :
    sRowSelect   : "multi"

#Elimina la clase clase de los td de la tabla elem
eliminar_class = (elem, clase) ->
  elems = "#"+elem.id + " tr td"
  $(elems).removeClass clase


$(document).ready ->
  $("#productos").dataTable dataTable_opc 
  $("#marcas").dataTable dataTableM_opc 
  marcasDisponibles      = $("#autocomplete").data("marcasdisponibles")
  fabricantesDisponibles = $("#autocomplete").data("fabricantesdisponibles")
  $("#producto_marca").autocomplete source : marcasDisponibles
  $("#producto_fabricante").autocomplete source : fabricantesDisponibles
  #Fltrado
  #Por marca
  $("#marcas tr").click ->
    $(this).toggleClass "row_selected"
    
    coleccion = document.getElementsByClassName "row_selected"
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
  $("#Procedencia_prod").click (event) ->
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
  $("#Tipo_prod").click (event) ->
    $("#arrow_tipo").remove()
    imagen = '<img id="arrow_tipo" src="/assets/flecha_select.png"/>'
    $(event.target).append imagen
    tipo = event.target.innerText
    input = document.getElementById "type_input"
    input.value = tipo
    $("#type_form").submit()
    $("#type_form").bind "ajax:success", (event, data, status, xhr) -> 
      $("#body_prod").html xhr.responseText
