#coding: utf-8
class AddTypeToRefound < ActiveRecord::Migration
  def change
    add_column :refounds, :type, :string,:limit => 60
  end
end
