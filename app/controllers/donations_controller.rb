class DonationsController < ApplicationController
  # GET /donations
  # GET /donations.json
  def index

    if(params[:totals])
      donations = Donation.all
      total_donations = donations.size
      total_dollars   = donations.inject(0){|f,s| f + s.amount}
      your_donations = donations.select{|d| d.user_id == session[:user]}.size
      
      render :json => {:total_dollars => total_dollars, :total_donations => total_donations, :your_donations=>your_donations} and return
    end

    raise "You're not authorized"

  end

  # GET /donations/1
  # GET /donations/1.json
  def show
    raise "You're not authorized"
    @donation = Donation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @donation }
    end
  end

  # GET /donations/new
  # GET /donations/new.json
  def new
    raise "You're not authorized"
    @donation = Donation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @donation }
    end
  end

  # GET /donations/1/edit
  def edit
    raise "You're not authorized"
    @donation = Donation.find(params[:id])
  end

  # POST /donations
  # POST /donations.json
  def create
    raise "You're not authorized"
    @donation = Donation.new(params[:donation])

    respond_to do |format|
      if @donation.save
        format.html { redirect_to @donation, notice: 'Donation was successfully created.' }
        format.json { render json: @donation, status: :created, location: @donation }
      else
        format.html { render action: "new" }
        format.json { render json: @donation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /donations/1
  # PUT /donations/1.json
  def update
    raise "You're not authorized"
    @donation = Donation.find(params[:id])

    respond_to do |format|
      if @donation.update_attributes(params[:donation])
        format.html { redirect_to @donation, notice: 'Donation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @donation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /donations/1
  # DELETE /donations/1.json
  def destroy
    raise "You're not authorized"
    @donation = Donation.find(params[:id])
    @donation.destroy

    respond_to do |format|
      format.html { redirect_to donations_url }
      format.json { head :no_content }
    end
  end
end
