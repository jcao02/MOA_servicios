#encoding: UTF-8
class CorreosUsuario < ActionMailer::Base
  default from: "productosKiwi@gmail.com"

  #Mail que se le manda al usuario con una contraseña nueva
  def enviar_contrasena(usuario, contrasena, modo)
    @contrasena = contrasena 
    @usuario = usuario
    @modo = modo
    if modo == 1
      asunto = "Bienvenido a ProductosKiwi"
    else
      asunto = "Recuperacion de contrasena"
    end
    @url = "http://www.aplicacionX.com"
    mail(:to => usuario.email, :subject => asunto)
  end

  #Mail que se le envia al administrador para aceptar
  #o rechazar una recuperacion de contraseña
  def recuperar_contrasena(usuario)
    @usuario = usuario
    mail(:to => "productosKiwi@gmail.com", :subject => "Solicitud de recuperacion de contrasena")
  end

  #Mail que se le envia al usuario con cambios en sus requsitos de un tramite
  def aviso_requisitos(usuario, lista, tramite)
    @lista = lista  
    @tramite = tramite
    asunto = "Hola " + usuario.nombre + ", hubo un cambio en el estado de una de tus solicitudes de trámites"
    mail(:to => usuario.email, :subject => asunto)
  end

  #Mail que avisa que un tramite ya fue completado
  def aviso_tramite(usuario, tramite)
    @tramite = tramite
    @usuario = usuario
    asunto = "Hola " + usuario.nombre + ", una de tus solicitudes de trámite se ha completado!"
    mail(:to => usuario.email, :subject => asunto)
  end

  #Mail que avisa el vencimineto de un documento
  def send_notification(vencido)
      @usuario  = Usuario.find(vencido.usuario_id)
      @producto = Producto.find(vencido.producto_id)
      @tipo     = vencido.tipo
      actual    = Date.today
      vence     = vencido.fecha
      @mes      = (vence.year * 12 + vence.month) - (actual.year * 12 + actual.month)
      asunto    = "Alerta de vencimiento de #{@tipo} del producto #{@producto.nombre}"

      mail(:to => @usuario.email, :subject => asunto)
  end
end
