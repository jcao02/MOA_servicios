class Tramite < ActiveRecord::Base
    belongs_to :TipoDocumento
    belongs_to :producto
    has_many :requisitos
    attr_accessible :codigo_seguimiento, :estado, :fecha_recepcion, :observacion, :TipoDocumento_id, :producto_id, :recibido, :recibido

end
