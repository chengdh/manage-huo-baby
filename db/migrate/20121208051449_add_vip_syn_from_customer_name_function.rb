#coding: utf-8
#添加转账客户同步发货人姓名功能
class AddVipSynFromCustomerNameFunction < ActiveRecord::Migration
  def change
    sf = SystemFunction.find_by_subject_title('转账客户管理')
    if sf
      sfo = sf.system_function_operates.find_or_create_by_name('同步发货人姓名')
      sfo.function_obj = {
        :subject => "Vip",
        :action => :syn_from_customer_name
      }
      sfo.new_function_obj = {
        :subject => "Vip",
        :action => :syn_from_customer_name
      }

      sfo.save!
    end
  end
end
