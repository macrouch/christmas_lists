class UserMailer < ActionMailer::Base
  default from: "no-reply@sleekcoder.com"

  def activation_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Christmast Lists!')
  end

  def invitation_email(user, group, emails)
    @user = user
    @group = group
    mail(to: emails, subject: "#{@user.name} has invited you to a group")
  end
end
