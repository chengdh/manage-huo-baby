#coding: utf-8
class AddFinishContentToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :finsh_content, :text
  end
end
