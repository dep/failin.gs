class ChangeDefaultSubscription < ActiveRecord::Migration
  def self.up
    change_column :users, :subscribe, :boolean, default: true, null: false
  end

  def self.down
    change_column :users, :subscrube, :boolean, default: nil
  end
end
