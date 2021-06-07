#coding: utf-8
#添加打印提货单到中转到货清单
class AddPrintThBillToToOrgLoadListFunction < ActiveRecord::Migration
  def change
    sf = SystemFunction.find_by_subject_title('中转到货处理')
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
