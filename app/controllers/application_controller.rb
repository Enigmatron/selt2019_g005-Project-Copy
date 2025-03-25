class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def set_current_user
    @current_user ||= session[:session_token] && User.find_by_session_token(session[:session_token])
  end

  def request_ip
    if Rails.env.development?
      ip = '129.255.224.49'
    else
      request.remote_ip
    end
  end
  # protected
  #
  # def current_user?(id)
  #   @current_user.id.to_s == id
  # end

end
