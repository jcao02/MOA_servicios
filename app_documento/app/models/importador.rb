class Importador < ActiveRecord::Base
  attr_accessible :mail, :nombre, :pais_origen, :rif, :telefono
  has_and_belongs_to_many :productos
end
