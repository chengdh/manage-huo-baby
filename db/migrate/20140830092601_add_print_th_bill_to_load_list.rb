#coding: utf-8
class AddPrintThBillToLoadList < ActiveRecord::Migration
  def change
    subject_title = "货物运输清单管理"
    sf = SystemFunction.find_by_subject_title(subject_title)
    if sf
      sfo_name = "打印提货单"
      sfo = sf.system_function_operates.find_or_create_by_name(sfo_name)
      function_obj = {
        :subject => "LoadList",
        :action => :print_th_bill
      }
      sfo.function_obj = function_obj
      sfo.new_function_obj = function_obj
      sfo.save!
    end
  end
end
