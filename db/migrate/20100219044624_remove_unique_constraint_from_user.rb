class RemoveUniqueConstraintFromUser < ActiveRecord::Migration
  def self.up
    remove_index :users, :login
    add_index :users, :login
    add_index :users, [:login, :state]
  end

  def self.down
    remove_index :users, :login
    add_index :users, :login, unique: true
    remove_index :users, [:login, :state]
  end
end
