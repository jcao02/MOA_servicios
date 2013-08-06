# encoding: UTF-8
class Tramite < ActiveRecord::Base
  belongs_to :TipoDocumento
  belongs_to :producto
  belongs_to :usuario
  has_many :requisitos, :dependent => :delete_all
  accepts_nested_attributes_for :requisitos

  #Log tramite
  has_many :logtramites
  has_many :usuarios, :through => :logtramites

  #Atributos accesibles para el modelo
  attr_accessible :codigo_seguimiento, :estado, :fecha_recepcion, :observacion, 
    :TipoDocumento_id, :producto_id, :recibido, :usuario_id, :requisito,
    :created_at

  #Consiraciones de quitarlo y dejar el id y ya
  #validates :codigo_seguimiento, presence: true, uniqueness: true

  #Validaciones observacion
  VALID_STRING_REGEX = /\A[\w+\-\ .]*\z/
    validates :observacion, format: { with: VALID_STRING_REGEX }
  #Validacion de presencia de tipo de documento
  validates :TipoDocumento_id, presence: true


  # METODOS

  # Metodo para crear requisitos sobre el tramite
  def crear_requisitos
    dependencias = Dependencia.where(:tipo_documento_id => self.TipoDocumento_id)
    dependencias.each do |d|
      req = Requisito.new(:estado => "Sin recibir", :tramite_id => self.id, :TipoRequisito_id => d.tipo_requisito_id)
      self.requisitos << req
    end
  end

  # Metodo que registra el log de creacion de tramite
  def registrar_log(tipo)
    if self.producto.nil? 
      nombre = "Producto no registrado"
    else
      nombre = self.producto.nombre
    end
    logt = Logtramite.new(:usuario_id => self.usuario_id,
                          :tramite_id => self.id, 
                          :tipo => tipo, 
                          :nusuario => self.usuario.nombre, 
                          :ntipodocumento => self.TipoDocumento.descripcion, 
                          :nproducto => nombre, 
                          :producto_id => self.producto_id)

    return logt.save
  end
end
