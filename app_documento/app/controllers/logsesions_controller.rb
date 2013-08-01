class LogsesionsController < ApplicationController
  # GET /logsesions
  # GET /logsesions.json
  def index
    @logsesions = Logsesion.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @logsesions }
    end
  end

  # GET /logsesions/1
  # GET /logsesions/1.json
  def show
    @logsesion = Logsesion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @logsesion }
    end
  end

  # GET /logsesions/new
  # GET /logsesions/new.json
  def new
    @logsesion = Logsesion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @logsesion }
    end
  end

  # GET /logsesions/1/edit
  def edit
    @logsesion = Logsesion.find(params[:id])
  end

  # POST /logsesions
  # POST /logsesions.json
  def create
    @logsesion = Logsesion.new(params[:logsesion])

    respond_to do |format|
      if @logsesion.save
        format.html { redirect_to @logsesion, notice: 'Logsesion was successfully created.' }
        format.json { render json: @logsesion, status: :created, location: @logsesion }
      else
        format.html { render action: "new" }
        format.json { render json: @logsesion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /logsesions/1
  # PUT /logsesions/1.json
  def update
    @logsesion = Logsesion.find(params[:id])

    respond_to do |format|
      if @logsesion.update_attributes(params[:logsesion])
        format.html { redirect_to @logsesion, notice: 'Logsesion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @logsesion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /logsesions/1
  # DELETE /logsesions/1.json
  def destroy
    @logsesion = Logsesion.find(params[:id])
    @logsesion.destroy

    respond_to do |format|
      format.html { redirect_to logsesions_url }
      format.json { head :no_content }
    end
  end
end
