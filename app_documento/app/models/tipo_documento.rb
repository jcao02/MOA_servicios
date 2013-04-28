class TipoDocumento
  @dicc

  def initialize
    @dicc = []
    @dicc.push(["Registro Sanitario",1])
    @dicc.push(["Renovacion Registro Sanitario",2])
    @dicc.push(["Cambio razon social del fabricante",3])
    @dicc.push(["Cambio razon social importador",4])
    @dicc.push(["Cambio de Marca",5])
    @dicc.push(["Cambio o inclusion de nueva Presentacion",6])
    @dicc.push(["Cambio de fabricante",7])
    @dicc.push(["Cambio lugar de fabricacion",8])
    @dicc.push(["Inclusion de Importador",9])
    @dicc.push(["Ajuste de grado Alcoholico",10])
  end

  def get_diccionario
    @dicc
  end

  def decode_documento(code)
    elem = @dicc.select { |x| x[1] == code }
    
    if elem == []
      return nil
    else
      return elem[0][0]
    end
    return nil
  end
end
