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

    helper_method :is_alert_owner
    def is_alert_owner
        alerta = Vencidos.find(params[:id])
        redirect_to(inicio_index_path) if current_usuario.id != alerta.usuario_id
    end

    #Crea los requisitos dependiendo del tramite
    helper_method :crear_requisitos
    def crear_requisitos(documento, tramite)
        dependencias = Dependencia.where(:tipo_documento_id => documento)
        dependencias.each do |d|
            req = Requisito.new(:estado => "Sin recibir", :tramite_id => tramite.id, :TipoRequisito_id => d.tipo_requisito_id)
            tramite.requisitos << req
        end
    end
end
