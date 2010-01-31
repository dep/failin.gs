class CreateInvitations < ActiveRecord::Migration
  def self.up
    create_table :invitations do |t|
      t.belongs_to :inviter
      t.belongs_to :invited
      t.string :email
      t.timestamps
    end
    add_index :invitations, :inviter_id
    add_index :invitations, :invited_id
    add_index :invitations, :email, unique: true

    create_table :promotions do |t|
      t.string :code
      t.integer :limit, default: 100
    end
    add_index :promotions, :code, unique: true

    change_table :users do |t|
      t.belongs_to :promotion
      t.integer :invites_left, default: 5
    end
    add_index :users, :promotion_id
  end

  def self.down
    remove_index :users, :promotion_id
    remove_column :users, :promotion_id
    drop_table :promotions
    drop_table :invitations
  end
end
