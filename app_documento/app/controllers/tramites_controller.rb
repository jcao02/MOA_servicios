class TramitesController < ApplicationController
  # GET /tramites
  # GET /tramites.json
  def index
    #Seleccion de tramites a mostrar
    if current_usuario.admin == 0
        flash[:title] = "Mis solicitudes"
        @tramites = Tramite.where(:usuario_id => current_usuario.id)
    else
        flash[:title] = "Solicitudes"
        @tramites = Tramite.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tramites }
    end
  end

  # GET /tramites/1
  # GET /tramites/1.json
  def show
    @tramite = Tramite.find(params[:id])
    @req_faltantes = 10

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tramite }
    end
  end

  # GET /tramites/new
  # GET /tramites/new.json
  def new
      if current_usuario.admin == 0
          @productos = Producto.where(:usuario_id => current_usuario.id)
      else
          @productos = Producto.all
      end
      @tipos     = TipoDocumento.all
      @tramite   = Tramite.new

      respond_to do |format|
          format.html # new.html.erb
          format.json { render json: @tramite }
      end
  end

  # GET /tramites/1/edit
  def edit
    @tramite = Tramite.find(params[:id])
  end

  # POST /tramites
  # POST /tramites.json
  def create
    @tramite = Tramite.new(params[:tramite])
    if not @tramite.producto_id.is_a? Integer
        @tramite.producto_id = nil
    end

    @tramite.estado = "Recibido"
    @tramite.usuario_id = current_usuario.id
    crear_requisitos(@tramite.TipoDocumento_id, @tramite)
    respond_to do |format|
      if @tramite.save
        format.html { redirect_to tramites_path, notice: 'Tramite was successfully created.' }
        format.json { render json: tramites_path, status: :created, location: @tramite }
      else
        format.html { render action: "new" }
        format.json { render json: @tramite.errors, status: :unprocessable_entity }
      end
    end
  end

  #Crea los requisitos dependiendo del tramite
  def crear_requisitos(documento, tramite)
      dependencias = Dependencia.where(:tipo_documento_id => documento)
      dependencias.each do |d|
        req = Requisito.new(:estado => "Sin recibir", :tramite_id => tramite.id, :TipoRequisito_id => d.tipo_requisito_id)
        tramite.requisitos << req
      end
  end

  #Acepta o rechaza la solicitud de un tramite
  def check
      @tramite = Tramite.find(params[:id])
      #Si se le dio a rechazar, se elimina.
      if params[:tramite][:recibido] == "false"
          @tramite.destroy
          redirect_to tramites_path
      #Si se le dio a aceptar, se pone visible
      else
          @tramite.update_attributes(params[:tramite])
          redirect_to @tramite
      end
  end

  # PUT /tramites/1
  # PUT /tramites/1.json
  def update
    @tramite = Tramite.find(params[:id])

    respond_to do |format|
      if @tramite.update_attributes(params[:tramite])
        format.html { redirect_to @tramite, notice: 'Tramite was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tramite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tramites/1
  # DELETE /tramites/1.json
  def destroy
    @tramite = Tramite.find(params[:id])
    @tramite.destroy

    respond_to do |format|
      format.html { redirect_to tramites_url }
      format.json { head :no_content }
    end
  end
end
