class AddNotificationForUserListFirst < ActiveRecord::Migration
  def up
    notification = Notification.create(title: 'Your List First!', message: 'Now when you view this page, the list that you own will show up first in the list!')

    User.all.each do |user|
      user.notifications << notification
    end
  end
end
