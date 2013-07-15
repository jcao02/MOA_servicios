namespace :alerts do

    desc "Actualiza la tabla de documentos vencidos"
    task :update => :environment do
        today = Date.today
        yearlater = today.to_time.advance(:years => 1)
        vencidos = Documentos.where("fecha_vencimiento <= #{yearlater}")

        vencidos.each do |v|
            producto = v.producto
            usuario  = v.usuario
            tipo     = v.TipoDocumento.descripcion
            fecha    = v.fecha_vencimiento
            # Conjunto para verificar que no exista la alerta
            existe      = Vencidos.where(
                :usuario_id  => usuario.id,
                :producto_id => producto.id,
                :fecha       => fecha,
                :tipo        => tipo ).length > 0
            # Solo se crea el vencido si no existe y no hay un tramite
            Vencidos.create(
                :usuario_id  => usuario.id,
                :producto_id => producto.id,
                :tipo        => tipo,
                :fecha       => fecha) unless existe or v.tramite
        end
    end

    desc "Revisa la tabla de documentos vencidos y manda correos a los usuarios"
    task :notify => :environment do
        vencidos = Vencidos.all
        vencidos.each do |v|
            CorreoUsuario.send_notification(v) unless (not active) or v.tramite
        end
    end
    
end
