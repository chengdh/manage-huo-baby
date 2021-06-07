#coding: utf-8
class AddBuildAccountingDocumentFunctionToPostInfo < ActiveRecord::Migration
  def change
    op_name = "生成凭证"
    subject_title = "客户提款结算清单"
    sf = SystemFunction.find_by_subject_title(subject_title)
    if sf
      sfo = sf.system_function_operates.find_by_name(op_name)
      unless sfo
        function_obj = {:subject => "PostInfo",:action => "build_accounting_document"}
        sfo = sf.system_function_operates.create(:name => op_name,:function_obj => function_obj)
        sfo.new_function_obj = sfo.function_obj
        sfo.save!
      end
    end
  end
end
