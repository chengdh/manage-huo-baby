#coding: utf-8
#添加始发收货汇总表功能
class AddFunctionRptTurnoverByFromOrg < ActiveRecord::Migration
  def change
    subject_title = "始发地收货汇总表"
    group_name="查询统计"
    sf =  SystemFunction.find_by_subject_title(subject_title)
    subject = "CarryingBill"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'rpt_turnover_by_from_org_carrying_bills_path("search[type_in]" => ["ComputerBill","HandBill","ReturnBill","AutoCalculateComputerBill"],"search[bill_date_gte]" => Date.today.beginning_of_day,"search[bill_date_lte]" => Date.today.end_of_day)',
      :subject => subject,
      :function => {
        :rpt_turnover_by_from_org =>{:title =>"始发地收货汇总表"}
      }
    }
    SystemFunction.create_by_hash(sf_hash) if sf.blank?
  end
end
