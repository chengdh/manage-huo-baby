#coding: utf-8
#给carrying_bills的distribution_list_id添加索引
class AddDistributionListIdIndexToCarryingBills < ActiveRecord::Migration
  def change
    Lhm.change_table :carrying_bills,:atomic_switch => true  do |m|
      m.add_index :distribution_list_id
      m.add_index :created_at
      m.add_index :updated_at
    end
  end
end
