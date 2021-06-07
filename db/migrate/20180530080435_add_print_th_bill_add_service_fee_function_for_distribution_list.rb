#coding: utf-8
class AddPrintThBillAddServiceFeeFunctionForDistributionList < ActiveRecord::Migration
  def up
    group_name = "配送管理"
    sfg = SystemFunctionGroup.find_by_name(group_name)
    subject_title = "分货清单管理"
    sf = SystemFunction.find_by_subject_title_and_system_function_group_id(subject_title,sfg.id)
    if sf
      sfo_name = "打印提货单-加15%服务费"
      sfo = sf.system_function_operates.find_or_create_by_name(sfo_name)
      function_obj = {
        :subject => "DistributionList",
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
