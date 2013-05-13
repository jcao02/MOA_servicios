class TipoDocumento < ActiveRecord::Base
  attr_accessible :descripcion
  has_many :documentos
  has_many :dependencias
  has_many :tipo_requisitos, :through => :dependencias

  validates :descripcion, presence: true, uniqueness: true
end
