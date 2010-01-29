class User < ActiveRecord::Base
  # = Vendor
  acts_as_authentic # { |config| config.remember_me = true }

  # = Local
  #
  # == Associations
  has_many :failings

  # == Validations
  LOGIN_LENGTH = 1..17
  validates :login, length: LOGIN_LENGTH, format: /\w+/
  validates_presence_of :surname

  def to_param
    login
  end
end
