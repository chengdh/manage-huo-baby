#coding: utf-8
#添加外部中转返款单功能
class AddOutterTransitRefundFunciton < ActiveRecord::Migration
  def up
    group_name = "外部中转业务"
    subject_title = "外部中转-返款清单"
    subject = "OutterTransitRefund"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'can?(:create,OutterTransitRefund) ? new_outter_transit_refund_path : outter_transit_refunds_path',
      :subject => subject,
      :function => {
        :read =>{:title => "查看",:conditions =>"{:from_org_id => user.current_ability_org_ids }"} ,
        :create => {:title => "新建"},
        :export => {:title => "导出"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
