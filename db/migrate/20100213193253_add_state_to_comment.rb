class AddStateToComment < ActiveRecord::Migration
  def self.up
    add_column :comments, :state, :string
    add_index :comments, [:state, :failing_id]
  end

  def self.down
    remove_index :comments, [:state, :failing_id]
    remove_column :comments, :state
  end
end
