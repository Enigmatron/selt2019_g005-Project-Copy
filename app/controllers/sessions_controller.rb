class SessionsController < ApplicationController
  skip_before_action :set_current_user, raise: false # calls the current user method in application controller

  def session__params
    params.require(:user).permit(:handle, :password, :session_token)
  end
  def new

  end

  def create
    auth = request.env['omniauth.auth']

    puts 'kiii'
    if !auth.nil?
      puts 'hihihi'
      auth[:handle] = auth['info']['email']
      auth[:password] = auth['uid']
      user = User.find_by(handle: auth['handle']) || User.create_with_omniauth(auth)

      session[:session_token] = user.session_token
      user.ip_address = request_ip
      user.geocode

      redirect_to topics_path
    elsif User.find_by(handle: session__params[:handle]).nil?
      flash[:notice] = 'Invalid user-id/email combination.'
      redirect_to login_path
    else
      user = User.find_by(handle: session__params[:handle])
      if user && user.authenticate(params[:user][:password])
        session[:session_token] = user.session_token
        user.ip_address = request_ip
        user.geocode
        if user.Admin
          redirect_to users_admin_path
        else
          redirect_to topics_path
        end
      else
        flash[:notice] = 'Invalid user-id/email combination.'
        redirect_to login_path
      end
    end
  end

  def destroy
    reset_session
    redirect_to topics_path
  end
end
