# encoding: UTF-8
class Documento < ActiveRecord::Base

  #Definicion de relaciones de claves foraneas
  belongs_to :producto
  belongs_to :TipoDocumento

  #Log para documentos
  has_many :logdocumentos
  has_many :usuarios, :through => :logdocumentos
  has_many :productos, :through => :logdocumentos

  #Para manejo de log del usuario
  has_paper_trail
  
  #Atributos accesibles para el modelo
  attr_accessible :alerta, :fecha_emision, :fecha_vencimiento, :producto_id, 
  attr_accessible :pdf, :TipoDocumento_id, :TipoDocumento_attributes, :on
  has_attached_file :pdf

  #Validaciones documentos importados
  accepts_nested_attributes_for :TipoDocumento, :reject_if => lambda { |a| a[:descripcion].blank? }

  #Validaciones atributos
  validates :fecha_vencimiento, presence: true, :date => {:after => Date.today}
  validates :TipoDocumento, presence: true
  validates :pdf, presence: true
end
