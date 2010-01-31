class MailJob < Struct.new(:record)
  def perform
    case record
    when Failing
      Notifier.new_failing(record).deliver
    when Comment
      Notifier.new_comment(record).deliver
    when Invitation
      Notifier.new_invitation(record).deliver
    when Share
      Notifier.new_share(record).deliver
    end
  end
end
