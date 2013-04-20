class UsuariosController < ApplicationController
  before_filter :authenticate_usuario!
  respond_to :html, :js
  # GET /usuarios
  # GET /usuarios.json
  def index
    @usuarios = Usuario.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @usuarios }
    end
  end

  # GET /usuarios/1
  # GET /usuarios/1.json
  def show
    @usuario = Usuario.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @usuario }
    end
  end

  # GET /usuarios/new
  # GET /usuarios/new.json
  def new
    @usuario = Usuario.new
    flash[:accion] = "Crear Usuario"
    flash[:contrasena] = SecureRandom.hex(4)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @usuario }
    end
  end

  # GET /usuarios/1/edit
  def edit
    @usuario = Usuario.find(params[:id])
    flash[:accion] = "Editar Usuario"
  end

  def edit_password
    @usuario = current_usuario
    respond_with(@usuario, :layout => false)
  end
 # POST /usuarios
  # POST /usuarios.json
  def create
    @usuario = Usuario.new(params[:usuario])

    respond_to do |format|
      if @usuario.save
        CorreosUsuario.enviar_contrasena(@usuario, flash[:contrasena]).deliver
        format.html { redirect_to @usuario, notice: 'Usuario was successfully created.'}
        format.json { render json: @usuario, status: :created, location: @usuario }
      else
        flash.keep
        format.html { render action: "new" }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /usuarios/1
  # PUT /usuarios/1.json
  def update
    @usuario = Usuario.find(params[:id])
    params[:usuario].delete :password
    respond_to do |format|
      if @usuario.update_attributes(params[:usuario])
        format.html { redirect_to @usuario, notice: 'Usuario was successfully updated.' }
        format.json { head :no_content }
      else
        flash.keep
        format.html { render action: "edit" }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_password
    @usuario = Usuario.find(current_usuario.id)
    oldpass = params[:usuario][:oldpassword]
    newpass = params[:usuario][:password]

    lengthCondition = newpass.length < 8 or newpass.length > 16
    
    respond_to do |format|
      if @usuario.valid_password?(oldpass) and newpass == params[:usuario][:password_confirmation]
        @usuario.password = newpass
        if @usuario.valid? and !lengthCondition
          @usuario.update_attribute("password", newpass)
          sign_in(@usuario, :bypass => true) #Evita que cierre sesion automaticamente
        end
      elsif !@usuario.valid_password?(oldpass)
          @usuario.errors[:errorpassword] = "Contrasena actual invalida"
      else
          @usuario.errors[:errorpassword] = "Contrasenas no coinciden"
      end
      if lengthCondition
        @usuario.errors[:errorlength] = "Constrasena nueva invalida (debe tener entre 8 y 16 caracteres)"
      end
      format.json { render json: @usuario.errors }
    end

  end

  # DELETE /usuarios/1
  # DELETE /usuarios/1.json
  def destroy
    @usuario = Usuario.find(params[:id])
    @usuario.destroy

    respond_to do |format|
      format.html { redirect_to usuarios_url }
      format.json { head :no_content }
    end
  end
end
