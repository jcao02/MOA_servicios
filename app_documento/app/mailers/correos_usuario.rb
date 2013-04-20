class CorreosUsuario < ActionMailer::Base
  default from: "jcarochaov@gmail.com"

  def enviar_contrasena(usuario, contrasena)
    @contrasena = contrasena 
    @usuario = usuario
    @url = "http://www.aplicacionX.com"
    mail(:to => usuario.email, :subject => "Bienvenido a NombredelaAcplicacion")
  end
end
