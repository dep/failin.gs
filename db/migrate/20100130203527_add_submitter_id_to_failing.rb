class AddSubmitterIdToFailing < ActiveRecord::Migration
  def self.up
    add_column :failings, :submitter_id, :integer
    add_index :failings, :submitter_ip
    add_index :failings, :submitter_id
  end

  def self.down
    remove_index :failings, :submitter_ip
    remove_index :failings, :submitter_id
    remove_column :failings, :submitter_ip
  end
end
