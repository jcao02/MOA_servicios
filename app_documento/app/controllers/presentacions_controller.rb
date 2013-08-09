#encoding: UTF-8
class PresentacionsController < ApplicationController
  before_filter :authenticate_usuario! #Para que se requiera estar logueado
  before_filter :is_admin, :except => :show
  #todavia falta before_filter para que solo el dueño del producto vea la presentacion
  # GET /presentacions
  # GET /presentacions.json
  def index
    @presentacions = Presentacion.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @presentacions }
    end
  end

  # GET /presentacions/1
  # GET /presentacions/1.json
  def show
    @presentacion = Presentacion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @presentacion }
    end
  end

  # GET /presentacions/new
  # GET /presentacions/new.json
  def new
    @presentacion = Presentacion.new
    @presentacion.documentos.build
    @productos_id = params[:producto_id]
    flash[:accion] = "Nueva Presentación"
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @presentacion }
    end
  end

  # GET /presentacions/1/edit
  def edit
    @presentacion = Presentacion.find(params[:id])
  end

  # POST /presentacions
  # POST /presentacions.json
  def create
    @presentacion = Presentacion.new(params[:presentacion])
    @producto = Producto.find(params[:presentacion][:productos_id])

    respond_to do |format|
      if @presentacion.save
        format.html { redirect_to @producto, notice: 'Presentación creada exitosamente.' }
        format.json { render json: @presentacion, status: :created, location: @presentacion }
      else
        @productos_id = @producto.id
        @presentacion.documentos.build
        flash.keep
        format.html { render action: "new", alert: 'Presentación no pudo ser creada.' }
        format.json { render json: @presentacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /presentacions/1
  # PUT /presentacions/1.json
  def update
    @presentacion = Presentacion.find(params[:id])

    respond_to do |format|
      if @presentacion.update_attributes(params[:presentacion])
        format.html { redirect_to @presentacion, notice: 'Presentación actualizada exitosamente.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit", alert: 'Presentación no pudo ser actualizada.' }
        format.json { render json: @presentacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /presentacions/1
  # DELETE /presentacions/1.json
  def destroy
    @presentacion = Presentacion.find(params[:id])
    @presentacion.destroy
    producto = Producto.find(session[:producto])

    respond_to do |format|
      session[:producto] = nil
      format.html { redirect_to producto, notice: 'Presentación eliminada exitosamente.' }
      format.json { head :no_content }
    end
  end
end
