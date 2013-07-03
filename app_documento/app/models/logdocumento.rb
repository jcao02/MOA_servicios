class Logdocumento < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :producto
  
  attr_accessible :documento_id, :tipo, :usuario_id, :created_at
end
