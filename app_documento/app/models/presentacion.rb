# encoding: UTF-8
class Presentacion < ActiveRecord::Base

  #Definicion de relaciones de claves foraneas
  belongs_to :producto

  #Atributos accesibles para el modelo  
  attr_accessible :cpe, :empaque, :fecha_vencimiento, :peso_escurrido, :peso_neto, :productos_id

  #Validaciones cpe
  validates :cpe, presence: true, uniqueness: true

  #Validaciones atributos
  validates :fecha_vencimiento, presence: true, :date => {:after => Date.today}
  
  VALID_PESO_REGEX = /\A[0-9]+(,[0-9]+)?\z/
  validates :peso_escurrido, format: { with: VALID_PESO_REGEX }
  validates :peso_neto, format: { with: VALID_PESO_REGEX }
  
end
