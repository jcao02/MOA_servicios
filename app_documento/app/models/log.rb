class Log < ActiveRecord::Base
  belongs_to :usuario
  attr_accessible :descripcion, :fecha_hora
end
