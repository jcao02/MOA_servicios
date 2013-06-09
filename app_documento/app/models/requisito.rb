# encoding: UTF-8
class Requisito < ActiveRecord::Base

  #Definicion de relaciones de claves foraneas
  belongs_to :tramite
  belongs_to :TipoRequisito

  #Para manejo de log del usuario
  has_paper_trail
  
  #Atributos accesibles para el modelo
  attr_accessible :descripcion, :estado, :observacion, :tramite_id, :TipoRequisito_id

  #Validaciones descripcion, observacion
  VALID_STRING_REGEX = /\A[\w+\-\ .]*\z/

  validates :TipoRequisito_id, presence: true
  validates :observacion, format: { with: VALID_STRING_REGEX }

end
