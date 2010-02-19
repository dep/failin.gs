class Promotion < ActiveRecord::Base
  has_many :users

  attr_accessible :code, :limit

  def to_yaml_properties
    instance_variables.reject { |instance_variable|
      instance_variable_get(instance_variable).respond_to?(:proxy_owner)
    }.sort
  end

  def save
    super
  rescue ActiveRecord::RecordNotUnique => e
    errors.add :code, "is already used"
  end
end
