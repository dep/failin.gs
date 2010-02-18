class AddCustomSecurityQuestionToFailing < ActiveRecord::Migration
  def self.up
    add_column :users, :question, :string, default: "What's my last name?"
    add_column :users, :name, :string
    User.update_all "name = surname"
    rename_column :users, :surname, :answer
  end

  def self.down
    remove_column :users, :question
    remove_column :users, :name
    rename_column :users, :answer, :question
  end
end
