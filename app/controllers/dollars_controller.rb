class DollarsController < ApplicationController
  # GET /dollars
  # GET /dollars.json
  def index
    @dollars = Dollar.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dollars }
    end
  end

  # GET /dollars/1
  # GET /dollars/1.json
  def show
    @dollar = Dollar.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dollar }
    end
  end

  # GET /dollars/new
  # GET /dollars/new.json
  def new
    @dollar = Dollar.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dollar }
    end
  end

  # GET /dollars/1/edit
  def edit
    @dollar = Dollar.find(params[:id])
  end

  # POST /dollars
  # POST /dollars.json
  def create
    @dollar = Dollar.new(params[:dollar])

    respond_to do |format|
      if @dollar.save
        format.html { redirect_to @dollar, notice: 'Dollar was successfully created.' }
        format.json { render json: @dollar, status: :created, location: @dollar }
      else
        format.html { render action: "new" }
        format.json { render json: @dollar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dollars/1
  # PUT /dollars/1.json
  def update
    @dollar = Dollar.find(params[:id])

    respond_to do |format|
      if @dollar.update_attributes(params[:dollar])
        format.html { redirect_to @dollar, notice: 'Dollar was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dollar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dollars/1
  # DELETE /dollars/1.json
  def destroy
    @dollar = Dollar.find(params[:id])
    @dollar.destroy

    respond_to do |format|
      format.html { redirect_to dollars_url }
      format.json { head :no_content }
    end
  end
end
