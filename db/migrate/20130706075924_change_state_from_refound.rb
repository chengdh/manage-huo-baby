#coding: utf-8
#修改state的大小为60
class ChangeStateFromRefound < ActiveRecord::Migration
  def up
    change_column :refounds,:state,:string,:limit => 60
  end

  def down
  end
end
