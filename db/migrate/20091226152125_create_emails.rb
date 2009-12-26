class CreateEmails < ActiveRecord::Migration
  def self.up
    create_table :emails do |t|
      t.string :address

      t.timestamps
    end

    add_index :emails, :address, :unique => true
  end

  def self.down
    drop_table :emails
  end
end
