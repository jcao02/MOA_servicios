class Usuario < ActiveRecord::Base
  #Definicion de relaciones de claves foraneas
  has_many :productos
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, #:registerable,
    :rememberable, :trackable, :authentication_keys => [ :login ]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :admin, :apellido, :compania, :contrasena, :login, :mail, :nombre, :rif, :telefono

  #Validaciones admin
  VALID_ADMIN_REGEX = /\A[012]\z/
  validates :admin, presence: true, format: { with: VALID_ADMIN_REGEX }

  #Validaciones email
  VALID_MAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_MAIL_REGEX }

  #Validaciones telefono
  VALID_TELEFONO_REGEX = /\A[0-9]*\z/
  validates :telefono, presence: true, format: { with: VALID_TELEFONO_REGEX }

  #Validaciones rif
  VALID_RIF_REGEX = /\A[a-zA-Z0-9\-]*\z/
  validates :rif, format: { with: VALID_RIF_REGEX }

  #Validaciones login, string SIN espacios
  VALID_LOGIN_REGEX = /\A[\w+\-.]*\z/
  validates :login, presence: true, uniqueness: true, format: { with: VALID_LOGIN_REGEX }

  #Validaciones strings CON espacio
  VALID_STRING_REGEX = /\A[\w+\-\ .]*\z/

  validates :apellido, format: { with: VALID_STRING_REGEX }
  validates :compania, presence: true, format: { with: VALID_STRING_REGEX }
  validates :password, presence: true, format: { with: VALID_STRING_REGEX }, :length => { :in => 8..16 }, :on => :create,  :on => :update_password
  validates_confirmation_of :password
  validates :nombre, format: { with: VALID_STRING_REGEX }

  #Validaciones de presencia

end
