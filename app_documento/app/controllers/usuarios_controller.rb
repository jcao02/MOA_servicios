#encoding: UTF-8
class UsuariosController < ApplicationController
  before_filter :authenticate_usuario! #Para que se requiera estar logueado
  before_filter :is_authorize, :only => [:edit, :update, :show] #Solo se puede editar, modificar o mostrar perfil si eres super admin o eres el usuario
  before_filter :is_admin, :only => [:new, :create] #Solo admin y super admin pueden crear usuarios
  before_filter :change_s_admin, :only => [:deshabilitar] #No se puede deshabilitar a un s-admin
  before_filter :actualizar_alertas
  skip_before_filter :authenticate_usuario!, :only =>[:ask_password, :recover_password, :send_password] #No se requiere estar logueado para recuperar contraseña
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
    @usuario    = Usuario.find(params[:id])
    clientesIds = Cliente.where(:usuario_id => params[:id])
    @clientes   = clientesIds.map{|c| Usuario.find(c.cliente_id)}

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @usuario }
    end
  end

  # GET /usuarios/new
  # GET /usuarios/new.json
  def new
    @usuario = Usuario.new
    @usuario.admin = 0
    @usuario.bloqueado = 0
    @usuario.transcriptor = true
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

  #Para mostrar el form de cambiar contraseña
  def edit_password
    @usuario = current_usuario
    respond_with(@usuario, :layout => false)
  end
 
  # POST /usuarios
  # POST /usuarios.json
  def create
    @usuario = Usuario.new(params[:usuario])
    if not @usuario.bloqueado or @usuario.admin == 2
      #Usuario esta habilitado
      @usuario.bloqueado = 0
    end

    respond_to do |format|
      if not @usuario.transcriptor and not @usuario.responsable
        flash.keep
        format.html { render action: "new", alert: 'El administrador debe ser transcriptor y/o responsable' }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end 

      if @usuario.save
        CorreosUsuario.enviar_contrasena(@usuario, flash[:contrasena], 1).deliver
        format.html { redirect_to @usuario, notice: 'Usuario creado exitosamente.'}
        format.json { render json: @usuario, status: :created, location: @usuario }
      else
        flash.keep
        format.html { render action: "new", alert: 'Usuario no pudo ser creado.' }
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
        if @usuario.admin == 2
          if @usuario.update_attribute("bloqueado", 0)
            format.html { redirect_to @usuario, notice: 'Usuario actualizado exitosamente.' }
            format.json { head :no_content }
          else
            flash.keep
            format.html { render action: "edit", alert: 'Usuario no pudo ser actualizado.' }
            format.json { render json: @usuario.errors, status: :unprocessable_entity }
          end
        else
          if ocultar_prod_usr(@usuario.id)
            format.html { redirect_to @usuario, notice: 'Usuario actualizado exitosamente.' }
            format.json { head :no_content }
          else
            format.html { redirect_to @usuario, notice: 'Usuario actualizado exitosamente.' }
            format.json { head :no_content }
          end
        end
      else
        flash.keep
        format.html { render action: "edit", alert: 'Usuario no pudo ser actualizado.' }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  #Cambiar contraseña con ajax
  def update_password
    @usuario = Usuario.find(current_usuario.id)
    oldpass = params[:usuario][:oldpassword]
    newpass = params[:usuario][:password]

    #Validacion de largo de contraseña manual
    lengthCondition = newpass.length < 8 or newpass.length > 16
    
    respond_to do |format|
      if @usuario.valid_password?(oldpass) and newpass == params[:usuario][:password_confirmation]
        @usuario.password = newpass
        if @usuario.valid? and !lengthCondition
          @usuario.update_attribute("password", newpass)
          sign_in(@usuario, :bypass => true) #Evita que cierre sesion automaticamente
        end
      elsif !@usuario.valid_password?(oldpass)
          @usuario.errors[:errorpassword] = "Contraseña actual inválida."
      else
          @usuario.errors[:errorpassword] = "Contraseñas no coinciden."
      end
      if lengthCondition
        @usuario.errors[:errorlength] = "Constraseña nueva inválida (debe tener entre 8 y 16 caracteres)."
      end
      format.json { render json: @usuario.errors }
    end
  end

  #Para ver el form de recuperar contraseña
  def ask_password
    @usuario = Usuario.new
    respond_with(@usuario, :layout => false)
  end

  #Recuperar contraseña
  def recover_password
    result = Usuario.where(:login => params[:usuario][:login])
    respond_to do |format|
      if result.length >= 1
        @usuario = result[0]
        CorreosUsuario.recuperar_contrasena(@usuario).deliver
      end
      format.json { render json: @usuario }
    end

  end

  #Enviar contraseña nueva
  def send_password
    @usuario = Usuario.find(params[:id])
    newpass = SecureRandom.hex(4)
    @usuario.update_attribute("password", newpass)
    CorreosUsuario.enviar_contrasena(@usuario, newpass, 2).deliver
    respond_to do |format|
      format.html
    end

  end

  # DELETE /usuarios/1
  # DELETE /usuarios/1.json
  def destroy
    @usuario = Usuario.find(params[:id])
    @usuario.destroy

    respond_to do |format|
      format.html { redirect_to usuarios_url, notice: 'Usuario eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end

  # Deshabilita usuarios
  # bloqueado = 0 -> no esta bloqueado
  # bloqueado = 1 -> bloqueado
  def deshabilitar
    @usuario = Usuario.find(params[:id])
    respond_to do |format|
      if @usuario.bloqueado == 0  
        if @usuario.update_attribute("bloqueado", 1)
          format.html { redirect_to @usuario, notice: 'Usuario was successfully updated.' }
          format.json { head :no_content }
        else
          flash.keep
          format.html { render action: "edit" }
          format.json { render json: @usuario.errors, status: :unprocessable_entity }
        end
      else @usuario.bloqueado == 1
        if @usuario.update_attribute("bloqueado", 0)
          format.html { redirect_to @usuario, notice: 'Usuario was successfully updated.' }
          format.json { head :no_content }
        else
          flash.keep
          format.html { render action: "edit" }
          format.json { render json: @usuario.errors, status: :unprocessable_entity }
        end        
      end
    end    
  end

  #Genera una nueva asignacion de clientes
  def new_asignar_cliente
    @usuario = Usuario.find(params[:format])
    @usuario.clientes.build
    @clientes = Usuario.where(:admin => 0)
  end

  #Asigna clientes a un responsable
  def asignar_cliente
    @usuario  = Usuario.find(params[:responsable])
    @clientes = params[:cliente]
    respond_to do |format|
      if @usuario.responsable? or @usuario.transcriptor?
        for cliente in @clientes.values
          nuevo = Cliente.create(:usuario_id => @usuario.id, :cliente_id => cliente)
          @usuario.clientes << nuevo
        end  
        format.html { redirect_to @usuario, notice: 'Clientes asignados satisfactoriamente'}
      else 
        format.html { redirect_to update_usuario_path, notice: 'Error en servidor. Intente más tarde' }
      end
    end
  end

end
