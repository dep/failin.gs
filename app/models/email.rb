class Email < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :address

  def save
    super
  rescue ActiveRecord::RecordNotUnique => e
    errors.add :address, "has already signed up"
  end
end
