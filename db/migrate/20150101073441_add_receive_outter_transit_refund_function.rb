#coding: utf-8
#添加外部中转-收款清单功能
class AddReceiveOutterTransitRefundFunction < ActiveRecord::Migration
  def up
    group_name = "外部中转业务"
    subject_title = "外部中转-收款清单"
    subject = "OutterTransitRefund"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'can?(:read_arrive,OutterTransitRefund)? receive_outter_transit_refunds_path("search[state_eq]" => "refunded") : receive_outter_transit_refunds_path("search[state_eq]" => "refunded_confirmed")',
      :subject => subject,
      :function => {
        :read_arrive =>{:title => "查看",:conditions =>"{:state =>['refunded_confirmed','refunded'] ,:to_org_id => user.current_ability_org_ids}"} ,
        :read_confirmed =>{:title => "查看已确认收款单"},
        :refound_confirm => {:title => "收款确认",:conditions =>"{:state => 'refunded',:to_org_id => user.current_ability_org_ids}"},
        :export => {:title => "导出"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)

    #生成凭证功能
    op_name = "生成凭证"
    subject_title = "外部中转-收款清单"
    sf = SystemFunction.find_by_subject_title(subject_title)
    if sf
      sfo = sf.system_function_operates.find_by_name(op_name)
      unless sfo
        function_obj = {:subject => "CarryingBill",:action => "build_accounting_document_from_th"}
        sfo = sf.system_function_operates.create(:name => op_name,:function_obj => function_obj)
        sfo.new_function_obj = sfo.function_obj
        sfo.save!
      end
    end
  end

  def down
  end
end
