class SessionsController < ApplicationController

  def create

    info = request.env["omniauth.auth"]

    if info["provider"] == "facebook"
        user = User.find_by_facebook_info(info)
        
        if user.nil?
            user = User.create_from_facebook_info(info)
        end

        session[:user] = user.id
    end

    redirect_to previous_url
  end

  def destroy
    session[:user] = nil
    redirect_to previous_url
  end
  
  private
  
    def previous_url
      session[:previous_url] || root_path
    end

end
