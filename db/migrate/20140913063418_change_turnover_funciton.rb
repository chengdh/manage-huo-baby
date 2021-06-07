#coding: utf-8
#修改日营业额统计功能
class ChangeTurnoverFunciton < ActiveRecord::Migration
  def up
    subject_title = "日营业额统计"
    sf = SystemFunction.find_by_subject_title(subject_title)
    sf.update_attributes(:default_action => 'rpt_turnover_carrying_bills_path("search[type_in]" => ["ComputerBill","AutoCalculateComputerBill","HandBill","ReturnBill"],"search[bill_date_gte]" => Date.today.beginning_of_day,"search[bill_date_lte]" => Date.today.end_of_day)') if sf
    subject_title = "日营业额统计图"
    sf = SystemFunction.find_by_subject_title(subject_title)
    sf.update_attributes(:default_action => 'turnover_chart_carrying_bills_path("search[type_in]" => ["ComputerBill","AutoCalculateComputerBill","HandBill","ReturnBill"],"search[bill_date_gte]" => Date.today.beginning_of_day,"search[bill_date_lte]" => Date.today.end_of_day,"search[from_org_id_eq]" => current_user.default_org_id)') if sf
  end

  def down
  end
end
