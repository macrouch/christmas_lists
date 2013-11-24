class UsersController < ApplicationController
  before_action :set_user

  def edit    
  end

  def update
    @identity.password = params[:user][:password]
    @identity.password_confirmation = params[:user][:password_confirmation]
    success = @identity.save

    respond_to do |format|
      if success
        format.html { redirect_to lists_url, notice: 'Password successfully changed' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
    @identity = Identity.find(@user.uid)
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
