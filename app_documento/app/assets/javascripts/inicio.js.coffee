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
    sSearch      : "Búsqueda"
    sInfo        : ""
    sInfoFiltered: ""
    sInfoEmpty   : ""
    sZeroRecords : "No se encontraron coincidencias"


$(document).ready ->
  $("#mis_productos").dataTable(dataTable_opc)
  $("#mis_solicitudes").dataTable(dataTable_opc)
