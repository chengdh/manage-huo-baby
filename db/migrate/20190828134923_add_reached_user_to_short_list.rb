#coding: utf-8
#向短驳单添加到达信息
class AddReachedUserToShortList < ActiveRecord::Migration
  def change
    add_column :short_lists,:reached_user_id,:integer
    add_column :short_lists,:reached_datetime,:datetime
  end
end
