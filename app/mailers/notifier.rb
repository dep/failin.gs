class Notifier < ActionMailer::Base
  default from: "Failin.gs Gang <notifier@failin.gs>"

  def new_user(user)
    @user = user

    mail to: @user.email,
    subject: "Welcome to failin.gs!"
  end

  def newly_invited(user)
    @inviter = user.invitation.inviter
    @invited = user

    mail to: @inviter.email,
    subject: "#{@invited.email} has joined failin.gs!"
  end

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
    subject: "New failin.gs comment posted!"
  end

  def new_invitation(invitation)
    @invitation = invitation
    @inviter = invitation.inviter

    mail to: @invitation.email,
    subject: "[failin.gs] Someone requested that you join us."
  end

  def new_share(share)
    @inviter = share.user
    @message = share.message

    mail to: "notifier@failin.gs",
    subject: "[failin.gs] Please critique your friend!",
        bcc: @share.emails
  end

  def new_exception(exception, env)
    @exception, @env = exception, env
    @backtrace = Rails.backtrace_cleaner.send(:filter, @exception.backtrace)

    mail to: "stephen@failin.gs, danny@failin.gs",
       from: "app@failin.gs",
    subject: "[exception] #{@exception.class.name}" do |format|

      format.text {
        render text: [
          "#{@exception.class.name}: #{@exception.message}\n",
          "#{env.inspect}\n",
          *@backtrace
        ].join("\n  ")
      }
    end
  end
end
