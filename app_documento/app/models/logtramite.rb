class Logtramite < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :tramite
  
  attr_accessible :tipo, :tramite_id, :usuario_id, :created_at
end
