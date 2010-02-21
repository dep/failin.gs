class AddOauthFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :oauth_token, :string
    add_column :users, :oauth_secret, :string
    add_index :users, [:state, :oauth_token]

    add_column :users, :twitter_id, :integer
    add_column :users, :twitter_screen_name, :string
    add_index :users, [:state, :twitter_screen_name]
  end

  def self.down
    remove_index :users, [:state, :oauth_token]
    remove_column :users, :oauth_token
    remove_column :users, :oauth_secret

    remove_index :users, [:state, :twitter_screen_name]
    remove_column :users, :twitter_id, :integer
    remove_column :users, :twitter_screen_name, :string
  end
end
