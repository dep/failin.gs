class FixIndices < ActiveRecord::Migration
  def self.up
    remove_index :abuses, [:content_type, :content_id, :user_id]
    add_index :abuses, [:content_type, :content_id, :user_id]

    remove_index :votes, [:failing_id, :user_id]
    add_index :votes, [:failing_id, :user_id]
    add_index :votes, [:failing_id, :token_id] # , unique: true
  end

  def self.down
    remove_index :abuses, [:content_type, :content_id, :user_id]
    add_index :abuses, [:content_type, :content_id, :user_id], unique: true

    remove_index :votes, [:failing_id, :user_id]
    remove_index :votes, [:failing_id, :token_id]
    add_index :votes, [:failing_id, :user_id], unique: true
  end
end
