#coding: utf-8
class AddSummaryOrgOutterTransitTransferPaymentListFunction < ActiveRecord::Migration
  def up
    group_name = "外部中转业务"
    subject_title = "外部中转-总部货款转账支付清单"
    subject = "SummaryOrgOutterTransitTransferPaymentList"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'summary_org_outter_transit_transfer_payment_lists_path',
      :subject => subject,
      :function => {
        :read =>{:title => "查看",:conditions =>"{:org_id => user.current_ability_org_ids }"} ,
        :create => {:title => "新建"},
        :transfer => {:title => "转账确认"},
        :export => {:title => "导出"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
