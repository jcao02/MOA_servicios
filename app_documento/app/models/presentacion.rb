class Presentacion < ActiveRecord::Base
  attr_accessible :cpe, :empaque, :fecha_vencimiento, :peso_escurrido, :peso_neto
end
