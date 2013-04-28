class Producto < ActiveRecord::Base

  #Definicion de relaciones de claves foraneas
  belongs_to :usuario
  has_many :documentos

  # Atributos accesibles para el modelo
  attr_accessible :alimento, :codigo_arancelario, :fabricante, :marca, :nombre
  attr_accessible :pais_elaboracion, :registro_sanitario, :usuario_id

  #Validaciones registro sanitario
  VALID_REGSAN_REGEX = /\A[A-Z]-\d{2}\.\d{3}\z/
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

  #Validaciones de presencia

end
