class AddUniqueConstraintToFailing < ActiveRecord::Migration
  def self.up
    Failing.connection.insert_sql <<SQL
ALTER IGNORE TABLE `failings` ADD UNIQUE INDEX `index_comments_on_user_id_and_about` (`user_id`, `about`(145))
SQL
  end

  def self.down
    remove_index :failings, [:user_id, :text]
  end
end
