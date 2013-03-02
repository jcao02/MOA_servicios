class Requisito < ActiveRecord::Base
  belongs_to :tramite
  attr_accessible :descripcion, :estado, :id, :observacion
end
