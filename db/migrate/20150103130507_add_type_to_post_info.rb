#coding: utf-8
class AddTypeToPostInfo < ActiveRecord::Migration
  def change
    add_column :post_infos, :type, :string,:limit => 60
  end
end
