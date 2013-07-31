# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#Seteando atributos de la dataTable
dataTable_opc =
  bScrollInfinite: true
  bScrollCollapse: true
  bPagination    : false
  bScrollAutoCss : true
  sScrollY       : "320px"
  oLanguage :
    sSearch      : "Búsqueda"
    sInfo        : ""
    sInfoFiltered: ""
    sInfoEmpty   : ""
    sZeroRecords : "No se encontraron coincidencias"


$(document).ready ->
  $("#tabla_show_log_tram").dataTable(dataTable_opc)
