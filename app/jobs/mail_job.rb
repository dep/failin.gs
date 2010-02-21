class MailJob < Struct.new(:record, :env)
  def perform
    case record
    when Failing
      Notifier.new_failing(record).deliver
    when Comment
      failing_user = record.failing.user
      if failing_user.subscribe? && failing_user.id != record.user_id
        Notifier.new_comment(record).deliver
      end

      record.subscribers.each do |subscriber|
        Notifier.new_reply(record, subscriber).deliver
      end
    when Invitation
      Notifier.new_invitation(record).deliver
    when Share
      record.addresses.each do |email|
        Notifier.new_share(record, email).deliver
      end
    when User
      Notifier.newly_invited(record).deliver
    when Exception
      Notifier.new_exception(record, env).deliver
    end
  rescue => e
    Notifier.new_exception(e).deliver
    raise
  end
end
