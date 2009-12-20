class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.belongs_to :failing, null: false
      t.belongs_to :user

      t.text :text, null: false
      t.string :submitter_ip

      t.timestamps
    end

    add_index :comments, :failing_id
  end

  def self.down
    drop_table :comments
  end
end
