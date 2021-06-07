#coding: utf-8
#任务进度
class CreateTaskProgresses < ActiveRecord::Migration
  def change
    create_table :task_progresses do |t|
      t.references :task,:null => false
      t.references :user,:null => false
      t.text :content,:null => false

      t.timestamps
    end
    add_index :task_progresses, :user_id
    add_index :task_progresses, :task_id
  end
end
