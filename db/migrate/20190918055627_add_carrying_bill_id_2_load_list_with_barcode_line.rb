#coding: utf-8
#扫码明细添加关联carrying_bill_id
class AddCarryingBillId2LoadListWithBarcodeLine < ActiveRecord::Migration
  def up
    add_column :load_list_with_barcode_lines,:carrying_bill_id,:integer
  end

  def down
    remove_column :load_list_with_barcode_lines,:carrying_bill_id
  end
end
