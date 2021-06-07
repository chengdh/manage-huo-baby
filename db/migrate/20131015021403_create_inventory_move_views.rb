#coding: utf-8
#创建inventory_move相关view
class CreateInventoryMoveViews < ActiveRecord::Migration
  def up
    sql = <<-EOF
    CREATE OR REPLACE VIEW inventory_move_ins AS
      SELECT carrying_bill_id,to_org_id,SUM(qty) AS qty 
      FROM inventory_moves
      WHERE state='reached'
      GROUP BY carrying_bill_id,to_org_id
    EOF
    execute sql
    sql2 = <<-EOF
    CREATE OR REPLACE VIEW inventory_move_outs AS
      SELECT carrying_bill_id,from_org_id,SUM(qty) AS qty 
      FROM inventory_moves
      WHERE state in ('billed','shipped','reached')
      GROUP BY carrying_bill_id,from_org_id
    EOF
    execute sql2

  end

  def down
  end
end
