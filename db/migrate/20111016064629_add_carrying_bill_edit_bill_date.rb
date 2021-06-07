# -*- encoding : utf-8 -*-
#coding: utf-8
class AddCarryingBillEditBillDate < ActiveRecord::Migration
  def self.up
    #添加运单录入修改运单日期功能
    sf = SystemFunction.find_by_subject_title('运单修改')
    func_obj =  {
      :subject => "CarryingBill",
      :action => :edit_bill_date
      }

    if sf
      ops = sf.system_function_operates.find_or_create_by_name("修改运单日期")
      ops.update_attributes(:function_obj => func_obj)
    end

  end

  def self.down
  end
end

