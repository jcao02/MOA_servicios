class SessionsController < Devise::SessionsController

  def create
    puts "----------------"
    puts "INICIANDO SESION"
    puts "----------------"

    super
    logs = Logsesion.new(:usuario_id => current_usuario.id, 
                         :superu_id => current_usuario.id,
                         :tipo => "Login", 
                         :nusuario => current_usuario.login, 
                         :nsuperu => current_usuario.login)

    logs.save
  end


  def destroy
    puts "----------------"
    puts "CERRANDO SESION"
    puts "----------------"

    logs = Logsesion.new(:usuario_id => current_usuario.id, 
                         :superu_id => current_usuario.id,
                         :tipo => "Logout", 
                         :nusuario => current_usuario.login, 
                         :nsuperu => current_usuario.login)

    logs.save
    super
  end

end
