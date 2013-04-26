class Producto < ActiveRecord::Base
  attr_accessible :alimento, :codigo_arancelario, :fabricante, :marca, :nombre, :pais_elaboracion, :registro_sanitario, :usuario_id
  belongs_to :usuario
end
