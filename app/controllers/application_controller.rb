class ApplicationController < ActionController::Base
  protect_from_forgery
  require 'ostruct'

  # Add a general rescue to handle an invalid access_token.
  rescue_from OAuth2::Error do |exception|
    logger.error("OAuth2 exception: #{exception.inspect}")
    if exception.response.status == 401
      session[:user_id] = nil
      session[:access_token] = nil
      redirect_to root_url, alert: "Access token expired, try signing in again."
    end
  end

  # Add this as a before filter on any areas you want to require authentication.
  def authorize_user!
    # if we have an access token, run with it, otherwise, go get one
    unless session[:access_token]
      session[:return_to] = request.path if request.path
      redirect_to new_session_path
      return false
    end
    true
  end
  
  #Michael's Method
  def is_student?
	unless current_user.is_approved_student?
	  return false
	end
	return true
  end
	  
  def is_teacher?
	unless current_user.is_approved_teacher?
	  return false
	end
	return true
  end
  
  def is_admin?
    unless current_user.is_admin?
	  return false
    end
	return true
  end
  
  #Check whether the user is approved student, teacher, or admin
  def authorize_approved!
	unless is_student? || is_teacher? || is_admin?
	  respond_to do |format|
	    format.html {redirect_to root_url}
		format.json {render json: {}, status: 401}
	  end
	return false
    end
	true
  end
  
  

private

  # Return the oauth_client. Used by access_token
  def oauth_client
    @oauth_client ||= OAuth2::Client.new(ENV["THOUGHTSTEM_ID"], ENV["THOUGHTSTEM_SECRET"], site: ENV["THOUGHTSTEM_SITE"])
  end

  # Used by the various controllers as an endpoint into the sso api.
  def access_token
    if session[:access_token]
      @access_token ||= OAuth2::AccessToken.new(oauth_client, session[:access_token])
    end
  end

  def current_remote_user
    @access_token.get("/api/user")
  end

  # Helper to access the current_user. This is fetched from the sso app via the /api/user call.
  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end

    @current_user
  end
  helper_method :current_user
end
