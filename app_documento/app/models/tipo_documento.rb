class TipoDocumento < ActiveRecord::Base
  attr_accessible :descripcion
  has_many :documentos

  validates :descripcion, presence: true, uniqueness: true
end
