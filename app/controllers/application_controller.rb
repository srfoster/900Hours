class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user
  before_filter :save_location
  before_filter :current_user

  private

    def current_user
      @current_user ||= session[:user]
    end

    def save_location
      if request.xhr?
          return
      end

      session[:previous_url] = session[:current_url]
      session[:current_url] = request.fullpath
    end

    def is_admin(user)
      false
    end

end
