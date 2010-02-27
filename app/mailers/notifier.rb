class Notifier < ActionMailer::Base
  default from: "Failin.gs Gang <notifier@failin.gs>"

  def new_user(user)
    @user = user

    mail to: @user.email,
    subject: "Welcome to failin.gs!"
  end

  def newly_invited(user)
    @user = @inviter = user.invitation.inviter
    @invited = user
    @url = profile_url @invited, via: "email"

    mail to: @inviter.email,
    subject: "#{@invited.email} has joined failin.gs!"
  end

  def new_failing(failing)
    @failing = failing
    @user = failing.user
    @url = profile_url @user, via: "email", anchor: dom_id(@failing)

    mail to: @user.email,
    subject: "New failing!"
  end

  def new_comment(comment)
    @comment = comment
    @user = comment.failing.user
    @url = failing_url @user, @comment.failing, via: "email", anchor: dom_id(@comment)

    mail to: @user.email,
    subject: "New failin.gs comment posted!"
  end

  def new_reply(comment, user)
    @comment = comment
    @user = user
    @someone = @comment.user_id == @comment.failing.user_id ? @comment.user.login : "Someone"
    @url = failing_url @comment.failing.user, @comment.failing, via: "email", anchor: dom_id(@comment)

    mail to: @user.email,
    subject: "New failin.gs reply posted!"
  end

  def new_invitation(invitation)
    @invitation = invitation
    @inviter = invitation.inviter

    mail to: @invitation.email,
    subject: "[failin.gs] Someone requested that you join us."
  end

  def new_share(share, email)
    @inviter = share.user
    @message = share.message

    mail to: email,
    subject: "[failin.gs] Please critique your friend!"
  end

  def new_exception(exception, env = nil)
    @exception, @env = exception, env
    @backtrace = Rails.backtrace_cleaner.send(:filter, @exception.backtrace)

    mail to: "stephen@failin.gs, danny@failin.gs",
       from: "app@failin.gs",
    subject: "[exception] #{@exception.class.name}" do |format|

      format.text {
        render text: [
          "#{@exception.class.name}: #{@exception.message}\n",
          "#{@env ? @env.inspect : "From a Delayed::Job!"}\n",
          *@backtrace
        ].join("\n  ")
      }
    end
  end

  private

  def dom_id(*args, &block)
    ActionController::RecordIdentifier.dom_id(*args, &block)
  end
end
