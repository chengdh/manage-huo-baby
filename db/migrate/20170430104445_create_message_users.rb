#coding: utf-8
class CreateMessageUsers < ActiveRecord::Migration
  def change
    create_table :message_users do |t|
      t.references :message,:null => false
      t.references :user,:null => false
      t.boolean :viewed,:default => false

      t.timestamps
    end
    add_index :message_users, :message_id
    add_index :message_users, :user_id
  end
end
