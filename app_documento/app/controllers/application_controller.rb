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

    #Metodos helpers para alertas

    helper_method :is_alert_owner
    def is_alert_owner
        alerta = Vencidos.find(params[:id])
        redirect_to(inicio_index_path) if current_usuario.id != alerta.usuario_id
    end

    #Metodos helpers para tramites
    #Crea los requisitos dependiendo del tramite
    helper_method :crear_requisitos
    def crear_requisitos(documento, tramite)
        dependencias = Dependencia.where(:tipo_documento_id => documento)
        dependencias.each do |d|
            req = Requisito.new(:estado => "Sin recibir", :tramite_id => tramite.id, :TipoRequisito_id => d.tipo_requisito_id)
            tramite.requisitos << req
        end
    end

    helper_method :ocultar_prod
    # on == 0 => no muestra <= return 0
    # on == 1 => muestra <= return 1
    # error <= return 2
    def ocultar_prod (id)
        prod = Producto.find(id)
        if prod.on == 0
            if prod.update_attribute("on",1)
                return 1
            else
                return 2
            end
        elsif prod.on == 1
            if prod.update_attribute("on",0)
                return 0
            else
                return 2
            end
        end
    end

    helper_method :ocultar_prod_usr
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
