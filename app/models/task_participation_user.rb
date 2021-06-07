#coding: utf-8
#任务-参与人
class TaskParticipationUser < ActiveRecord::Base
  belongs_to :task
  belongs_to :user
end
