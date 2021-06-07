#coding: utf-8
#在库票据录入
class AddBatchInputFunctionToInStockBill < ActiveRecord::Migration
  def change
    sf = SystemFunction.find_by_subject_title('在库清单录入')
    if sf
      sfo = sf.system_function_operates.find_or_create_by_name('批量录入')
      sfo.function_obj = {
        :subject => "InStockBill",
        :action => :batch_input
      }
      sfo.new_function_obj = {
        :subject => "InStockBill",
        :action => :batch_input
      }
      sfo.save!
    end
  end
end
