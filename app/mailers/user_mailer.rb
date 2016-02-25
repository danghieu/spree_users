class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome_email,.subject
  #
  def welcome_email(user)
    @greeting = "Hi"

    mail to: user.email
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.forgot_password_email.subject
  #
  def forgot_password_email(user)
    @user = user
    # @url = "http://sheltered-stream-93214.herokuapp.com/#/main/reset_password?id=#{user.id}&token=#{user.reset_password_token}"
    @url = "http://localhost:9000/#/main/reset_password?id=#{user.id}&token=#{user.reset_password_token}"

    mail to: user.email
  end

  def password_change_email(user)
    @user = user

    mail to: user.email
  end
  
end
