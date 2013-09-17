class Cliente < ActiveRecord::Base
  attr_accessible :cliente_id, :responsable_id
  belongs_to :usuario,
    :class_name => 'Usuario', :foreign_key => 'responsable_id'
  belongs_to :usuario,
    :class_name => 'Usuario', :foreign_key => 'cliente_id'
end
