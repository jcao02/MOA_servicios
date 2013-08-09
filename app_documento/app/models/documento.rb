# encoding: UTF-8
class Documento < ActiveRecord::Base

    #Definicion de relaciones de claves foraneas
    belongs_to :producto
    belongs_to :TipoDocumento
    belongs_to :importador
    belongs_to :presentacion

    #Log para documentos
    has_many :logdocumentos
    has_many :usuarios, :through => :logdocumentos
    has_many :productos, :through => :logdocumentos

    #Atributos accesibles para el modelo
    attr_accessible :alerta, :fecha_emision, :fecha_vencimiento, :producto_id
    attr_accessible :pdf, :TipoDocumento_id, :TipoDocumento_attributes, :on, :ultimo, 
                    :created_by, :updated_by
    has_attached_file :pdf, 
                      :path   => ":rails_root/app/assets/images/documentos/:id/:style/:basename.:extension",
                      :url    => "/assets/documentos/:id/:style/:basename.:extension"

    #Validaciones documentos importados
    accepts_nested_attributes_for :TipoDocumento, :reject_if => lambda { |a| a[:descripcion].blank? }

    #Validaciones atributos
    validates :fecha_vencimiento, presence: true, :date => {:after => Date.today}
    validates :TipoDocumento, presence: true
    validates :pdf, presence: true


    # METODOS

    # Falta agregar mas parametros para todos los tipos de udpate
    def registrar_log(tipo)
      logd = Logdocumento.new(:usuario_id => Usuario.current.id, 
                              :documento_id => self.id, 
                              :tipo => tipo, 
                              :producto_id => self.producto_id, 
                              :nusuario => Usuario.current.nombre, 
                              :ndocumento => self.TipoDocumento.descripcion, 
                              :nproducto => self.producto.nombre)

      return logd.save

    end


end
