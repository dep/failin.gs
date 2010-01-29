class AddUserIdToVote < ActiveRecord::Migration
  def self.up
    add_column :votes, :user_id, :integer
    add_index :votes, :user_id
  end

  def self.down
    remove_index :votes, :user_id
    remove_column :votes, :user_id
  end
end
