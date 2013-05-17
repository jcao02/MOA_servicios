# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#Seteando atributos de la dataTable
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

dataTable_opcS =
  bScrollInfinite : true
  bScrollCollapse : true
  bPagination     : false
  bScrollAutoCss  : true
  bFilter         : false
  sScrollY        : "250px"
  oLanguage       :
    sSearch       : ""
    sInfo         : ""
    sInfoFiltered : ""
    sInfoEmpty    : ""
    sZeroRecords  : "No se encontraron coincidencias"


$(document).ready ->
    $("#input_producto_tramite").val()
    $("#producto_tramite").dataTable(dataTable_opc)
    $("#tipo_tramite").dataTable(dataTable_opc)
    $("#requisitos_show").dataTable(dataTable_opcS)
    $("#solicitud_tramite_filtro").dataTable(dataTable_opcS)
    $("#tipo_tramite_filtro").dataTable(dataTable_opcS)
    $("#producto_tramite tbody").click (event) ->
        seleccion = event.target
        $("#producto_selected").removeAttr("id")
        $(seleccion).attr("id", "producto_selected")
        valor = $("#producto_selected").data('productos').id
        $("#input_producto_tramite").val valor
    $("#tipo_tramite tbody").click (event) ->
        seleccion = event.target
        $("#tipo_selected").removeAttr("id")
        $(seleccion).attr("id", "tipo_selected")
        valor = $("#tipo_selected").data('tipo').id
        $("#input_tipodoc_tramite").val valor

    # c = document.getElementsByClassName("estados");
    # for i of c
    #     ctx=c[i].getContext("2d");
    #     ctx.beginPath();
    #     ctx.arc(95,50,40,0,2*Math.PI);
    #     ctx.stroke();
