class Importador < ActiveRecord::Base
  attr_accessible :mail, :nombre, :pais_origen, :rif, :telefono
end
