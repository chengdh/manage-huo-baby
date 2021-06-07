#coding: utf-8
#生成返程货现付凭证
class AddBuildAccountingDocumentToCashFunction < ActiveRecord::Migration
  def change
    op_name = "生成返程货现金付凭证"
    subject_title = "返程票据统计"
    sf = SystemFunction.find_by_subject_title(subject_title)
    if sf
      sfo = sf.system_function_operates.find_by_name(op_name)
      unless sfo
        function_obj = {:subject => "CarryingBill",:action => "build_accounting_document_to_cash"}
        sfo = sf.system_function_operates.create(:name => op_name,:function_obj => function_obj)
        sfo.new_function_obj = sfo.function_obj
        sfo.save!
      end
    end
  end
end
