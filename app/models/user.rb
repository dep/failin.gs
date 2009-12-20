class User < ActiveRecord::Base
  # = Vendor
  acts_as_authentic # { |config| config.remember_me = true }

  # = Local
  #
  # == Associations
  has_many :failings

  # == Validations
  LOGIN_LENGTH = 1..17
  validates_length_of :login, :in => LOGIN_LENGTH
end
