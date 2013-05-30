# encoding: UTF-8
class TipoDocumento < ActiveRecord::Base

  #Definicion de relaciones de claves foraneas 
  has_many :documentos
  has_many :dependencias
  has_many :tipo_requisitos, :through => :dependencias

  #Atributos accesibles para el modelo
  attr_accessible :descripcion

  #Validaciones descripcion
  VALID_STRING_REGEX = /\A[\w+\-\ .]*\z/
  validates :descripcion, presence: true, uniqueness: true, format: { with: VALID_STRING_REGEX }

end
