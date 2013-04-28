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
    sSearch      : "Búsqueda"
    sInfo        : ""
    sInfoFiltered: ""
    sInfoEmpty   : ""
    sZeroRecords : "No se encontraron coincidencias"

changePassDialog_opc = 
  width   : 350
  height  : 450
  title   : 'Cambiar Contraseña'

askPassDialog_opc = 
  width  : 320
  height : 250
  title  : 'Recuperar Contraseña'
      


$(document).ready ->
  #Tipo de datos que se recibe por ajax html o strings
  $.ajaxSetup dataType: "html"
  #Datatables
  $("#tabla_list_usuario").dataTable dataTable_opc
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
      mensaje = '<center><p style="color:green; font-size: 14px; margin-top:170px;">Contraseña cambiada exitosamente! </p></center>'
      $(this).html mensaje
  #Funcion en caso de error (no deberia caer nunca aqui)
  ).bind("ajax:error", (xhr, data, status, error) -> alert "Error")

  $("#ask_password").click ->
    #Se crea funcion para generar el form para cambiarla
    $( this ).bind("ajax:success", (event, data, status, xhr) ->
      $("#dialog_recover").dialog "option", "buttons", {}
      $("#dialog_recover").html xhr.responseText
    ).bind("ajax:error", (xhr, data, status, error) -> alert data.responseText)
    $("#dialog_recover").dialog askPassDialog_opc

  $("#dialog_recover form").submit ->
    $(this + ' input[type="submit"]').css "value", "Enviando..."
  $("#dialog_recover").bind("ajax:beforeSend", () -> 
    mensaje = '<p>Por razones de seguridad, usted será contactado para confirmar un cambio de contraseña a su correo o teléfono</p>'
    $(this).html mensaje
    $(this).dialog "option", "buttons",
      Aceptar: ->
        $( this ).dialog "close"
  ).bind("ajax:error", (xhr, data, status, error) -> alert "Error")
