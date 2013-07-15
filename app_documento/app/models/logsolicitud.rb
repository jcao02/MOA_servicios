class Logsolicitud < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :solicitud
  
  attr_accessible :solicitud_id, :tipo, :usuario_id, :created_at
end
