# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
dataTable_opc =
  bScrollInfinite : true
  bScrollCollapse : true
  bPagination     : false
  bScrollAutoCss  : true
  bSort           : false
  sScrollY        : "250px"
  oLanguage       :
    sSearch       : "Búsqueda "
    sInfo         : ""
    sInfoFiltered : ""
    sInfoEmpty    : ""
    sZeroRecords  : "No se encontraron coincidencias"





$(document).ready ->
    $("#alerts_table").dataTable(dataTable_opc)

    alertSize = $('#alerts_length').data('length')
    binds = []

    for i in [0..alertSize + 1]
        $("#alert_form" + i).on "ajax:success", (event,data,status,xhr) ->
          $(this).closest('td').html xhr.responseText
        $("#activate_form" + i).on "ajax:success", (event,data,status,xhr) ->
          $(this).closest('td').html xhr.responseText

    return
