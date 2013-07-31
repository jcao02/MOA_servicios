#encoding: UTF-8
class ApplicationController < ActionController::Base
  before_filter :authenticate_usuario!
  before_filter :set_locale
  protect_from_forgery

  def set_locale
    I18n.locale = params[:locale]
  end

  def default_url_options( options={} )
    { :locale => I18n.locale }
  end

  #Metodos helpers para Usuarios
  helper_method :is_owner
  def is_owner
    redirect_to(inicio_index_path) if current_usuario.id.to_s != params[:id]
  end

  helper_method :is_authorize
  def is_authorize
      redirect_to(inicio_index_path) if current_usuario.id.to_s != params[:id] and current_usuario.admin != 2
  end

  helper_method :is_admin
  def is_admin
      redirect_to(inicio_index_path) if current_usuario.admin == 0
  end

  #Para verificar que el usuario que va a ser deshabilitado no es Super Admin
  helper_method :change_s_admin
  def change_s_admin
    redirect_to(usuarios_index_path) if Usuarios.find(params[id]).admin == 2
  end
end
