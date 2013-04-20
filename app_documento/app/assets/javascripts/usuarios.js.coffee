# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

dataTable_opc =
  bScrollInfinite: true
  bScrollCollapse: true
  bPagination    : false
  bScrollAutoCss : true
  sScrollY       : "250px"
  oLanguage :
    sSearch      : "Busqueda"
    sInfo        : ""
    sInfoFiltered: ""
    sInfoEmpty   : ""
    sZeroRecords : "No se encontraron coincidencias"

changePassDialog_opc = 
  width   : 350
  height  : 450
  scroll  : false
      


$(document).ready ->
  #Tipo de datos que se recibe por ajax html o strings
  $.ajaxSetup dataType: "html"
  #Datatables
  $(".tabla_list").dataTable(dataTable_opc)
  #Cambiar contraseña con ajax
  $("#cambiar_contr").click ->
    #Se crea funcion para generar el form para cambiarla
    $( this ).bind "ajax:success", (event, data, status, xhr) ->
      $("#dialog_contr").html xhr.responseText
    #Se muestra el form como un dialog
    $("#dialog_contr").dialog(changePassDialog_opc)
  #Se crea funcion para manejar el submit del form en caso de errores o exito
  $("#dialog_contr").bind("ajax:success", (event, data, status, xhr) ->
    str = xhr.responseText
    json = jQuery.parseJSON(str)  #parseo a json
    
    arr = new Array;

    for elem of json
      arr.push json[elem]
    #Si existen errores, se muestran.
    if arr.length > 0
      $('.errorpassword').remove()
      error = '<p class="errorpassword" style="color:red;">'
      for elem of arr
        error += arr[elem]
        error += '</br>'
      error += '</p>'
      $(this).prepend(error)
    #Si no, se muestra mensaje de error
    else
      mensaje = '<center><p style="color:green; font-size: 14px; margin-top:170px;">Contraseña cambiada exitosamente </p></center>'
      $(this).html mensaje
  #Funcion en caso de error (no deberia caer nunca aqui)
  ).bind("ajax:error", (xhr, data, status, error) -> alert "Error")
