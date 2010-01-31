ActiveRecord::Base.class_eval do
  def attribute_names
    (@attributes || {}).keys.sort
  end
end
