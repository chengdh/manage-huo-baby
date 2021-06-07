# -*- encoding : utf-8 -*-
class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.database_authenticatable :null => false
      #t.recoverable
      t.rememberable
      t.trackable
      t.boolean :is_active,:default => true
      t.boolean :is_admin,:default => false
      t.string :username,:limit => 20,:null => false

      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable


      t.timestamps
    end

    add_index :users, :username,                :unique => true
    #add_index :users, :reset_password_token, :unique => true
    # add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
  end

  def self.down
    drop_table :users
  end
end
