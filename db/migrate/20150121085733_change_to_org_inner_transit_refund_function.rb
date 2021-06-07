#coding: utf-8
class ChangeToOrgInnerTransitRefundFunction < ActiveRecord::Migration
  def up
    group_name = "内部中转业务"
    subject_title = "中转收款处理"
    sf = SystemFunction.find_by_subject_title(subject_title)
    subject = "InnerTransitRefund"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'to_org_inner_transit_refunds_path',
      :subject => subject,
      :function => {
        :read_to_org => {:title => "查看"} ,
        :confirm_to_org => {:title => "收款确认",:conditions =>"{:state => 'transit_refunded_confirmed',:to_org_id => user.current_ability_org_ids}"},
        :export_to_org => {:title => "导出"},
      }
    }
    sf.update_by_hash(sf_hash) if sf.present?
  end

  def down
  end
end
