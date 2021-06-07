#coding: utf-8
#创建通知公告查看记录
class CreateMessageHistories < ActiveRecord::Migration
  def change
    create_table :message_histories do |t|
      t.references :message,:null => false
      t.references :user,:null => false
      t.integer :view_count,:default => 0

      t.timestamps
    end
    add_index :message_histories, :message_id
    add_index :message_histories, :user_id
  end
end
