class Requisito < ActiveRecord::Base
  belongs_to :tramite
  belongs_to :TipoRequisito
  attr_accessible :descripcion, :estado, :id, :observacion, :tramite_id, :tramite_id, :TipoRequisito_id
end
