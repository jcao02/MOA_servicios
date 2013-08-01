class Logsesion < ActiveRecord::Base
  has_many :usuarios

  attr_accessible :tipo, :usuario_id, :created_at
end
