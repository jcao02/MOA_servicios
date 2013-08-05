class RequisitosController < ApplicationController
  # GET /requisitos
  # GET /requisitos.json
  def index
    @requisitos = Requisito.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @requisitos }
    end
  end

  # GET /requisitos/1
  # GET /requisitos/1.json
  def show
    @requisito = Requisito.find(params[:id])
    render :layout => false
  end

  # GET /requisitos/new
  # GET /requisitos/new.json
  def new
    @requisito = Requisito.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @requisito }
    end
  end

  # GET /requisitos/1/edit
  def edit
    @requisito = Requisito.find(params[:id])
  end

  # POST /requisitos
  # POST /requisitos.json
  def create
    @requisito = Requisito.new(params[:requisito])

    respond_to do |format|
      if @requisito.save
        format.html { redirect_to @requisito, notice: 'Requisito was successfully created.' }
        format.json { render json: @requisito, status: :created, location: @requisito }
      else
        format.html { render action: "new" }
        format.json { render json: @requisito.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /requisitos/1
  # PUT /requisitos/1.json
  def update
    @requisito = Requisito.find(params[:id])

    respond_to do |format|
      if @requisito.update_attributes(params[:requisito])
        format.html { redirect_to @requisito, notice: 'Requisito was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @requisito.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requisitos/1
  # DELETE /requisitos/1.json
  def destroy
    @requisito = Requisito.find(params[:id])
    @requisito.destroy

    respond_to do |format|
      format.html { redirect_to requisitos_url }
      format.json { head :no_content }
    end
  end
end
