class Vencidos < ActiveRecord::Base
  attr_accessible :active, :producto_id, :tipo, :tramitando, :usuario_id, :fecha, :tramite_id
  belongs_to :products 
  belongs_to :usuarios
  belongs_to :tramites

end
