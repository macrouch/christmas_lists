class UserMailer < ActionMailer::Base
  default from: "no-reply@sleekcoder.com"

  def activation_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Christmast Lists!')
  end
end
