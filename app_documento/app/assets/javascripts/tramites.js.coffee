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
  bSort           : false
  sScrollY        : "250px"
  oLanguage       :
    sSearch       : ""
    sInfo         : ""
    sInfoFiltered : ""
    sInfoEmpty    : ""
    sZeroRecords  : "No se encontraron coincidencias"




#adjunta textarea para observaciones en requisitos rechazados
addObservacion = (elem, id) ->
    textarea = '<textarea rows="3" id="'+id+'" class="textarea-obs"">Agregue observacion</textarea>'
    elem.append textarea
#elimina textarea para observaciones en requisitos rechazados
rmvObservacion = (elem) ->
    $(elem).remove "textarea-obj"


#Genera circulos de canvas para estados
crearCanvas = (clase) ->
     n = document.getElementsByClassName(clase).length
     for i in [0...n]
         elem = $("#estado"+i)
         req = elem.data('requisito')
         color = req.estado if req
         elem.append '<canvas id="canvas-estado'+i+'" class="estados" width="16" height="16"></canvas>'
         c = document.getElementById "canvas-estado"+i
         crearCirculo c, color if c

#Crea un circulo dado un canvas y un color
crearCirculo = (elem, color) ->
     switch color
         when 0
            color = "white"
         when 1
            color = "blue"
         when 2
            color = "yellow"
         when 3
            color = "green"
         when 4
            color = "red"
         else
            color = "white"

     ctx = elem.getContext("2d");
     w   = elem.width / 2
     h   = elem.height / 2
     ctx.beginPath();
     ctx.arc(w, h, w, 0, 2 * Math.PI);
     ctx.fillStyle = color
     ctx.fill()
     ctx.stroke();

 

$(document).ready ->
    $("#input_producto_tramite").val()
    $("#producto_tramite").dataTable(dataTable_opc)
    $("#tipo_tramite").dataTable(dataTable_opc)
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
    
    crearCanvas "content-estado"
    crearCanvas "content-tramite"

    $(".boxes input").click ->
        id = "#"+this.name
        estado = document.getElementsByName "requisito[estado"+this.name+"]"
        estado[0].value = this.value
        observacion = document.getElementsByName "requisito[observacion"+this.name+"]"
        if this.value == "4"
            $(observacion[0]).show()
        else if this.value != "4"
            $(observacion[0]).hide()
            

    $("#enviar_cambios").click ->
        $("#form_edit_req").submit()



