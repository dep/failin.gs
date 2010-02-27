class CreateBookmarks < ActiveRecord::Migration
  def self.up
    create_table :bookmarks, id: false do |t|
      t.belongs_to :bookmarker, :bookmarked

      t.timestamps
    end

    add_index :bookmarks, :bookmarker_id
    add_index :bookmarks, :bookmarked_id
    add_index :bookmarks, [:bookmarker_id, :bookmarked_id], unique: true
  end

  def self.down
    drop_table :bookmarks
  end
end
