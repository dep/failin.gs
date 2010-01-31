class CreateShares < ActiveRecord::Migration
  def self.up
    create_table :shares do |t|
      t.belongs_to :user
      t.text :emails
      t.timestamps
    end
  end

  def self.down
    drop_table :shares
  end
end
