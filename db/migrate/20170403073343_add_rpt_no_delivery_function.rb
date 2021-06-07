#coding: utf-8
class AddRptNoDeliveryFunction < ActiveRecord::Migration
  def up
    subject_title = "未提货金额汇总表"
    group_name="查询统计"
    sf =  SystemFunction.find_by_subject_title(subject_title)
    subject = "CarryingBill"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'rpt_no_delivery_carrying_bills_path()',
      :subject => subject,
      :function => {
        :rpt_no_delivery =>{:title =>"未提货金额汇总表"}
      }
    }
    SystemFunction.create_by_hash(sf_hash) if sf.blank?
 
  end

  def down
  end
end
