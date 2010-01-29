class AddAboutToFailing < ActiveRecord::Migration
  def self.up
    add_column :failings, :about, :text
  end

  def self.down
    remove_column :failings, :about
  end
end
