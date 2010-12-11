class AddFacebookFieldsToUser < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.string :facebook_id, :facebook_token
    end

    add_index :users, :facebook_id
    add_index :users, :facebook_token
  end

  def self.down
  end
end
