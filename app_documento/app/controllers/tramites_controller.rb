class TramitesController < ApplicationController
  # GET /tramites
  # GET /tramites.json
  def index
    @tramites = Tramite.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tramites }
    end
  end

  # GET /tramites/1
  # GET /tramites/1.json
  def show
    @tramite = Tramite.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tramite }
    end
  end

  # GET /tramites/new
  # GET /tramites/new.json
  def new
    @tramite = Tramite.new

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

    respond_to do |format|
      if @tramite.save
        format.html { redirect_to @tramite, notice: 'Tramite was successfully created.' }
        format.json { render json: @tramite, status: :created, location: @tramite }
      else
        format.html { render action: "new" }
        format.json { render json: @tramite.errors, status: :unprocessable_entity }
      end
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
