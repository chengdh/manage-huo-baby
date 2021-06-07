#coding: utf-8
#记录提货单打印次数
class AddPrintCountToDeliverInfo < ActiveRecord::Migration
  def change
    Lhm.change_table :carrying_bills,:atomic_switch => true  do |m|
      m.add_column :th_bill_print_count,"int(11) DEFAULT 0"
    end
  end
end
