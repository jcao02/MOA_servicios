class Usuario < ActiveRecord::Base
  attr_accessible :admin, :apellido, :compania, :contrasena, :login, :mail, :nombre, :rif, :telefono
end
