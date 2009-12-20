class CreateFailings < ActiveRecord::Migration
  def self.up
    create_table :failings do |t|
      # = ActiveRecord::StateMachine
      t.string :state, null: false

      # = Local
      t.belongs_to :user, null: false
      t.string :submitter_ip

      t.timestamps
    end

    add_index :failings, :user_id
    add_index :failings, :state
    add_index :failings, [:user_id, :state]
  end

  def self.down
    drop_table :failings
  end
end
