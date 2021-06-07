#coding: utf-8
#添加客户提款时不限制转账户名与运单发货人名称一致
class AddNoLimitAccountNameForCashPayInfo < ActiveRecord::Migration
  def up
    sf = SystemFunction.find_by_subject_title('客户提款-现金')
    if sf
      sfo = sf.system_function_operates.find_or_create_by_name('不限制转账户名')
      sfo.function_obj = {
        :subject => "CashPayInfo",
        :action => :unlimited_account_name
      }
      sfo.new_function_obj = {
        :subject => "CashPayInfo",
        :action => :unlimited_account_name
      }
      sfo.save!
    end
  end

  def down
    sf = SystemFunction.find_by_subject_title('客户提款-现金')
    if sf
      sfo = sf.system_function_operates.find_by_name('不限制转账户名')
      sfo.destroy if sfo
    end
  end
end
