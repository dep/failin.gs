class MailJob < Struct.new(:record)
  def perform
    case record
    when Failing
      return if record.user_id == record.submitter_id || !record.user.subscribe?
      Notifier.new_failing(record).deliver
    when Comment
      recipient = record.failing.user
      return if !recipient.subscribe? || recipient.id == record.user_id
      Notifier.new_comment(record).deliver
    when Invitation
      Notifier.new_invitation(record).deliver
    when Share
      Notifier.new_share(record).deliver
    when User
      Notifier.newly_invited(record).deliver
    end
  end
end
