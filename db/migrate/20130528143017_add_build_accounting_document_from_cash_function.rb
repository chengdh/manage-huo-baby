#coding: utf-8
#添加创建始发地现金凭证功能
class AddBuildAccountingDocumentFromCashFunction < ActiveRecord::Migration
  def change
    op_name = "生成始发货现金付凭证"
    subject_title = "运费/货款统计"
    sf = SystemFunction.find_by_subject_title(subject_title)
    if sf
      sfo = sf.system_function_operates.find_by_name(op_name)
      unless sfo
        function_obj = {:subject => "CarryingBill",:action => "build_accounting_document_from_cash"}
        sfo = sf.system_function_operates.create(:name => op_name,:function_obj => function_obj)
        sfo.new_function_obj = sfo.function_obj
        sfo.save!
 
      end
    end
  end
end
