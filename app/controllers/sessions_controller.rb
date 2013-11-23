class SessionsController < ApplicationController
  skip_before_filter :is_logged_in

  def new
    respond_to do |format|
      format.html { render :layout => "non_user" }
    end    
  end

  def create
    user = User.from_omniauth(env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to root_url, notice: 'Signed in'
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_url, notice: 'Signed out'
  end

  def failure
    redirect_to login_url, flash: { error: 'Authentication failed, please try again'}
  end
end
