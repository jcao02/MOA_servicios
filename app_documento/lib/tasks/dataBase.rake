#encoding: UTF-8
namespace :set do
  desc "Crea 3 usuarios: S-Admin, Admin y Cliente"
  task :users => :environment do 
    Rake::Task['db:reset'].invoke
    Usuario.create(
      :login    => "S-Admin", 
      :password => "12345678", 
      :email    => "s-admin@dominio.com", 
      :telefono => "12345678", 
      :admin    => 2, 
      :compania => "S-Administradora",
      :nombre   => "S-Admin",
      :apellido => "istrador"
    )
    Usuario.create(
      :login    => "Admin", 
      :password => "12345678", 
      :email    => "admin@dominio.com", 
      :telefono => "12345678", 
      :admin    => 1, 
      :compania => "Administradora",
      :nombre   => "Admin",
      :apellido => "istrador",
    )
    Usuario.create(
      :login    => "Cliente", 
      :password => "12345678", 
      :email    => "cliente@dominio.com", 
      :telefono => "12345678", 
      :admin    => 0, 
      :compania => "Alimentos X",
      :nombre   => "Cliente",
      :apellido => "la"
    )
  end
  
  desc "Crea 4 productos para el usuario de id 2"
  task :products => :environment do
    Producto.create(
      :registro_sanitario => "A-12.345",
      :alimento           => true,
      :nombre             => "Harina de Trigo",
      :marca              => "Harina Pan",
      :pais_elaboracion   => "VE",
      :fabricante         => "Fabricante X",
      :codigo_arancelario => "100.100",
      :usuario_id         => 3,
      :zona_venta         => "Margarita"
    )
    Producto.create(
      :registro_sanitario => "L-12.346",
      :alimento           => false,
      :nombre             => "Ron Blanco",
      :marca              => "Santa Teresa",
      :pais_elaboracion   => "VE",
      :fabricante         => "Ron Santa Teresa",
      :codigo_arancelario => "100.101",
      :usuario_id         => 3,
      :zona_venta         => "Tierra Firme",
      :grado_alcoholico   => "40º"
    )
    Producto.create(
      :registro_sanitario => "A-12.347",
      :alimento           => true,
      :nombre             => "Aceitunas rellenas con pimiento asado",
      :marca              => "Jolca",
      :pais_elaboracion   => "CO",
      :fabricante         => "Fabricante Y",
      :codigo_arancelario => "101.103",
      :usuario_id         => 3,
      :zona_venta         => "Duty Free"
    )
    Producto.create(
      :registro_sanitario => "L-12.348",
      :alimento           => false,
      :nombre             => "Whisky Dewards",
      :marca              => "Dewards",
      :pais_elaboracion   => "CO",
      :fabricante         => "Fabricante Y",
      :codigo_arancelario => "101.107",
      :usuario_id         => 3,
      :zona_venta         => "Tierra Firme",
      :grado_alcoholico   => "50º"
    )
  end
  
  desc "Crea la lista inicial de tipos de docmentos"
  task :doctype => :environment do
    TipoDocumento.create(
      :descripcion => "Registro Sanitario"
    )
    TipoDocumento.create(
      :descripcion => "Renovación Registro Sanitario"
    )
    TipoDocumento.create(
      :descripcion => "Cambio razón social de fabricante"
    )
    TipoDocumento.create(
      :descripcion => "Cambio razón social de importador"
    )
    TipoDocumento.create(
      :descripcion => "Cambio de marca"
    )
    TipoDocumento.create(
      :descripcion => "Cambio o inclusión de nueva presentación"
    )
    TipoDocumento.create(
      :descripcion => "Cambio de fabricante"
    )
    TipoDocumento.create(
      :descripcion => "Cambio de lugar de fabricación"
    )
    TipoDocumento.create(
      :descripcion => "Inclusión de Importador"
    )
    TipoDocumento.create(
      :descripcion => "Ajuste de grado alcohólico"
    )
  end

  desc "Crea la coleccion inicial de tipos de requisitos"
  task :reqtype => :environment do
      TipoRequisito.create(
          :name => "Registro sanitario/Renovación"
      )
      TipoRequisito.create(
          :name => "Inclusión de importador"
      )
      TipoRequisito.create(
          :name => "Permiso sanitario de la empresa"
      )
      TipoRequisito.create(
          :name => "Evaluacion de las BPF"
      )
      TipoRequisito.create(
          :name => "Autorización empaque"
      )
      TipoRequisito.create(
          :name => "Carta proveedor de empaque"
      )
      TipoRequisito.create(
          :name => "Análisis laboratorio oficial"
      )
      TipoRequisito.create(
          :name => "Análisis laboratorio privado"
      )
      TipoRequisito.create(
          :name => "Análisis país de orígen"
      )
      TipoRequisito.create(
          :name => "Poder al tramitante"
      )
      TipoRequisito.create(
          :name => "Muestra testigo"
      )
      TipoRequisito.create(
          :name => "Rótulos"
      )
      TipoRequisito.create(
          :name => "Rótulo anterior"
      )
      TipoRequisito.create(
          :name => "Registro mercantil fabricante"
      )
      TipoRequisito.create(
          :name => "Registro mercantil importador"
      )
      TipoRequisito.create(
          :name => "Certificado libre venta y consumo"
      )
      TipoRequisito.create(
          :name => "Autorización o poder al importador"
      )
      TipoRequisito.create(
          :name => "Certificado de edad (solo añejamiento)"
      )
      TipoRequisito.create(
          :name => "Certificado de orígen"
      )
      TipoRequisito.create(
          :name => "Declaración jurada fabricante no cambios"
      )
      TipoRequisito.create(
          :name => "Declaración jurada"
      )
      TipoRequisito.create(
          :name => "Documento legal probatorio del cambio"
      )
  end

  desc "Crea las dependencias entre documentos y tramites"
  task :dependencias => :environment do
      allR = TipoRequisito.all
      allD = TipoDocumento.all
      allR.each do |a|
          case a.name

          when "Registro sanitario/Renovación"
              docs = allD[1..-1]
              docs.each do |d|
                  Dependencia.create(:tipo_documento_id => d.id, :tipo_requisito_id => a.id)
              end

          when "Inclusión de importador"
              docs = allD[1..7] << allD[9]
              docs.each do |d|
                  Dependencia.create(:tipo_documento_id => d.id, :tipo_requisito_id => a.id)
              end

          when "Permiso sanitario de la empresa"
              docs = (allD[0..2] + allD[6..7]) << allD[9]
              docs.each do |d|
                  Dependencia.create(:tipo_documento_id => d.id, :tipo_requisito_id => a.id)
              end

          when "Evaluacion de las BPF"
              docs = (allD[0..2] + allD[6..7]) << allD[9]
              docs.each do |d|
                  Dependencia.create(:tipo_documento_id => d.id, :tipo_requisito_id => a.id)
              end

          when "Autorización empaque"
              docs = (allD[0..1] << allD[5]) << allD[9]
              docs.each do |d|
                  Dependencia.create(:tipo_documento_id => d.id, :tipo_requisito_id => a.id)
              end

          when "Carta proveedor de empaque"
              docs = (allD[0..1] << allD[5]) << allD[9]
              docs.each do |d|
                  Dependencia.create(:tipo_documento_id => d.id, :tipo_requisito_id => a.id)
              end

          when "Análisis laboratorio oficial"
              docs = [allD[0], allD[7], allD[9]]
              docs.each do |d|
                  Dependencia.create(:tipo_documento_id => d.id, :tipo_requisito_id => a.id)
              end

          when "Análisis laboratorio privado"
              docs = [allD[0], allD[7]]
              docs.each do |d|
                  Dependencia.create(:tipo_documento_id => d.id, :tipo_requisito_id => a.id)
              end

          when "Análisis país de orígen"
              docs = [allD[0], allD[7], allD[9]]
              docs.each do |d|
                  Dependencia.create(:tipo_documento_id => d.id, :tipo_requisito_id => a.id)
              end

          when "Poder al tramitante"
              docs = allD
              docs.each do |d|
                  Dependencia.create(:tipo_documento_id => d.id, :tipo_requisito_id => a.id)
              end

          when "Muestra testigo"
              docs = allD[0]
              Dependencia.create(:tipo_documento_id => docs.id, :tipo_requisito_id => a.id)

          when "Rótulos"
              docs = allD
              docs.each do |d|
                  Dependencia.create(:tipo_documento_id => d.id, :tipo_requisito_id => a.id)
              end

          when "Rótulo anterior"
              docs = allD[3..7] << allD[9]
              docs.each do |d|
                  Dependencia.create(:tipo_documento_id => d.id, :tipo_requisito_id => a.id)
              end

          when "Registro mercantil fabricante"
              docs = ((allD[0..2] + allD[6..7]) << allD[4]) << allD[9]
              docs.each do |d|
                  Dependencia.create(:tipo_documento_id => d.id, :tipo_requisito_id => a.id)
              end

          when "Registro mercantil importador"
              docs = allD[0..4] + allD[6..9]
              docs.each do |d|
                  Dependencia.create(:tipo_documento_id => d.id, :tipo_requisito_id => a.id)
              end

          when "Certificado libre venta y consumo"
              docs = ((allD[0..2] + allD[6..7]) << allD[4]) << allD[9]
              docs.each do |d|
                  Dependencia.create(:tipo_documento_id => d.id, :tipo_requisito_id => a.id)
              end

          when "Autorización o poder al importador"
              docs = allD[0..1] + allD[4..9]
              docs.each do |d|
                  Dependencia.create(:tipo_documento_id => d.id, :tipo_requisito_id => a.id)
              end

          when "Certificado de edad (solo añejamiento)"
              docs = [allD[0],allD[9]]
              docs.each do |d|
                  Dependencia.create(:tipo_documento_id => d.id, :tipo_requisito_id => a.id)
              end

          when "Certificado de orígen"
              docs = [allD[0],allD[9]]
              docs.each do |d|
                  Dependencia.create(:tipo_documento_id => d.id, :tipo_requisito_id => a.id)
              end

          when "Declaración jurada fabricante no cambios"
              docs = allD[1]
              Dependencia.create(:tipo_documento_id => docs.id, :tipo_requisito_id => a.id)

          when "Declaración jurada"
              docs = allD[2..9]
              docs.each do |d|
                  Dependencia.create(:tipo_documento_id => d.id, :tipo_requisito_id => a.id)
              end

          when "Documento legal probatorio del cambio"
              docs = (allD[4..7] << allD[2]) << allD[9]
              docs.each do |d|
                  Dependencia.create(:tipo_documento_id => d.id, :tipo_requisito_id => a.id)
              end

          end
      end
  end
  desc "Crea 3 usuarios y 4 productos para el usuario Cliente"
  task :database => [:users, :products, :doctype, :reqtype, :dependencias]
end
