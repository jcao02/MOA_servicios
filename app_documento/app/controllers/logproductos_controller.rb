class LogproductosController < ApplicationController
  # GET /logproductos
  # GET /logproductos.json
  def index
    @logproductos = Logproducto.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @logproductos }
    end
  end

  def show_by_user
      @logs = Logproducto.where(:producto_id => params[:id])
  end
  # GET /logproductos/1
  # GET /logproductos/1.json
  def show
    @logproducto = Logproducto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @logproducto }
    end
  end

  # GET /logproductos/new
  # GET /logproductos/new.json
  def new
    @logproducto = Logproducto.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @logproducto }
    end
  end

  # GET /logproductos/1/edit
  def edit
    @logproducto = Logproducto.find(params[:id])
  end

  # POST /logproductos
  # POST /logproductos.json
  def create
    @logproducto = Logproducto.new(params[:logproducto])

    respond_to do |format|
      if @logproducto.save
        format.html { redirect_to @logproducto, notice: 'Logproducto was successfully created.' }
        format.json { render json: @logproducto, status: :created, location: @logproducto }
      else
        format.html { render action: "new" }
        format.json { render json: @logproducto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /logproductos/1
  # PUT /logproductos/1.json
  def update
    @logproducto = Logproducto.find(params[:id])

    respond_to do |format|
      if @logproducto.update_attributes(params[:logproducto])
        format.html { redirect_to @logproducto, notice: 'Logproducto was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @logproducto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /logproductos/1
  # DELETE /logproductos/1.json
  def destroy
    @logproducto = Logproducto.find(params[:id])
    @logproducto.destroy

    respond_to do |format|
      format.html { redirect_to logproductos_url }
      format.json { head :no_content }
    end
  end
end
