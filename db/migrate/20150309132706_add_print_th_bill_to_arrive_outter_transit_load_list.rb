#coding: utf-8
#给外部中转到货清单添加打印提货单功能
class AddPrintThBillToArriveOutterTransitLoadList < ActiveRecord::Migration
  def change
    subject_title = "外部中转-到货清单"
    sf = SystemFunction.find_by_subject_title(subject_title)
    if sf
      sfo_name = "打印提货单"
      sfo = sf.system_function_operates.find_or_create_by_name(sfo_name)
      function_obj = {
        :subject => "OutterTransitLoadList",
        :action => :show_print_th_bill
      }
      sfo.function_obj = function_obj
      sfo.new_function_obj = function_obj
      sfo.save!
    end

  end
end
