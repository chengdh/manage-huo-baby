#coding: utf-8
class AddReachedUserId2LoadList < ActiveRecord::Migration
  def up
    add_column :load_lists,:reached_user_id,:integer
    change_column :load_lists,:reached_date,:datetime
  end

  def down
    remove_column :load_lists,:reached_user_id
    change_column :load_lists,:reached_date,:date

  end
end
