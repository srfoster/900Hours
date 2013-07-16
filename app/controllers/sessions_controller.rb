class SessionsController < ApplicationController              
  def new
    redirect_to "/auth/thoughtstem"                           
  end                                                         
  
  def create
    auth = request.env["omniauth.auth"]                       
    session[:access_token] = auth["credentials"]["token"]     
    redirect_path = session[:return_to]
    session[:return_to] = nil
    redirect_to redirect_path || root_url

    @current_user = User.find_or_create_from_provider_info(auth)

    session[:user_id] = @current_user.id
  end

  def show
    logger.info("we're back from the SSO site. redirect to root")
    redirect_to root_url
  end

  def destroy
    if !access_token or !current_remote_user
       redirect_to "/"
    end
    session[:access_token] = nil
    session[:user_id] = nil
  end
end
