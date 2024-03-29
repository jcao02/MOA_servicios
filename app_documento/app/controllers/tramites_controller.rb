#encoding: UTF-8
class TramitesController < ApplicationController
  before_filter :actualizar_alertas
  #Para los estados:
  # 0 -> enviado (blanco)
  # 1 -> recibido (azul)
  # 2 -> en proceso (amarillo)
  # 3 -> aceptado (verde)
  # 4 -> rechazado (no se elimina, solo se pide algun otro requisito) (rojo)
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

    @documentos = TipoDocumento.order('id DESC').all
    @documentos = @documentos.take(30)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tramites }
    end
  end

  #Obtiene los requisitos faltantes. (considerar agregar esto a la base de datos)
  def get_faltantes(tramite)
    req_faltantes = 0
    tramite.requisitos.each do |r| 
        req_faltantes += 1 unless r.estado == 3
    end
    return req_faltantes
  end

  # GET /tramites/1
  # GET /tramites/1.json
  def show
    @tramite = Tramite.find(params[:id])
    @req_faltantes = get_faltantes @tramite

    if @tramite.producto.nil? 
      nombre = "Producto no registrado"
    else
      nombre = @tramite.producto.nombre
    end

    logt = Logtramite.new(:usuario_id => current_usuario.id,
                          :tramite_id => @tramite.id, 
                          :tipo => "Visualizado", 
                          :nusuario => current_usuario.nombre, 
                          :ntipodocumento => @tramite.TipoDocumento.descripcion, 
                          :nproducto => nombre, 
                          :producto_id => @tramite.producto_id)

    if logt.save
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @tramite }
      end
    else
      format.json { render json: @tramite, notice:"La información no fue almacenada en el log." }
    end
  end

  #Obtiene el listado de productos
  def get_products(usuario)
      if usuario.admin == 0
          productos = Producto.where(:usuario_id => current_usuario.id)
      else
          productos = Producto.all
      end
      return productos
  end
  # GET /tramites/new
  # GET /tramites/new.json
  def new
      @productos = get_products(current_usuario)
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
    @tramite.estado = 0
    @tramite.usuario_id = current_usuario.id

    respond_to do |format|
      if @tramite.save
        format.html { redirect_to tramites_path, notice: 'Tramite creado.' }
        format.json { render json: tramites_path, status: :created, location: @tramite }
      else
        @productos = get_products(current_usuario)
        @tipos     = TipoDocumento.all
        @tramite   = Tramite.new
        flash[:notice] = 'Debe seleccionar un tipo de solicitud'
        format.html { render action: "new", alert: 'Tramite no creado.'}
        format.json { render json: @tramite.errors, status: :unprocessable_entity }
      end
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

  #Vista solicitudes por usuario
  def tramites_usuario
    usuario = Usuario.find(params[:usuario])
    flash[:title] = "Solicitudes de #{usuario.compania}"
    @tramites = Tramite.where(:usuario_id => usuario.id)
    flash[:tramites] = []
    4.times { flash[:tramites].push(@tramites) }
    @tramite = Tramite.new
    render "index"
  end

  # PUT /tramites/1
  # PUT /tramites/1.json
  def update
    @tramite = Tramite.find(params[:id])
    respond_to do |format|
      if @tramite.update_attributes(params[:tramite])
        format.html { redirect_to @tramite, notice: 'Tramite actualizado.' }
        format.json { head :no_content }
      else
        format.html { render action: "alert", notice: 'Tramite no actualizado.' }
        format.json { render json: @tramite.errors, status: :unprocessable_entity }
      end
    end
  end

  #Controlador para cambiar estado de requisitos
  def update_requisitos
    @tramite = Tramite.find(params[:requisito][:id])

    requisitos = @tramite.requisitos
    lista = []
    requisitos.each do |r|
      estado = params[:requisito][("estado#{r.id.to_s}").to_sym]
      #Solo se cambia atributos si tienen valor o no son iguales.
      if estado.nil? or estado == r.estado.to_s 
        next
      end
      observacion = params[:requisito][("observacion#{r.id.to_s}").to_sym]
      lista << r
      r.update_attribute(:estado, estado)
      if not observacion.blank?
        r.update_attribute(:observacion, observacion)
      end
    end


    #Se envia correo con requisitos actualizados sobre el tramite.
    # CorreosUsuario.aviso_requisitos(@tramite.usuario, lista, @tramite).deliver
    @req_faltantes = get_faltantes @tramite
    #Si ya no faltan requisitos, se manda un correo y se pone como listo el tramite
    if @req_faltantes == 0 
      # CorreosUsuario.aviso_tramite(@tramite.usuario, @tramite).deliver
      @tramite.update_attribute(:estado, 3)
    elsif @req_faltantes < requisitos.length
      @tramite.update_attribute(:estado, 2)
    end

    redirect_to @tramite
  end

  # DELETE /tramites/1
  # DELETE /tramites/1.json
  def destroy
    @tramite = Tramite.find(params[:id])
    @tramite.destroy

    respond_to do |format|
      format.html { redirect_to tramites_url, notice: 'Tramite eliminado.' }
      format.json { head :no_content }
    end
  end
end
