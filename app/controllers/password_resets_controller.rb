class PasswordResetsController < ApplicationController
  skip_before_filter :is_logged_in
  before_action :set_user, only: [:edit, :update]
  layout "non_user"

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    redirect_to root_url, :notice => "Email sent with password reset instructions."
  end

  def edit
    unless @user
      redirect_to root_url, :alert => "Password reset has expired."
    end
  end

  def update
    if @user && @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset has expired."
    else
      @identity.password = params[:user][:password]
      @identity.password_confirmation = params[:user][:password_confirmation]
      success = @identity.save
      if success
        @user.password_reset_token = nil
        @user.password_reset_sent_at = nil
        @user.save
        redirect_to root_url, notice: 'Password has been reset'
      else
        render :edit
      end
    end
  end

  private

  def set_user
    @user = User.find_by_password_reset_token(params[:id])
    begin
      @identity = Identity.find(@user.uid) if @user
    rescue
      provider = @user.provider
      provider = 'Google' if provider == 'google_oauth2'
      provider = 'Facebook' if provider == 'facebook'
      redirect_to root_url, notice: "You used #{provider} to create your account. Please use the #{provider} button to login."
    end
  end
end
