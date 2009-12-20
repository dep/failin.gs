class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      # = Authlogic
      t.string :login, :email, :crypted_password, :password_salt,
        :persistence_token, :single_access_token, :perishable_token,
        null: false

      t.integer :login_count, :failed_login_count,
        null: false, default: 0

      t.timestamp :last_request_at, :current_login_at, :last_login_at
      t.string :current_login_ip, :last_login_ip

      # = ActiveRecord::StateMachine
      t.string :state

      # = Local
      t.string :surname, :location
      t.text :about
      t.boolean :subscribe

      t.timestamps
    end

    add_index :users, :login, unique: true
    add_index :users, :email, unique: true
    add_index :users, :persistence_token, unique: true
    add_index :users, :single_access_token, unique: true
    add_index :users, :perishable_token, unique: true
  end

  def self.down
    drop_table :users
  end
end
