#coding: utf-8
#转账-代收货款支付清单生成凭证功能
class AddBuildAccountingDocumentToTransferPaymentList < ActiveRecord::Migration
  def change
    op_name = "生成凭证"
    subject_title = "转账-代收货款支付"
    sf = SystemFunction.find_by_subject_title(subject_title)
    if sf
      sfo = sf.system_function_operates.find_by_name(op_name)
      unless sfo
        function_obj = {:subject => "CarryingBill",:action => "build_accounting_document_transfer_payment_list"}
        sfo = sf.system_function_operates.create(:name => op_name,:function_obj => function_obj)
        sfo.new_function_obj = sfo.function_obj
        sfo.save!
      end
    end
  end
end
