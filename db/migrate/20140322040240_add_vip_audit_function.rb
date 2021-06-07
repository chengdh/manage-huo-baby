#coding: utf-8
#给转账客户管理添加审核功能
class AddVipAuditFunction < ActiveRecord::Migration
  def up
    #添加转账客户添加审核功能
    sf = SystemFunction.find_by_subject_title('转账客户管理')
    func_obj =  {
      :subject => "Vip",
      :action => :audit,
      :conditions =>"{:vip_state => 'draft'}"
    }

    if sf
      ops = sf.system_function_operates.find_or_create_by_name("审核")
      ops.update_attributes(:new_function_obj => func_obj,:function_obj => func_obj)
    end
  end

  def down
    sf = SystemFunction.find_by_subject_title('转账客户管理')
    if sf
      ops = sf.system_function_operates.find_by_name("审核")
      ops.destroy if ops
    end
  end
end
