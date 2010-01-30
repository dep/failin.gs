class AddScoreToFailing < ActiveRecord::Migration
  def self.up
    add_column :failings, :score, :integer, default: 0
    add_index :failings, [:user_id, :state, :score]
  end

  def self.down
    remove_index :failings, [:user_id, :state, :score]
    remove_column :failings, :score
  end
end
