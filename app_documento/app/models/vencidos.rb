class Vencidos < ActiveRecord::Base
  attr_accessible :active, :producto_id, :tipo, :tramite, :usuario_id
  has_many :products 
  has_many :usuarios

end
