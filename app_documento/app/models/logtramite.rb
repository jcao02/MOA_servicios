class Logtramite < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :tramite
  belongs_to :producto
  
  attr_accessible :tipo, :tramite_id, :usuario_id, :created_at, :nusuario, 
                  :nproducto, :ntipodocumento, :producto_id
end
