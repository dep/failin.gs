class CreateAbuses < ActiveRecord::Migration
  def self.up
    create_table :abuses do |t|
      t.belongs_to :content, polymorphic: true
      t.belongs_to :user
      t.string :reporter_ip
      t.timestamps
    end

    add_index :abuses, [:content_id, :content_type]
  end

  def self.down
    drop_table :abuses
  end
end
