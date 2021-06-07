#coding: utf-8
#添加运单批量删除功能
class AddBatchDestroyFunctionForCarryingBill < ActiveRecord::Migration
  def up
    sf = SystemFunction.find_by_subject_title('运单修改')
    #添加运单注销功能
    func_obj =  {
      :subject => "CarryingBill",
      :action => :batch_destroy
      }
    if sf
      ops = sf.system_function_operates.find_or_create_by_name("批量删除草稿运单")
      ops.update_attributes(:new_function_obj => func_obj,:function_obj => func_obj)
    end
  end

  def down
    up
  end
end
