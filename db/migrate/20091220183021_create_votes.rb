class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.belongs_to :failing, null: false
      t.boolean :agree, null: false
      t.string :voter_ip

      t.timestamps
    end

    add_index :votes, :failing_id
    add_index :votes, [:failing_id, :voter_ip], unique: true
  end

  def self.down
    drop_table :votes
  end
end
