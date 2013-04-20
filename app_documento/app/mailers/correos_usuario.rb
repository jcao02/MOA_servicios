class CorreosUsuario < ActionMailer::Base
  default from: "productosKiwi@gmail.com"

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

  def recuperar_contrasena(usuario)
    @usuario = usuario
    mail(:to => "productosKiwi@gmail.com", :subject => "Solicitud de recuperacion de contrasena")
  end
end
