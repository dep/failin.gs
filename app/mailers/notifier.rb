class Notifier < ActionMailer::Base
  default :from => "notifier@failin.gs"

  def new_failing(failing)
    @failing = failing
    @user = failing.user

    mail to: @user.email,
    subject: "New failing!"
  end

  def new_comment(comment)
    @comment = comment
    @user = comment.failing.user

    mail to: @user.email,
    subject: "New comment!"
  end
end
