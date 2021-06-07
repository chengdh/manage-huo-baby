#coding: utf-8
#任务责任人
class TaskUser < ActiveRecord::Base
  belongs_to :task
  belongs_to :user
end
