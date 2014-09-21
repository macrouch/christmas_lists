class UserMailer < ActionMailer::Base
  default from: "no-reply@sleekcoder.com"

  def activation_email(user)
    @user = user
    mail(to: @user.email, from: "\"SleekCoder Christmas Lists\" <sleekcoder@gmail.com>", subject: 'Welcome to Christmas Lists!')
  end

  def invitation_email(user, group, emails)
    @user = user
    @group = group
    mail(to: emails, from: "\"SleekCoder Christmas Lists\" <sleekcoder@gmail.com>", subject: "#{@user.name} has invited you to a group")
  end

  def password_reset(user)
    @user = user
    mail(to: @user.email, from: "\"SleekCoder Christmas Lists\" <sleekcoder@gmail.com>", subject: 'Reset Password at Christmas Lists')
  end
end
