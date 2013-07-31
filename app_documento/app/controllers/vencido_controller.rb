class VencidoController < ApplicationController
    before_filter :is_alert_owner, :only => [:tramitar_documentos, :activar_alerta, :desactivar_alerta]

    #Ver todas las alertas
    def index
    end

    #Tramitar documento vencido
    def tramitar_documento
        alerta     = Vencidos.find(params[:id])
        tipodoc    = TipoDocumento.where(:descripcion => alerta.tipo)
        tipodoc_id = tipodoc[0].id
        tramite    = Tramite.new(
            :estado           => 0,
            :usuario_id       => current_usuario.id,
            :producto_id      => alerta.producto_id,
            :recibido         => false,
            :TipoDocumento_id => tipodoc_id
        )
        crear_requisitos(tipodoc_id, tramite)
        tramite.save
        alerta.update_attributes({:tramite => true})            
        session[:alerts] = Vencidos.order("fecha").where(:usuario_id => current_usuario.id)
        render :index
    end

    #Activar alerta (si estaba desactivada)
    def activar_alerta
        alerta = Vencidos.find(params[:id])
        if alerta.update_attributes({:active => true})
            session[:alerts] = Vencidos.order("fecha").where(:usuario_id => current_usuario.id)
            render :index
        else
            flash[:notice] = "No se pudo activar la alerta, intenta mas tarde"
        end
    end

    #Desactivar alerta (si estaba activada)
    def desactivar_alerta
        alerta = Vencidos.find(params[:id])
        if alerta.update_attributes({:active => false})
            session[:alerts] = Vencidos.order("fecha").where(:usuario_id => current_usuario.id)
            render :index
        else
            flash[:notice] = "No se pudo desactivar la alerta, intenta mas tarde"
        end

    end
end
