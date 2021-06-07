#coding: utf-8
class AddRptTurnoverForRefund < ActiveRecord::Migration
  def up
    subject_title = "返程票-日营业额统计"
    group_name="查询统计"
    sf =  SystemFunction.find_by_subject_title(subject_title)
    subject = "CarryingBill"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'rpt_turnover_for_refund_carrying_bills_path("search[type_in]" => ["ComputerBill","HandBill","ReturnBill","AutoCalculateComputerBill"],"search[bill_date_gte]" => Date.today.beginning_of_day,"search[bill_date_lte]" => Date.today.end_of_day)',
      :subject => subject,
      :function => {
        :rpt_turnover_for_refund =>{:title =>"返程票-日营业额统计"}
      }
    }
    SystemFunction.create_by_hash(sf_hash) if sf.blank?
  end

  def down
  end
end
