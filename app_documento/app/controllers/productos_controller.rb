#encoding: UTF-8
class ProductosController < ApplicationController
  respond_to :html, :js
  before_filter :is_admin, :only => [:new, :create, :edit, :update, :destroy]
  # GET /productos
  # GET /productos.json
  def index
    if current_usuario.admin != 0
      flash[:title] = "Productos"
      @productos = Producto.all
    else
      flash[:title] = "Mis Productos"
      @productos = Producto.where(:usuario_id => current_usuario.id, :on => 1)
    end
    @marcas = get_marcas(@productos)
    #Conjuntos de filtrado
    flash[:productos] = []
    4.times { flash[:productos].push(@productos) }

    @producto = Producto.new
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @productos }
    end
  end

  #Vista productos por usuario
  def productos_usuario
    usuario = Usuario.find(params[:usuario])
    flash[:title] = "Productos de #{usuario.compania}"
    @productos = Producto.where(:usuario_id => usuario.id)
    @marcas = get_marcas(@productos)
    flash[:productos] = []
    4.times { flash[:productos].push(@productos) }
    @producto = Producto.new
    render "index"
  end

  #Filtrar por procedencia
  def prov_filter
    prov = params[:producto][:pais_elaboracion]
    todo = flash[:productos][0]

    #Elimina todos los espacios en blanco
    prov.gsub!(/\s+/, "")

    if prov == "Todo"
      puts "todo"
      filtro = todo
    elsif prov == "Nacional"
      filtro = todo.select{ |x| x.pais_elaboracion == "VE" }
    else
      filtro = todo.select{ |x| x.pais_elaboracion != "VE" }
    end

    flash[:productos][1] = filtro
    @productos = flash[:productos][0]
    for i in 1..3
      @productos = @productos & flash[:productos][i]
    end
    @marcas = get_marcas(@productos)
    flash.keep
    respond_with(@productos, @marcas,:layout => false)
  end

  #Filtrar por tipo 
  def type_filter
    tipo = params[:producto][:alimento]
    todo = flash[:productos][0]

    #Elimina todos los espacios en blanco
    tipo.gsub!(/\s+/, "")

    if tipo == "Todo"
      filtro = todo
    elsif tipo == "Alimento"
      filtro = todo.select{ |x| x.alimento == true }
    else
      filtro = todo.select{ |x| x.alimento == false }
    end

    flash[:productos][2] = filtro
    @productos = flash[:productos][0]
    for i in 1..3
      @productos = @productos & flash[:productos][i]
    end
    flash.keep
    @marcas = get_marcas(@productos)
    render "prov_filter", :layout => false
  end

  #Filtrar por marca
  def marca_filter
    if params.has_key?("producto")
      marca = params[:producto][:marca]
    else
      marca = []
    end
    todo = flash[:productos][0]
    filtro = []

    if marca.empty?()
      filtro = todo
    else
      marca.each do |elem|
        filtro += todo.select{ |x| x.marca == elem }
      end
    end

    #En este caso no se modifica el cjto de marcas.
    prod = flash[:productos][0]
    for i in 1..3
      prod = prod & flash[:productos][i]
    end

    @marcas = get_marcas(prod)

    flash[:productos][3] = filtro
    @productos = flash[:productos][0]
    for i in 1..3
      @productos = @productos & flash[:productos][i]
    end
    flash.keep
    render "prov_filter", :layout => false
  end

  # GET /productos/1
  # GET /productos/1.json
  def show
    @producto = Producto.find(params[:id])
    @cliente = Usuario.find(@producto.usuario_id)
    session[:producto] = @producto.id
    flash.keep
    @documentos = get_documentos(@producto, current_usuario.admin > 0 )
    @presentaciones = Presentacion.where(:productos_id => @producto.id)
    @importadores = Importador.where(:productos_id => @producto.id)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @producto }
    end
  end

  # GET /productos/new
  # GET /productos/new.json
  def new
    @producto = Producto.new
    @producto.alimento = true   #Para que aparezca un default en el select
    usuarios = Usuario.where(:admin => 0)     #Para coleccion del dueño del producto
    prod = Producto.all
    @marcas = get_marcas(prod)
    @fabricantes = get_fabricantes(prod)
    @companias = []
    for elem in usuarios do
      @companias.push([elem.compania, elem.id])
    end
    flash[:accion] = "Crear Producto"

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @producto }
    end
  end

  # GET /productos/1/edit
  def edit
    @producto = Producto.find(params[:id])
    usuarios = Usuario.all
    prod = Producto.all
    @marcas = get_marcas(prod)
    @fabricantes = get_fabricantes(prod)
    @companias = []
    for elem in usuarios do
      @companias.push([elem.compania, elem.id])
    end
    flash[:accion] = "Editar Producto"
  end

  # POST /productos
  # POST /productos.json
  def create
    @producto = Producto.new(params[:producto])

    respond_to do |format|
      if @producto.save
        format.html { redirect_to @producto, notice: 'Producto creado.' }
        format.json { render json: @producto, status: :created, location: @producto }

      else
        usuarios = Usuario.all      #Para coleccion del dueño del producto
        prod = Producto.all
        @marcas = get_marcas(prod)
        @fabricantes = get_fabricantes(prod)
        @companias = []
        for elem in usuarios do
          @companias.push([elem.compania, elem.id])
        end

        flash.keep
        format.html { render action: "new" }
        format.json { render json: @producto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /productos/1
  # PUT /productos/1.json
  def update
    @producto = Producto.find(params[:id])
    respond_to do |format|
      if @producto.update_attributes(params[:producto])
        format.html { redirect_to @producto, notice: 'Producto actualizados.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit", notice: "Producto no actualizado." }
        format.json { render json: @producto.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /productos/1
  # DELETE /productos/1.json
  def destroy
    @producto = Producto.find(params[:id])
    @producto.destroy

    respond_to do |format|
        format.html { redirect_to productos_url, notice: "Producto eliminado."}
        format.json { head :no_content }
    end
  end


  # FALTA VER SI MODIFICAR EL OBSERVER PARA AGREGAR ESTE CALLBACK
  #Oculta un producto en vez de eliminarlo
  def ocultar
    @producto = Producto.find(params[:id])
    @logp = Logproducto.new(:usuario_id => current_usuario.id, 
                            :producto_id => @producto.id,
                            :nusuario => current_usuario.nombre, 
                            :nproducto => @producto.nombre)

    x = ocultar_prod(@producto.id)
    if  x == 1
      redirect_to @producto, notice: "Producto cambiada visibilidad"
    elsif x == 2
      redirect_to @producto, notice: "No se puedo cambiar visibilidad"
    end

  end


  #Metodos privados del controlador
  private

    def get_documentos(producto, admin)
      docs = TipoDocumento.all
      tipos = []
      docs.each do |td|
        documento = Documento.order("fecha_vencimiento DESC").where(:TipoDocumento_id => td.id, :producto_id => producto.id).first
        next if documento.nil? or (documento.on == 0 and not admin)
        tipos.push([documento, td.descripcion])
      end
      return tipos
    end

    def get_fabricantes(productos)
      fabricantes= []
      #Lista de fabricantes sin repeticiones
      productos.each do |p|
        if not fabricantes.include?(p.fabricante)
          fabricantes.push(p.fabricante)
        end
      end
      return fabricantes
    end

    def get_marcas(productos)
      marcas = []
      #Lista de marcas sin repeticiones
      productos.each do |p|
        if not marcas.include?(p.marca)
          marcas.push(p.marca)
        end
      end
      return marcas
    end
end
