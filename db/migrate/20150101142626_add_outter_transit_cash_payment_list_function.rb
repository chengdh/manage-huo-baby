#coding: utf-8
class AddOutterTransitCashPaymentListFunction < ActiveRecord::Migration
  def up
    group_name = "外部中转业务"
    subject_title = "外部中转-现金代收货款支付清单"
    subject = "OutterTransitCashPaymentList"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :subject => subject,
      :default_action => 'outter_transit_cash_payment_lists_path',
      :function => {
        :read =>{:title => "查看",:conditions => "{:org_id => user.current_ability_org_ids }"} ,
        :create => {:title => "新建"},
        :export => {:title => "导出"},
        :export_sms_txt => {:title => "生成短信通知文件"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
