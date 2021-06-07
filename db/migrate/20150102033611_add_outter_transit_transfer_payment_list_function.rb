#coding: utf-8
class AddOutterTransitTransferPaymentListFunction < ActiveRecord::Migration
  def up
    group_name = "外部中转业务"
    subject_title = "外部中转-货款转账支付"
    subject = "OutterTransitTransferPaymentList"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'outter_transit_transfer_payment_lists_path',
      :subject => subject,
      :function => {
        :read =>{:title => "查看",:conditions =>"{:org_id => user.current_ability_org_ids }"} ,
        :create => {:title => "新建"},
        :transfer => {:title => "转账确认"},
        :export => {:title => "导出"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
    op_name = "生成凭证"
    subject_title = "外部中转-货款转账支付"
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

  def down
  end
end
