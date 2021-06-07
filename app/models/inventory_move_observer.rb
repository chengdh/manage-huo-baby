#coding: utf-8
#监控运单库存变动
class InventoryMoveObserver < ActiveRecord::Observer
  observe :branch_inventory,:yard_inventory
  def after_save(inventory)
    #发货
    if inventory.state.eql?('shipped')
      inventory.inventory_moves.each do |move|
        io = InventoryOut.find_or_create_by_carrying_bill_id_and_org_id(move.carrying_bill_id,move.from_org_id)
        io.update_attributes(:sum_qty => io.sum_qty + move.qty)
      end
    end
    if inventory.state.eql?('reached')
      inventory.inventory_moves.each do |move|
        ion = InventoryIn.find_or_create_by_carrying_bill_id_and_org_id(move.carrying_bill_id,move.to_org_id)
        ion.update_attributes(:sum_qty => ion.sum_qty + move.qty)
      end
    end
  end
end
