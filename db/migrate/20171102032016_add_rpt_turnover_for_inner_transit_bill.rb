#coding: utf-8
class AddRptTurnoverForInnerTransitBill < ActiveRecord::Migration
  def up
    subject_title = "日营业额统计-内部中转"
    group_name="内部中转业务"
    sf =  SystemFunction.find_by_subject_title(subject_title)
    subject = "CarryingBill"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'rpt_turnover_for_inner_transit_bill_carrying_bills_path("search[bill_date_gte]" => Date.today.beginning_of_day,"search[bill_date_lte]" => Date.today.end_of_day)',
      :subject => subject,
      :function => {
        :rpt_turnover_for_inner_transit_bill =>{:title =>"日营业额统计-内部中转"}
      }
    }
    SystemFunction.create_by_hash(sf_hash) if sf.blank?
  end

  def down
  end
end
