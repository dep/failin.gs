class PasswordMailer < ActionMailer::Base
  default from: "Failin.gs Gang <passwords@failin.gs>"

  def new_password(user)
    @user = user

    mail to: @user.email,
    subject: "Password reset!"
  end
end
