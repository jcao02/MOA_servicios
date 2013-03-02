class Documento < ActiveRecord::Base
  belongs_to :producto
  attr_accessible :alerta, :archivo, :fecha_emision, :fecha_vencimiento, :tipo
end
