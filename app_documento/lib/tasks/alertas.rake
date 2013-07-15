namespace :alerts do

    desc "Actualiza la tabla de documentos vencidos"
    task :update => :environment do
        today = Date.today
        yearlater = today.to_time.advance(:years => 1).to_date
        print "Fecha: #{Date.today}\n"
        print "Actualizando tabla de vencidos."
        vencidos = Documento.where("date(fecha_vencimiento) <= ? ", yearlater.to_s(:db))
        print "\rActualizando tabla de vencidos.."
        vencidos.each do |v|
            producto = v.producto
            usuario  = v.producto.usuario
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
                :fecha       => fecha) unless existe
        end
        print "\rActualizando tabla de vencidos...OK\n"
    end

    desc "Revisa la tabla de documentos vencidos y manda correos a los usuarios"
    task :notify => :environment do
        vencidos = Vencidos.all
        print "Enviando correos a vencidos..."
        vencidos.each do |v|
            CorreosUsuario.send_notification(v).deliver unless (not v.active) or v.tramite
        end
        print "\rEnviando correos a vencidos...OK\n"
    end

    desc "Actualiza vencidos y manda correos a usuarios"
    task :generate => [:update, :notify]
end
