class TipoRequisito < ActiveRecord::Base
    has_many :requisitos
    has_many :dependencias
    has_many :tipo_documentos, :through => :dependencias
    attr_accessible :name
end
