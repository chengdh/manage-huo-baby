#coding: utf-8
class CreateBaseDistributionLists < ActiveRecord::Migration
  def change
    add_column :distribution_lists,:type,:string,:limit => 60
  end
end
