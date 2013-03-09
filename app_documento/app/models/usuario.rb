class Usuario < ActiveRecord::Base
  attr_accessible :admin, :apellido, :compania, :contrasena, :login, :mail, :nombre, :rif, :telefono

  #Validaciones admin
  VALID_ADMIN_REGEX = /\A[012]\z/
  validates :admin, presence: true, format: { with: VALID_ADMIN_REGEX }

  #Validaciones email
  VALID_MAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :mail, presence: true, format: { with: VALID_MAIL_REGEX }

  #Validaciones telefono
  VALID_TELEFONO_REGEX = /\A[0-9]*\z/
  validates :telefono, format: { with: VALID_TELEFONO_REGEX }

  #Validaciones rif
  VALID_RIF_REGEX = /\A[a-zA-Z0-9\-]*\z/
  validates :rif, format: { with: VALID_RIF_REGEX }

  #Validaciones strings
  VALID_STRING_REGEX = /\A[\w+\-.]*\z/
  
  validates :apellido, format: { with: VALID_STRING_REGEX }
  validates :compania, presence: true, format: { with: VALID_STRING_REGEX }
  validates :contrasena, presence: true, format: { with: VALID_STRING_REGEX }
  validates :login, presence: true, uniqueness: true, format: { with: VALID_STRING_REGEX }
  validates :nombre, format: { with: VALID_STRING_REGEX }

end