class Producto < ActiveRecord::Base
  attr_accessible :alimento, :codigo_arancelario, :fabricante, :marca, :nombre, :pais_elaboracion, :registro_sanitario
end
