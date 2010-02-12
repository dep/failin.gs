class Email < ActiveRecord::Base
  belongs_to :user

  validates_format_of :address, with: /^.+@.+$/,
    message: "doesn't look like an email"

  def save
    super
  rescue ActiveRecord::RecordNotUnique => e
    errors.add :address, "has already signed up"
    false
  end
end
