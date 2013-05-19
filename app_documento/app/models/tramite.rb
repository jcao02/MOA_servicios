class Tramite < ActiveRecord::Base
    belongs_to :TipoDocumento
    belongs_to :producto
    belongs_to :usuario
    has_many :requisitos, :dependent => :delete_all
    accepts_nested_attributes_for :requisitos
    attr_accessible :codigo_seguimiento, :estado, :fecha_recepcion, :observacion, :TipoDocumento_id, :producto_id, :recibido, :usuario_id, :requisito

end
