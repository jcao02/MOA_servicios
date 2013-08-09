#encoding: UTF-8
class DocumentosController < ApplicationController
  before_filter :is_admin, :only => [:new, :create, :destroy, :index, :index_usuario, :generar_tramitado]
  before_filter :actualizar_alertas
  # GET /documentos
  # GET /documentos.json
  def index
    #Todos los documentos ordenados por producto, tipo y fecha de vencimiento
    @documentos = Documento.order("producto_id").order("TipoDocumento_id").order("fecha_vencimiento DESC").all
    flash[:title] = "Documentos"
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @documentos }
    end
  end

  # Vista de documentos por usuario
  def index_usuario
    usuario = Usuario.find(params[:id])
    productos = Producto.where(:usuario_id => usuario.id)
    productos_ids = productos.map{ |p| p.id }
    @documentos = Documento.order("TipoDocumento_id").order("fecha_vencimiento DESC").where(:producto_id => productos_ids)
    flash[:title] = "Documentos de #{usuario.compania}"
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @documentos }
    end
  end
  # GET /documentos/1
  # GET /documentos/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.pdf do
        render :pdf => @documento.pdf_file_name
      end
    end
  end

    # GET /documentos/new
  # GET /documentos/new.json
  def new
    @documento = Documento.new
    @documento.TipoDocumento = TipoDocumento.new
    @tipos = get_tipoDoc
    @presentaciones = Presentacion.where(:productos_id => params[:producto_id])
    @importadores = Importador.where(:productos_id => params[:producto_id])

    @producto_id = params[:producto_id]
    flash[:accion] = "Agregar Documento"
    flash.keep

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @documento }
    end
  end

  # Accion para generar un documento sobre una solicitud
  def generar_tramitado
    @documento               = Documento.new
    @documento.TipoDocumento = TipoDocumento.new

    @tramite = Tramite.find(params[:tramite_id])
    @tramite.update_attribute("documento", true)
    @producto_id             = params[:producto_id]
    @tramitando              = true
    @descripcion             = TipoDocumento.find(params[:tipo_id]).descripcion
    puts @tramitado
    flash[:accion] = "Agregar Documento"
    flash.keep
    render :action => :new
  end

  # GET /documentos/1/edit
  def edit
    @documento = Documento.find(params[:id])
  end

  # POST /documentos
  # POST /documentos.json
  def create
    @documento = Documento.new(params[:documento])
    doc = TipoDocumento.where(:descripcion => params[:documento][:TipoDocumento_attributes][:descripcion])
    #Si ya existe un tipo de documento, se usa esa instancia
    if doc.any?
      @documento.TipoDocumento_id = doc[0].id
    end

    @producto = Producto.find(@documento.producto_id)
    respond_to do |format|
      if @documento.save
          format.html { redirect_to @producto, notice: 'Documento creado exitosamente.', :format => :pdf }
          format.json { render json: @producto, status: :created, location: @documento }
      else
        @tipos = get_tipoDoc
        @documento.TipoDocumento = TipoDocumento.new
        @producto_id = @producto.id
        flash.keep
        format.html { render action: "new", alert: 'Documento no pudo ser creado.' }
        format.json { render json: @documento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /documentos/1
  # PUT /documentos/1.json
  def update
    @documento = Documento.find(params[:id])
    respond_to do |format|
      if @documento.update_attributes(params[:documento])
        format.html { redirect_to @documento, notice: 'Documento actualizado exitosamente.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit", alert: 'Documento no pudo ser actualizado.' }
        format.json { render json: @documento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documentos/1
  # DELETE /documentos/1.json
  def destroy
    @documento = Documento.find(params[:id])
    producto = Producto.find(@documento.producto_id)
    @documento.destroy

    respond_to do |format|
      format.html { redirect_to producto, notice: 'Documento eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end


  #Oculta un documento en vez de eliminarlo
  def ocultar
    doc = Documento.find(params[:id])
    @producto = Producto.find(doc.producto_id)

    x = doc.on
    if x == 0
      on = 1
    elsif x == 1
      on = 0
    end
    if doc.update_attribute("on", on)
      redirect_to @producto, notice: "Visibilidad cambiada."
    else
      redirect_to @producto, alert: "Visibilidad no cambiada."
    end
  end

  private 

    # Ocula un documento dado su id
    def ocultar_doc (id)
      doc = Documento.find(id)
      if doc.on == 0
        if doc.update_attribute("on",1)
          return true
        else
          return false
        end
      elsif doc.on == 1
        if doc.update_attribute("on",0)
          return true
        else
          return false
        end
      end
    end

    # Obtiene todos los tipos de documentos en la base de datos
    def get_tipoDoc
      typedoc = TipoDocumento.all
      tipos = []
      tipos.push("Otro")
      for type in typedoc do
        tipos.push(type.descripcion)
      end
      return tipos
    end
end
