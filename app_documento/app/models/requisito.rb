# encoding: UTF-8
class Requisito < ActiveRecord::Base

  #Definicion de relaciones de claves foraneas
  belongs_to :tramite
  belongs_to :TipoRequisito

  #Atributos accesibles para el modelo
  attr_accessible :descripcion, :estado, :id, :observacion, :tramite_id, :TipoRequisito_id

  #Validaciones id
  validates :id, uniqueness: true, presence: true

  #Validaciones descripcion, observacion
  VALID_STRING_REGEX = /\A[\w+\-\ .]*\z/

  validates :descripcion, presence: true, format: { with: VALID_STRING_REGEX }
  validates :observacion, format: { with: VALID_STRING_REGEX }

end
