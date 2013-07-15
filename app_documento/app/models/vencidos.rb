class Vencidos < ActiveRecord::Base
  attr_accessible :active, :producto_id, :tipo, :tramite, :usuario_id, :fecha
  belongs_to :products 
  belongs_to :usuarios

end
