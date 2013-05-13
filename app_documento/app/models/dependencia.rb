class Dependencia < ActiveRecord::Base
  belongs_to :tipo_documento
  belongs_to :tipo_requisito
  attr_accessible :tipo_documento_id, :tipo_requisito_id
end
