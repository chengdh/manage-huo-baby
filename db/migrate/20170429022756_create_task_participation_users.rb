#coding: utf-8
#任务-参与者
class CreateTaskParticipationUsers < ActiveRecord::Migration
  def change
    create_table :task_participation_users do |t|
      t.references :task,:null => false
      t.references :user,:null => false

      t.timestamps
    end
  end
end
