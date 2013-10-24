MOA Servicios
====================
Aplicacion que usa rails con:

Ruby >= 1.9.2


ARCHIVO CON EJEMPLO AJAX -> 
linea 35 app/assets/javascripts/usuarios.js.coffee
linea 124 app/controllers/usuarios_controller.rb
linea 131 app/views/usuarios/show.html.erb

NOTAS ->
1 -> Asegurarse del default de transcriptor
6 -> Revisar los js en listar usuarios cuando eres responsable pq hay un error que no deja esconder el loading
7 -> Al iniciar sesion o al finalizar sesion se registra en el log como si hubiera actualizado el usuario. Ocurre por el callback de after_update en el usuarios_observer
8 -> no logre hacer la funcion en ajax para obtener el show del documento