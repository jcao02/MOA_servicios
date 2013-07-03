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
  attr_accessible :codigo_seguimiento, :estado, :fecha_recepcion, :observacion, :TipoDocumento_id, :producto_id, :recibido, :usuario_id, :requisito

  #Consiraciones de quitarlo y dejar el id y ya
  #validates :codigo_seguimiento, presence: true, uniqueness: true

  #Validaciones observacion
  VALID_STRING_REGEX = /\A[\w+\-\ .]*\z/
  validates :observacion, format: { with: VALID_STRING_REGEX }
  #Validacion de presencia de tipo de documento
  validates :TipoDocumento_id, presence: true

end
