#coding: utf-8
class AddRptTurnoverByOrgLoad < ActiveRecord::Migration
  def up
    group_name = "查询统计"

    subject_title = "日营业额统计-装卸组"
    subject = "CarryingBill"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'rpt_turnover_by_org_load_carrying_bills_path("search[bill_date_gte]" => Date.today.beginning_of_day,"search[bill_date_lte]" => Date.today.end_of_day)',
      :subject => subject,
      :function => {
        :rpt_turnover_by_org_load =>{:title =>"日营业额统计"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
