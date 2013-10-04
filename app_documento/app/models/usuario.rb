# encoding: UTF-8
class Usuario < ActiveRecord::Base

  #Definicion de relaciones de claves foraneas
  has_many :productos

  #Log para productos
  has_many :logproductos
  has_many :productos, :through => :logproductos

  #Log para documentos
  has_many :logdocumentos
  has_many :documentos, :through => :logdocumentos
  has_many :productos, :through => :logdocumentos

  #Log para tramites
  has_many :logtramites
  has_many :tramites, :through => :logtramites
  has_many :productos, :through => :logtramites
  has_many :vencidoss
  
  #Log para usuarios
  has_many :logsesions
  has_many :clientes
  has_many :usuarios, :through => :clientes, :source => :encargado
  has_many :usuarios, :through => :clientes, :source => :cliente
  #has_many :usuarios, :through => :logsesions, :source => :usuario
  #has_many :usuarios, :through => :logsesions, :source => :superu 
 
  accepts_nested_attributes_for :clientes, reject_if: lambda { |attr| attr['cliente_id'].blank? }, :allow_destroy => true

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, #:registerable,
    :rememberable, :trackable, :authentication_keys => [ :login ]

  #Atributos accesibles para el modelo
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :admin, :apellido, :compania, :contrasena, :login, :mail 
  attr_accessible :nombre, :rif, :telefono, :sign_in_count, :current_sign_in_at
  attr_accessible :last_sign_in_at, :bloqueado, :transcriptor, :responsable
  attr_accessible :clientes_attributes

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
  VALID_RIF_REGEX = /\A([A-Z]-\d{8}-\d)?\z/
 # validates :rif, uniqueness: true, format: { with: VALID_RIF_REGEX }

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

  #Para impedir que un usuario bloqueado entre al sistema
  def active_for_authentication?
    super && bloqueado == 0
  end

  #Mensaje que indica que el usuario está bloqueado
  def inactive_message
    bloqueado == 0 ? super : :bloqueado
  end

  #METODOS
  def self.current
    Thread.current[:usuario]
  end

  def self.current=(usuario)
    Thread.current[:usuario] = usuario
  end
  
  # METODOS
  # Metodo que registra el log de creacion de usuario
  def registrar_log(tipo)
    if Usuario.current.nil? 
      snombre = "Script"
      superu = nil
    else
      snombre = Usuario.current.login
      superu = Usuario.current.id
    end
  
    logs = Logsesion.new(:usuario_id => self.id, 
                         :superu_id => superu,
                         :tipo => tipo, 
                         :nusuario => self.login, 
                         :nsuperu => snombre)

    return logs.save
  end

end
