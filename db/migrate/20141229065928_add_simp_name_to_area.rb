#coding: utf-8
class AddSimpNameToArea < ActiveRecord::Migration
  def change
    add_column :areas, :simp_name, :string,:limit => 20
  end
end
