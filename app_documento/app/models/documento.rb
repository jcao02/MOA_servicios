class Documento < ActiveRecord::Base
  belongs_to :producto
  attr_accessible :alerta, :archivo, :fecha_emision, :fecha_vencimiento, :tipo, :producto_id, :pdf
  has_attached_file :pdf


  validate :fecha_vencimiento => { :after => fecha_vencimiento }  
end