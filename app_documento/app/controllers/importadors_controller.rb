class ImportadorsController < ApplicationController
  # GET /importadors
  # GET /importadors.json
  def index
    @importadors = Importador.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @importadors }
    end
  end

  # GET /importadors/1
  # GET /importadors/1.json
  def show
    @importador = Importador.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @importador }
    end
  end

  # GET /importadors/new
  # GET /importadors/new.json
  def new
    @importador = Importador.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @importador }
    end
  end

  # GET /importadors/1/edit
  def edit
    @importador = Importador.find(params[:id])
  end

  # POST /importadors
  # POST /importadors.json
  def create
    @importador = Importador.new(params[:importador])

    respond_to do |format|
      if @importador.save
        format.html { redirect_to @importador, notice: 'Importador was successfully created.' }
        format.json { render json: @importador, status: :created, location: @importador }
      else
        format.html { render action: "new" }
        format.json { render json: @importador.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /importadors/1
  # PUT /importadors/1.json
  def update
    @importador = Importador.find(params[:id])

    respond_to do |format|
      if @importador.update_attributes(params[:importador])
        format.html { redirect_to @importador, notice: 'Importador was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @importador.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /importadors/1
  # DELETE /importadors/1.json
  def destroy
    @importador = Importador.find(params[:id])
    @importador.destroy

    respond_to do |format|
      format.html { redirect_to importadors_url }
      format.json { head :no_content }
    end
  end
end