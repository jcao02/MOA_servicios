# encoding: UTF-8
class Producto < ActiveRecord::Base

  #Definicion de relaciones de claves foraneas
  belongs_to :usuario
  has_many :logproductos
  has_many :usuarios, :through => :logproductos
  
  has_many :documentos
  has_many :presentacions
  has_and_belongs_to_many :importadors

  #Para manejo de log del usuario
  has_paper_trail
  
  # Atributos accesibles para el modelo
  attr_accessible :registro_sanitario, :codigo_arancelario, :alimento, :fabricante, :marca, :nombre
  attr_accessible :pais_elaboracion, :grado_alcoholico, :zona_venta, :usuario_id

  #Validaciones registro sanitario
  VALID_REGSAN_REGEX = /\A[A-Z]\-\d{1,3}(\.\d{3})*\z/
  validates :registro_sanitario, uniqueness: true, presence: true, format: { with: VALID_REGSAN_REGEX }


  #Validaciones codigo_arancelario
  VALID_CODARAN_REGEX = /\A\d{4}(.\d{2}){2}\z/
  validate :codigo_arancelario, presence: true, format: { with: VALID_CODARAN_REGEX }

  #Validaciones strings CON espacio
  VALID_STRING_REGEX = /\A[\w+\-\ .]*\z/

  validates :fabricante, presence: true, format: { with: VALID_STRING_REGEX }
  validates :marca, presence: true, format: { with: VALID_STRING_REGEX }
  validates :nombre, presence: true, format: { with: VALID_STRING_REGEX }
  validates :pais_elaboracion, presence: true, format: { with: VALID_STRING_REGEX }

end
