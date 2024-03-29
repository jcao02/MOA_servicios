#encoding: UTF-8
class ProductosController < ApplicationController
  respond_to :html, :js
  before_filter :is_admin, :only => [ :update, :ocultar, :edit ]
  before_filter :is_sadmin, :only => [ :destroy ]
  before_filter :is_transcriptor, :only => [ :new_create_documentos, :create_documentos, :new, :create]
  before_filter :actualizar_alertas
  # GET /productos
  # GET /productos.json
  def index
    if current_usuario.admin != 0

      flash[:title] = "Productos"
      clientes      = Cliente.where(:usuario_id => current_usuario.id)
      clientesIds   = clientes.map{ |x| x.cliente_id }
      productosT    = Producto.all

      if current_usuario.admin == 2
        @productos = productosT
      else
        @productos = []
        productosT.each do |p|
          @productos << p unless not clientesIds.include? p.usuario.id 
        end 
      end 
      
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
      marca.values.each do |elem|
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
    flash.keep
    @documentos = get_documentos(@producto.id, current_usuario.admin > 0 )
    @presentaciones = Presentacion.where(:productos_id => @producto.id)
    @importadores_todos = Importador.all

    logp = Logproducto.new(:usuario_id => current_usuario.id, 
                           :producto_id => @producto.id, 
                           :tipo => "Visualizado", 
                           :nusuario => current_usuario.nombre, 
                           :nproducto => @producto.nombre)

    if logp.save
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @producto }
      end
    else
      format.json { render json: @producto, notice:"La información no fue almacenada en el log." }
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
        format.html { render action: "new", alert: 'Producto no pudo ser creado exitosamente.' }
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
        format.html { redirect_to @producto, notice: 'Producto actualizado exitosamente.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit", alert: 'Producto no pudo ser actualizado.' }
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
        format.html { redirect_to productos_url, notice: 'Producto eliminado exitosamente.'}
        format.json { head :no_content }
    end
  end


  #Oculta un producto en vez de eliminarlo
  def ocultar
    @producto = Producto.find(params[:id])
    @logp = Logproducto.new(:usuario_id => current_usuario.id, 
                            :producto_id => @producto.id,
                            :nusuario => current_usuario.nombre, 
                            :nproducto => @producto.nombre)

    x = ocultar_prod(@producto.id)
    if  x == 1
      redirect_to @producto, notice: 'Visibilidad cambiada.'
    else
      redirect_to @producto, notice: 'Visibilidad no cambiada.'
    end

  end

  def show_documentos
    @producto = Producto.find(params[:id])
    if current_usuario.admin > 0 
      @documentos = get_documentos(@producto.id, true)
    else
      @documentos = get_documentos(@producto.id, false)
    end
    render :layout => false
  end

  def show_importadores
    @producto = Producto.find(params[:id])
    @importadores = @producto.importadors
    @inclusion = Documento.order("fecha_vencimiento DESC").where(:TipoDocumento_id => 9, :producto_id => @producto.id).first
    render :layout => false
  end

  def show_presentaciones
    @producto = Producto.find(params[:id])
    @presentaciones = Presentacion.where(:productos_id => params[:id])
    @inclusion = Documento.order("fecha_vencimiento DESC").where(:TipoDocumento_id => 6, :producto_id => @producto.id).first
    render :layout => false
  end


  def new_create_documentos
    @producto       = Producto.find( params[:producto_id] )
    @presentaciones = Presentacion.where(:productos_id => params[:producto_id])
    @importadores   = Importador.where(:productos_id => params[:producto_id])
    @tipos          = TipoDocumento.all
    @producto.documentos.build
  end

  def create_documentos
    @producto = Producto.find(params[:id])
    respond_to do |format|
      if @producto.update_attributes(params[:producto])
        format.html { redirect_to @producto, notice: 'Producto actualizado exitosamente.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit", alert: 'Producto no pudo ser actualizado.' }
        format.json { render json: @producto.errors, status: :unprocessable_entity }
      end
    end

  end

  #Metodos privados del controlador
  private

    def get_documentos(producto, admin)
      docs = TipoDocumento.all
      tipos = []
      docs.each do |td|
        documento_set = Documento.order("fecha_vencimiento DESC").where(:TipoDocumento_id => td.id, :producto_id => producto)
        next unless documento_set.any?
        if td.id == 6 or td.id == 9 
          documento_set.each do |documento|
            same = tipos.select{ |x| x[0].TipoDocumento_id == documento.TipoDocumento_id }
            vencido = same.select{ |x| (not x[0].importador_id.nil? and x[0].importador_id == documento.importador_id) \
                                  or (not x[0].presentacion_id.nil? and x[0].presentacion_id == documento.presentacion_id)}
            next if vencido.any?  or (documento.on == 0 and not admin) 
            tipos.push([documento, td.descripcion])
          end
        else
          documento = documento_set.first
          next if documento.on == 0 and not admin
          tipos.push([documento, td.descripcion])
        end
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
