# encoding: UTF-8
class Tramite < ActiveRecord::Base
  belongs_to :TipoDocumento
  belongs_to :producto
  belongs_to :usuario
  has_many :requisitos, :dependent => :delete_all
  accepts_nested_attributes_for :requisitos

  #Atributos accesibles para el modelo
  attr_accessible :codigo_seguimiento, :estado, :fecha_recepcion, :observacion, :TipoDocumento_id, :producto_id, :recibido, :usuario_id, :requisito

  validates :codigo_seguimiento, presence: true, uniqueness: true

  #Validaciones fecha
  validates :fecha_recepcion, presence: true, :date => {:before_or_equal_to => Date.today}

  #Validaciones observacion
  VALID_STRING_REGEX = /\A[\w+\-\ .]*\z/
  validates :observacion, presence: true, format: { with: VALID_STRING_REGEX }

end
