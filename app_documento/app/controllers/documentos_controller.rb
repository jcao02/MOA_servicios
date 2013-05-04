#encoding: UTF-8
class DocumentosController < ApplicationController
  before_filter :is_admin, :only => [:new, :create, :destroy]
  # GET /documentos
  # GET /documentos.json
  def index
    @documentos = Documento.all

    respond_to do |format|
      format.html # index.html.erb
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

  def get_tipoDoc
    typedoc = TipoDocumento.all
    tipos = []
    tipos.push("Otro")
    for type in typedoc do
      tipos.push(type.descripcion)
    end
    return tipos
  end
  # GET /documentos/new
  # GET /documentos/new.json
  def new
    @documento = Documento.new
    @documento.TipoDocumento = TipoDocumento.new
    @tipos = get_tipoDoc
    flash[:accion] = "Agregar Documento"
    flash.keep

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @documento }
    end
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
    @documento.producto_id = session[:producto]
    @producto = Producto.find(session[:producto])

    respond_to do |format|
      if @documento.save
        session[:producto] = nil
        format.html { redirect_to @producto, notice: 'Documento was successfully created.', :format => :pdf }
        format.json { render json: @producto, status: :created, location: @documento }
      else
        @tipos = get_tipoDoc
        @documento.TipoDocumento = TipoDocumento.new
        flash.keep
        format.html { render action: "new" }
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
        format.html { redirect_to @documento, notice: 'Documento was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
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
      format.html { redirect_to producto }
      format.json { head :no_content }
    end
  end
end
