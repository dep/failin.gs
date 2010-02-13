class Abuse < ActiveRecord::Base
  THRESHOLD = 2 # abuses.

  belongs_to :content, polymorphic: true
  belongs_to :user

  validates_presence_of :content
  validates_uniqueness_of :user_id, scope: [:content_type, :content_id, :reporter_ip]
  validates_uniqueness_of :reporter_ip, scope: [:content_type, :content_id, :user_id]

  attr_protected :user_id, :content_type, :content_id, :reporter_ip
  after_save :abuse_content

  private

  def abuse_content
    content.abuse! if user == content.user || content.abuses.count >= THRESHOLD
  end
end
