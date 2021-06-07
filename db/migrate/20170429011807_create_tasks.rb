#coding: utf-8
class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title,:limit => 60,:null => false
      t.text :content,:null => false
      t.date :plan_complete_date,:null => false
      t.string :state,:limit => 30,:null => false,:default => "draft"
      t.integer :creator_id
      t.string :acceptor_id
      t.datetime :accept_date
      t.integer :submitor_id
      t.datetime :submit_date
      t.integer :auditor_id
      t.datetime :audit_date
      t.text :note

      t.timestamps
    end
    # change_column :tasks, :content, :text, :limit => 4294967295
  end
end
