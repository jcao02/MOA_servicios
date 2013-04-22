# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#Seteando atributos de la dataTable
dataTable_opc =
  bScrollInfinite: true
  bScrollCollapse: true
  bPagination    : false
  bScrollAutoCss : true
  sScrollY       : "250px"
  oLanguage :
    sSearch      : "Filtrar"
    sInfo        : ""
    sInfoFiltered: ""
    sInfoEmpty   : ""
    sZeroRecords : "No se encontraron coincidencias"

# asInitVals = new Array()
# $(document).ready ->
#   oTable = $("#productos").dataTable(dataTable_opc)
#   $("tfoot input").keyup ->

#     # Filter on the column (the index) of this element
#     oTable.fnFilter @value, $("tfoot input").index(this)


#   # Support functions to provide a little bit of 'user friendlyness' to the textboxes in
#   # the footer
#   $("tfoot input").each (i) ->
#     asInitVals[i] = @value

#   $("tfoot input").focus ->
#     if @className is "search_init"
#       @className = ""
#       @value = ""

#   $("tfoot input").blur (i) ->
#     if @value is ""
#       @className = "search_init"
#       @value = asInitVals[$("tfoot input").index(this)]

$(document).ready ->
  $("#productos").dataTable(dataTable_opc).columnFilter aoColumns: [
      type: "select"
      values: ["Nacional", "Importado"]
    ,
      type: "text"
    ,
      type: "select"
      values: ["Alimento", "Bebida"]
    ,
      null
    ,
      type: "text"
  ]
