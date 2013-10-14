#encoding: UTF-8
class ApplicationController < ActionController::Base
  before_filter :authenticate_usuario!
  before_filter :set_current_usuario
  protect_from_forgery

  #Metodos para Usuarios
  def set_current_usuario
    Usuario.current = current_usuario
  end
  def is_owner
    redirect_to(inicio_index_path) if current_usuario.id.to_s != params[:id]
  end

  def is_authorize
    redirect_to(inicio_index_path) if current_usuario.id.to_s != params[:id] and current_usuario.admin != 2
  end

  def is_admin
    redirect_to(inicio_index_path) if current_usuario.admin == 0
  end

  def is_alert_owner
    alerta = Vencidos.find(params[:id])
    redirect_to(inicio_index_path) if current_usuario.id != alerta.usuario_id
  end

  def is_sadmin
    redirect_to(inicio_index_path) if current_usuario.admin < 2
  end

  def is_transcriptor
    if current_usuario.admin != 2
      redirect_to(inicio_index_path) if not current_usuario.transcriptor
    end
  end
  
  def is_responsable
    if current_usuario.admin != 2
      redirect_to(inicio_index_path) if not current_usuario.reponsable
    end
  end
  #Actualizacion de alertas
  def actualizar_alertas
    puts params[:controller]
    session[:alerts] = Vencidos.order("fecha").where(:usuario_id => current_usuario.id)
    arraySum = session[:alerts].map{|x| if x.tramitando then 0 else 1 end}
    session[:alerts_length] = arraySum.inject(0){ |sum,x| sum + x}
  end



  # on == 0 => no muestra <= return 0
  # on == 1 => muestra <= return 1
  # error <= return 2
  def ocultar_prod (id)
    prod = Producto.find(id)
    on = 1
    on = 0 unless prod.on == 0
    if prod.update_attribute("on",on)
      return 0
    else
      return 2
    end
  end


  # oculta todos los productos del usuario con id = usr_id
  # si ocurre algun problema devuelve false
  # de lo contrario devuelve true
  def ocultar_prod_usr (usr_id)
    prod = Producto.where( :usuario_id => usr_id)

    prod.each do |p|
      if ocultar_prod(p.id) == 2
        return false
      end
    end

    return true
  end


end
