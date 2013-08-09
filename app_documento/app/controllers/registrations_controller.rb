class RegistrationsController < Devise::RegistrationsController

  def new
    @usuario = Usuario.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @usuario }
    end
  end

  def create

    print "hola"
    @usuario = Usuario.new(params[:usuario])

    respond_to do |format|
      if @usuario.save
        format.html { redirect_to @usuario, notice: 'Usuario creado exitosamente.' }
        format.json { render json: @usuario, status: :created, location: @usuario }
      else
        format.html { render action: "new", alert: 'Usuario no pudo ser creado.' }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  def update 
    super
  end

end
