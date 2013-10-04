class Cliente < ActiveRecord::Base
  attr_accessible :cliente_id, :usuario_id
  belongs_to :usuario,
    :class_name => 'Usuario', :foreign_key => 'usuario_id'
  belongs_to :usuario,
    :class_name => 'Usuario', :foreign_key => 'cliente_id'
end
