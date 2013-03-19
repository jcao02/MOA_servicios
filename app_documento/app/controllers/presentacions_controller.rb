class PresentacionsController < ApplicationController
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

    respond_to do |format|
      if @presentacion.save
        format.html { redirect_to @presentacion, notice: 'Presentacion was successfully created.' }
        format.json { render json: @presentacion, status: :created, location: @presentacion }
      else
        format.html { render action: "new" }
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
        format.html { redirect_to @presentacion, notice: 'Presentacion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @presentacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /presentacions/1
  # DELETE /presentacions/1.json
  def destroy
    @presentacion = Presentacion.find(params[:id])
    @presentacion.destroy

    respond_to do |format|
      format.html { redirect_to presentacions_url }
      format.json { head :no_content }
    end
  end
end