class AddUniqueIndexToComments < ActiveRecord::Migration
  def self.up
    Comment.connection.insert_sql <<SQL
ALTER IGNORE TABLE `comments` ADD UNIQUE INDEX `index_comments_on_failing_id_and_text` (`failing_id`, `text`(200))
SQL
  end

  def self.down
    remove_index :comments, [:failing_id, :text]
  end
end
