#coding: utf-8
class AddTypeToSettlement < ActiveRecord::Migration
  def change
    add_column :settlements, :type, :string,:limit => 60
  end
end
