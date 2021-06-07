#coding: utf-8
#添加批量导出银行转账文本功能
class AddBatchExportFunctionsToPostInfo < ActiveRecord::Migration
  def change
    subject_title = "客户提款结算清单"
    subject = "PostInfo"

    sf = SystemFunction.find_by_subject_title(subject_title)
    if sf
      #导出为浦发转账
      op_name = "批量导出转账txt"
      sfo = sf.system_function_operates.find_by_name(op_name)
      unless sfo
        function_obj = {:subject => subject,:action => "batch_export_with_bank"}
        sfo = sf.system_function_operates.create(:name => op_name,:function_obj => function_obj)
        sfo.new_function_obj = sfo.function_obj
        sfo.save!
      end
    end
  end
end
