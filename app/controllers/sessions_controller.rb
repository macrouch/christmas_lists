class SessionsController < ApplicationController
  skip_before_filter :is_logged_in

  def index
    if current_user
      @groups = current_user.groups
      if @groups.empty?
        redirect_to groups_path
        return
      end

      @collections = @groups.first.collections

      redirect_to collection_path(@collections.first)
    else

      respond_to do |format|
        format.html { render :layout => "non_user" }
      end
    end
  end

  def new
    respond_to do |format|
      format.html { render :layout => "non_user" }
    end
  end

  def create
    user = User.from_omniauth(env['omniauth.auth'])
    session[:user_id] = user.id
    flash[:notice] = 'Signed in'
    redirect_back_or root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Signed out'
  end

  def failure
    redirect_to root_url, flash: { error: 'Authentication failed, please try again'}
  end
end
