#coding: utf-8
class AddPrintThBillAddServiceFeeFunctionForArriveLoadList < ActiveRecord::Migration
  def up
    subject_title = "到货清单管理"
    sf = SystemFunction.find_by_subject_title(subject_title)
    if sf
      sfo_name = "打印提货单-加15%服务费"
      sfo = sf.system_function_operates.find_or_create_by_name(sfo_name)
      function_obj = {
        :subject => "LoadList",
        :action => :print_th_bill_add_service_fee
      }
      sfo.function_obj = function_obj
      sfo.new_function_obj = function_obj
      sfo.save!
    end
  end

  def down
  end
end
