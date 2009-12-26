class CreateEmails < ActiveRecord::Migration
  def self.up
    create_table :emails do |t|
      t.belongs_to :user
      t.string :address, :null => false
      t.string :invite_code

      t.timestamps
    end

    add_index :emails, :user_id, :unique => true
    add_index :emails, :address, :unique => true
    add_index :emails, :invite_code
  end

  def self.down
    drop_table :emails
  end
end
