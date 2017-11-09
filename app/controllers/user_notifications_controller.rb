class UserNotificationsController < ApplicationController
  def destroy
    UserNotification.where(id: params[:ids].split('/')).update_all(is_read: true)

    respond_to do |format|
      format.js
    end
  end
end
