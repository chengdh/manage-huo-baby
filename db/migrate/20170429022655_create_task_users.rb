#coding: utf-8
class CreateTaskUsers < ActiveRecord::Migration
  def change
    create_table :task_users do |t|
      t.references :task,:null => false
      t.references :user,:null => false

      t.timestamps
    end
  end
end
