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
    sSearch       : ""
    sInfo         : ""
    sInfoFiltered : ""
    sInfoEmpty    : ""
    sZeroRecords  : "No se encontraron coincidencias"





#createFunc = (i) -> 
    #(event, data, status, xhr) -> 
        #alert "alert_state " + i
        #$("#alert_state" + i).html xhr.responseText
        #return

$(document).ready ->
    $("#alerts_table").dataTable(dataTable_opc)

    #alertSize = $('#alerts_length').data('length')
    #binds = []
    #for i in [0..alertSize + 1 ]
        #binds[i] = createFunc i 

    #for i in [0..alertSize + 1]
        #$("#alert_form" + i).on "ajax:success", binds[i](event,data,status,xhr)

    #return
