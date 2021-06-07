#coding: utf-8
class ChangeBillLinesTable < ActiveRecord::Migration
  def up
    change_column :bill_lines,:goods_cat_id,:integer,:null => true
    add_column :bill_lines,:fee_unit_id,:integer
  end
  def down
  end
end
