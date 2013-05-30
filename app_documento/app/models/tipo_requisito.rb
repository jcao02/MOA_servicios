class TipoRequisito < ActiveRecord::Base
  has_many :requisitos
  has_many :dependencias
  has_many :tipo_documentos, :through => :dependencias
  attr_accessible :name

  #Validaciones name
  VALID_STRING_REGEX = /\A[\w+\-\ .]*\z/
  validates :name, presence: true, format: { with: VALID_STRING_REGEX }
end
