#coding: utf-8
#任务进度
class TaskProgress < ActiveRecord::Base
  belongs_to :task
  belongs_to :user
end
