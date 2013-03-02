class Tramite < ActiveRecord::Base
  attr_accessible :codigo_seguimiento, :estado, :fecha_recepcion, :observacion, :tipo
end
