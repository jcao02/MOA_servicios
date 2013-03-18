# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


dataTable_opc = 
  bScrollInfinite: true
  bScrollCollapse: true
  bPagination    : false
  sScrollY       : "400px"
  oLanguage :  
    sSearch      : "Filtro: "
          

$(document).ready -> 
  $("#mis_productos").dataTable(dataTable_opc)
  $("#mis_solicitudes").dataTable(dataTable_opc)
