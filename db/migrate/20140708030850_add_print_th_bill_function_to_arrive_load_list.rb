#coding: utf-8
#添加提货单打印功能
class AddPrintThBillFunctionToArriveLoadList < ActiveRecord::Migration
  def change
    sf = SystemFunction.find_by_subject_title('到货清单管理')
    if sf
      sfo = sf.system_function_operates.find_or_create_by_name('提货单打印')
      func_obj = {
        :subject => "LoadList",
        :action => :show_print_th_bill
      }
      sfo.function_obj = func_obj
      sfo.new_function_obj = func_obj
      sfo.save!
    end
  end
end
