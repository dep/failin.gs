class Promotion < ActiveRecord::Base
  has_many :users

  attr_accessible :code, :limit

  def save
    super
  rescue ActiveRecord::RecordNotUnique => e
    errors.add :code, "is already used"
  end
end
