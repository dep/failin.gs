class MailJob
  @queue = :mail

  def self.perform(record_type, record_id)
    record = record_type.constantize.find record_id

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
    end
  rescue => e
    Notifier.new_exception(e).deliver
    raise
  end

  def self.perform_exception(exception, env = nil)
    Notifier.new_exception(record, env).deliver
  end
end
