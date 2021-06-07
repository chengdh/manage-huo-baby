#coding: utf-8
class AddRptDivideDepartmentFunction < ActiveRecord::Migration
  def up
    group_name= '分成报表'
    subject_title = "分理处运费分成报表"
    subject = "CarryingBill"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'rpt_divide_department_carrying_bills_path(' +
      '"search[refound_bill_date_gte]" =>1.months.ago.beginning_of_month.to_date ' +
      '"search[refound_bill_date_lte]" =>1.months.ago.end_of_month.to_date ' +
      ':rpt_type => "rpt_divide_department")',
      :subject => subject,
      :function => {
        :rpt_divide_department =>{ :title =>"分理处运费分成报表"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
