class Logsesion < ActiveRecord::Base
  belongs_to :usuario,
    :class_name => 'Usuario', :foreign_key => 'usuario_id'

  belongs_to :usuario,
    :class_name => 'Usuario', :foreign_key => 'superu_id'

  attr_accessible :nsuperu, :nusuario, :superu_id, :tipo, :usuario_id, :created_at
end
