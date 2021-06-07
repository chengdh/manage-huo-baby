#coding: utf-8
class AddDestroyFunctionToCashPayInfo < ActiveRecord::Migration
  def self.up
    #添加现金付款单的删除功能
    sf = SystemFunction.find_by_subject_title('客户提款-现金')
    if sf
      sfo = sf.system_function_operates.find_or_create_by_name('删除')
      sfo.function_obj = {
        :subject => "CashPayInfo",
        :action => :destroy
      }
      sfo.save!
    end

  end

  def self.down
    sf = SystemFunction.find_by_subject_title('客户提款-现金')
    if sf
      sfo = sf.system_function_operates.find_by_name('删除')
      sfo.destroy if sfo
    end
  end
end
