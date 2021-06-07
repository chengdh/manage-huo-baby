#coding: utf-8
#修改内部中转返款单
class ChangeFromOrgInnerTransitRefundFunction < ActiveRecord::Migration
  def up
    group_name = "内部中转业务"
    subject_title = "中转返款单"
    sf = SystemFunction.find_by_subject_title(subject_title)
    subject = "InnerTransitRefund"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'from_org_inner_transit_refunds_path',
      :subject => subject,
      :function => {
        :read_from_org =>{:title => "查看"} ,
        :create_from_org =>{:title => "新建"} ,
        :export_from_org => {:title => "导出"}
      }

    }
    sf.update_by_hash(sf_hash) if sf.present?
  end

  def down
  end
end
