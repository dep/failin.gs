class RemoveUniqueKeyConstraintFromUsers < ActiveRecord::Migration
  def self.up
    remove_index :users, :email
    add_index :users, :email
    add_index :users, [:email, :state], unique: true
  end

  def self.down
    remove_index :users, :email
    add_index :users, :email, unique: true
    remove_index :users, [:email, :state]
  end
end
