#coding: utf-8
#规章制度、通知公告表
class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :title,:limit => 60,:null => false
      t.text :body
      t.string :type,:limit => 30
      t.boolean :is_secure,:default => false
      t.string :state,:limit => 30 
      t.integer :org_id
      #
      t.string :org_name 
      t.boolean :is_active,:default => true
      t.integer :user_id
      t.datetime :publish_date
      t.integer :publisher_id
      #
      t.string :publisher_name
      t.string :doc_no
      t.boolean :violation_generated,:default => false
      t.boolean :up_state
      t.string :attach_file_name
      t.string :attach_content_type
      t.string :attach_file_size
      t.datetime :attach_updated_at
      #
      t.string :attach_url
      t.timestamps
    end
  end
end
