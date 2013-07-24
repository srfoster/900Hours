class TimezonesController < ApplicationController

  def create
	session[:tz] = params[:offset].to_i
	render :nothing => true
  end
end
