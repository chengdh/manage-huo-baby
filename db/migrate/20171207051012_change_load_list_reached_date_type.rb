#coding: utf-8
class ChangeLoadListReachedDateType < ActiveRecord::Migration
  def up
    change_column :load_lists,:reached_date,:date
    add_column :load_lists,:reached_datetime,:datetime
  end

  def down
    change_column :load_lists,:reached_date,:datetime
    remove_column :load_lists,:reached_datetime
  end
end
