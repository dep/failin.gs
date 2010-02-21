class PasswordReset
  extend ActiveModel::Naming
  include ActiveModel::Validations

  def to_model()    self end
  def to_key()           end
  def new_record?() true end
  def destroyed?()  true end
  def id()               end
  def persisted?() false end

  validates_presence_of :user, message: "not found with that email address"

  def initialize(attrs = nil)
    attrs ||= {}
    self.email = attrs[:email]
  end

  def save(*)
    valid?.tap { |success| deliver_instructions if success }
  end

  def email
    @email
  end

  def email=(email)
    @email = email
    remove_instance_variable :@user if instance_variable_defined? :@user
  end

  def user
    return @user if defined? @user
    @user = User.find_by_email(email) unless email.blank?
  end

  private

  def deliver_instructions
    unless user.blank?
      user.reset_perishable_token!
      PasswordMailer.new_password(user).deliver
    end
  end
end
