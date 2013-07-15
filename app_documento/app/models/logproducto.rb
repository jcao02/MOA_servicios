class Logproducto < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :producto

  attr_accessible :producto_id, :tipo, :usuario_id, :created_at, :nusuario, :nproducto
end
