class CreateEmails < ActiveRecord::Migration
  def self.up
    create_table :emails do |t|
      t.belongs_to :user
      t.string :address

      t.timestamps
    end

    add_index :emails, :user_id, unique: true
    add_index :emails, :address, unique: true
  end

  def self.down
    drop_table :emails
  end
end
