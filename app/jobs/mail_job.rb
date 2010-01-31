class MailJob < Struct.new(:record)
  def perform
    case record
    when Failing
      Notifier.new_failing(record).deliver
    when Comment
      Notifier.new_comment(record).deliver
    end
  end
end
