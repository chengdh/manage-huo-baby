#coding: utf-8
class AddTransferFunctionToPostInfo < ActiveRecord::Migration
  def change
    sf = SystemFunction.find_by_subject_title("客户提款结算清单")
    if sf.present?
      sfo = sf.system_function_operates.find_or_create_by_name('转账确认')
      function_obj = {
        :subject => "PostInfo",
        :action => :transfer
      }
      if sfo.present?
        sfo.function_obj = function_obj
        sfo.new_function_obj = function_obj
        sfo.save!
      end
    end
  end
end
