class Documento < ActiveRecord::Base
  attr_accessible :alerta, :fecha_emision, :fecha_vencimiento, :producto_id, :pdf, :TipoDocumento_id, :TipoDocumento_attributes
  has_attached_file :pdf

  belongs_to :producto
  belongs_to :TipoDocumento

  accepts_nested_attributes_for :TipoDocumento, :reject_if => lambda { |a| a[:descripcion].blank? }

  validates :fecha_vencimiento, :date => {:after => Date.today}
  validates :TipoDocumento, presence: true
  validates :pdf, presence: true
end
