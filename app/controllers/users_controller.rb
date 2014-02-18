class UsersController < ApplicationController
  before_action :set_user, except: [:join_group, :activate]

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

  def join_group
    @user = current_user
    @group = Group.where(id: params[:id]).first
    answer = params[:answer]

    respond_to do |format|
      if answer.downcase == @group.answer.downcase
        @user.groups << @group
        format.html { redirect_to groups_path, notice: 'Group joined' }
      else
        format.html { redirect_to join_group_path(@group.id), alert: 'Incorrect answer, try again' }
      end
    end
  end

  def leave_group
    @user = current_user
    @group = Group.where(id: params[:id]).first

    if @group.user == @user
      redirect_to groups_path, notice: "You can't leave #{@group.name}"
      return
    end

    respond_to do |format|
      if @user.groups.destroy(@group)
        format.html { redirect_to groups_path, notice: 'Left group successfully' }
      else
        format.html { redirect_to groups_path, alert: 'Could not leave group' }
      end
    end
  end

  def activate
    user = User.where(email_token: params[:token]).first
    user.active = true
    user.save

    if user.original_url
      redirect_to url_for(user.original_url), notice: "Account activated"
    else
      redirect_to root_url, notice: "Account activated"
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
    @identity = Identity.find(@user.uid)
  end
end
