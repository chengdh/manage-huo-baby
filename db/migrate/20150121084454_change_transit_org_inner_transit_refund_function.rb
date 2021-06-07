#coding: utf-8
class ChangeTransitOrgInnerTransitRefundFunction < ActiveRecord::Migration
  def up
    group_name = "内部中转业务"
    subject_title = "中转返款单(总部处理)"
    sf = SystemFunction.find_by_subject_title(subject_title)
    subject = "InnerTransitRefund"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'transit_org_inner_transit_refunds_path',
      :subject => subject,
      :function => {
        #中转地查看
        :read_transit_org => {:title => "查看"} ,
        :confirm_transit_org => {:title => "中转确认",:conditions =>"{:state => 'refunded',:transit_org_id => user.current_ability_org_ids}"},
        :export_transit_org => {:title => "导出"},
      }
    }
    sf.update_by_hash(sf_hash) if sf.present?
  end

  def down
  end
end
