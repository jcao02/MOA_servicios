# encoding: UTF-8
class Log < ActiveRecord::Base

  #Definicion de relaciones de claves foraneas
  belongs_to :usuario

  # Atributos accesibles para el modelo
  attr_accessible :descripcion, :fecha_hora

end
