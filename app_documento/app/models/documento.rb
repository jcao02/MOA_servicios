# encoding: UTF-8
class Documento < ActiveRecord::Base

  #Definicion de relaciones de claves foraneas
  belongs_to :producto
  belongs_to :TipoDocumento

  #Atributos accesibles para el modelo
  attr_accessible :alerta, :fecha_emision, :fecha_vencimiento, :producto_id, :pdf, :TipoDocumento_id, :TipoDocumento_attributes
  has_attached_file :pdf

  #Validaciones documentos importados
  accepts_nested_attributes_for :TipoDocumento, :reject_if => lambda { |a| a[:descripcion].blank? }

  #Validaciones atributos
  validates :fecha_vencimiento, presence: true, :date => {:after => Date.today}
  validates :TipoDocumento, presence: true
  validates :pdf, presence: true
end
