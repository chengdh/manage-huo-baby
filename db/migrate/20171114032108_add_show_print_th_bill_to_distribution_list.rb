#coding: utf-8
class AddShowPrintThBillToDistributionList < ActiveRecord::Migration
  def change
    sf = SystemFunction.search(:subject_title_eq => '分货清单管理',:system_function_group_name_eq => "配送管理").first
    if sf
      sfo = sf.system_function_operates.find_or_create_by_name('提货单打印')
      func_obj = {
        :subject => "DistributionList",
        :action => :show_print_th_bill
      }
      sfo.function_obj = func_obj
      sfo.new_function_obj = func_obj
      sfo.save!
    end
  end
end
