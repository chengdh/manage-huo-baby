#coding: utf-8
#给scan_line 添加货物异常类别及货物异常描述
class AddGoodsStatus2ScanLine < ActiveRecord::Migration
  def up
    add_column :scan_lines,:goods_status_type,:integer,:default => 0
    add_column :scan_lines,:goods_status_note,:string,:limit => 60
  end

  def down
    remove_column :scan_lines,:goods_status_type
    remove_column :scan_lines,:goods_status_note
  end
end
