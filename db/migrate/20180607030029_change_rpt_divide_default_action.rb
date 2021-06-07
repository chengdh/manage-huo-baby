#coding: utf-8
class ChangeRptDivideDefaultAction < ActiveRecord::Migration
  def up
    sf1 = SystemFunction.find_by_subject_title("分公司运费分成报表")
    sf1.update_attributes(:default_action => 'rpt_divide_carrying_bills_path(' +
                          '"search[deliver_info_deliver_date_gte]" =>1.months.ago.beginning_of_month.to_date, ' +
                          '"search[deliver_info_deliver_date_lte]" =>1.months.ago.end_of_month.to_date, ' +
                          '"search[to_org_id_in]" => Org.branch_list_ids(nil,true),' +
                          ':rpt_type => "rpt_divide")'
                         )
  end

  def down
  end
end
