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

  def new_invitation(invitation)
    @invitation = invitation
    @inviter = invitation.inviter

    mail to: @invitation.email,
    subject: "You've been invited!"
  end

  def new_share(share)
    @inviter = share.user
    @share = share

    mail to: "notifier@failin.gs",
    subject: "You've been invited!",
        bcc: @share.emails
  end
end
