# encoding: UTF-8
class Importador < ActiveRecord::Base

  #Definicion de relaciones de claves foraneas
  has_and_belongs_to_many :productos
  has_many :documentos

  accepts_nested_attributes_for :documentos, :reject_if => lambda { |x| x[:pdf].blank? or x[:fecha_vencimiento].blank? }

  #Atributos accesibles para el modelo
  attr_accessible :mail, :nombre, :pais_origen, :rif, :telefono, :productos_id, :documentos_attributes

  #Validaciones email
  VALID_MAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :mail, presence: true, uniqueness: true, format: { with: VALID_MAIL_REGEX }

  #Validaciones strings CON espacio
  VALID_STRING_REGEX = /\A[\w+\-\ .]*\z/
  validates :nombre, presence: true, format: { with: VALID_STRING_REGEX }
  validates :pais_origen, presence: true, format: { with: VALID_STRING_REGEX }
  
  #Validaciones rif
  VALID_RIF_REGEX = /\A([A-Z]-\d{7}-\d)\z/
  validates :rif, presence: true, uniqueness: true, format: { with: VALID_RIF_REGEX }

  #Validaciones telefono
  VALID_TELEFONO_REGEX = /\A[0-9]*\z/
  validates :telefono, presence: true, format: { with: VALID_TELEFONO_REGEX }

end
