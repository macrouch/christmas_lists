class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :is_logged_in

  helper_method :current_user

  private

  def current_user
    @current_user ||= User.where(id: session[:user_id]).first if session[:user_id]
  end

  def is_logged_in
    unless current_user
      flash[:error] = "You must be logged in"
      redirect_to root_url
    end
  end
end
