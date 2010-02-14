class CreateIdentities < ActiveRecord::Migration
  def self.up
    add_column :abuses,   :token_id, :string, null: false
    add_column :comments, :token_id, :string, null: false
    add_column :failings, :token_id, :string, null: false
    add_column :votes,    :token_id, :string, null: false

    add_index :abuses,   :token_id
    add_index :comments, :token_id
    add_index :failings, :token_id
    add_index :votes,    :token_id

    add_index :abuses, [:content_type, :content_id, :user_id], unique: true
    add_index :abuses, [:content_type, :content_id, :token_id, :user_id],
      unique: true, name: "by_token"
    add_index :abuses, [:content_type, :content_id, :token_id]

    add_index :failings, [:submitter_id, :token_id]

    remove_index :votes, [:failing_id, :voter_ip]
    add_index :votes, [:failing_id, :voter_ip]
    remove_index :votes, :user_id
    add_index :votes, [:failing_id, :user_id], unique: true
    add_index :votes, [:failing_id, :token_id, :user_id], unique: true
  end

  def self.down
    remove_index :abuses, [:content_type, :content_id, :user_id]
    remove_index :abuses, [:content_type, :content_id, :token_id]
    remove_index :abuses, "by_token"

    remove_index :failings, [:submitter_id, :token_id]

    add_index :votes, [:failing_id, :voter_ip], unique: true
    remove_index :votes, [:failing_id, :voter_ip]
    add_index :votes, :user_id
    remove_index :votes, [:failing_id, :user_id]
    remove_index :votes, [:failing_id, :token_id, :user_id]

    remove_index :abuses,   :token_id
    remove_index :comments, :token_id
    remove_index :failings, :token_id
    remove_index :votes,    :token_id

    remove_column :abuses,   :token_id
    remove_column :comments, :token_id
    remove_column :failings, :token_id
    remove_column :votes,    :token_id
  end
end
