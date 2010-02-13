class Abuse < ActiveRecord::Base
  THRESHOLD = 3 # abuses.

  belongs_to :content, polymorphic: true
  belongs_to :user

  validates_presence_of :content
  validates_uniqueness_of :user_id, scope: %w(content_type content_id)
  validates_uniqueness_of :token_id, scope: %w(content_type content_id user_id)

  attr_protected :user_id, :content_type, :content_id, :reporter_ip, :token_id
  after_save :abuse_content

  private

  def abuse_content
    if content.abuses.count >= THRESHOLD
      content.abuse!
    else
      case content
      when Failing
        content.abuse! if user == content.user
      when Comment
        content.abuse! if user == content.failing.user
      end
    end
  end
end
