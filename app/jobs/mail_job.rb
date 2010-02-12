class MailJob < Struct.new(:record)
  def perform
    case record
    when Failing
      Notifier.new_failing(record).deliver if record.user.subscribe?
    when Comment
      recipient = record.failing.user
      return if !recipient.subscribe? || recipient == record.user
      Notifier.new_comment(record).deliver if record.failing.user.subscribe?
    when Invitation
      Notifier.new_invitation(record).deliver
    when Share
      Notifier.new_share(record).deliver
    when User
      Notifier.newly_invited(record).deliver
    end
  end
end
