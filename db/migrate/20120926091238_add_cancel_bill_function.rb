#coding: utf-8
#添加运单注销功能
class AddCancelBillFunction < ActiveRecord::Migration
  def up
    sf = SystemFunction.find_by_subject_title('运单修改')
    #添加运单注销功能
    func_obj =  {
      :subject => "CarryingBill",
      :action => :cancel,
      :conditions => "{:state => ['reached','distributed'] }"}
    if sf
      ops = sf.system_function_operates.find_or_create_by_name("注销")
      ops.update_attributes(:new_function_obj => func_obj,:function_obj => func_obj)
    end
  end

  def down
  end
end
