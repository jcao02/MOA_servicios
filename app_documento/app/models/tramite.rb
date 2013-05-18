class Tramite < ActiveRecord::Base
    belongs_to :TipoDocumento
    belongs_to :producto
    belongs_to :usuario
    has_many :requisitos, :dependent => :delete_all
    attr_accessible :codigo_seguimiento, :estado, :fecha_recepcion, :observacion, :TipoDocumento_id, :producto_id, :recibido, :recibido, :usuario_id

end
