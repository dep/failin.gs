class Email < ActiveRecord::Base
  def save
    super
  rescue ActiveRecord::RecordNotUnique => e
    errors.add :address, "has already signed up"
  end
end
