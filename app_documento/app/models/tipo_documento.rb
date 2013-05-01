#encoding: UTF-8
class TipoDocumento
  @@dicc = { 
    1 => "Registro Sanitario",
    2 => "Renovación Registro Sanitario",
    3 => "Cambio razón social del fabricante",
    4 => "Cambio razón social importador",
    5 => "Cambio de marca",
    6 => "Cambio o inclusión de nueva presentación",
    7 => "Cambio de fabricante",
    8 => "Cambio de lugar de fabricación",
    9 => "Inclusión de importador",
    10 => "Ajuste de grado alcohólico",
  }
  @@index = 11

  def initialize
  end
  
  #Obtiene el diccionario de forma de arreglo de arreglos
  def get_diccionario
    n = @@index - 1
    array = []
    for i in 1..n do
      array.push([@@dicc[i], i])
    end
    return array
  end

  #Retorna un valor dada una clave
  def decode_documento(code)
    return @dicc[code]
  end

  #Agrega un valor al diccionario
  def add_value(value)
    @@dicc[@@index] = value
    @@index += 1
  end

  #Obtiene el ultimo indice 
  def get_index
    return @@index
  end
  
  #Resetea el diccionario 
  def reset_dicc
    for i in 11..@@index do
      @@dicc.delete(i)
    end
  end
end
