#coding: utf-8
#添加送货报表
class AddDeliverRptFunction < ActiveRecord::Migration
  def up
    subject_title = "送货报表"
    group_name="查询统计"
    sf =  SystemFunction.find_by_subject_title(subject_title)
    subject = "CarryingBill"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action =>'simple_search_carrying_bills_path(:rpt_type => "rpt_delivery",:show_fields =>".stranded_days,.insured_fee,.from_short_carrying_fee,.to_short_carrying_fee,.th_amount,.deliver_region",:hide_fields => "","search[state_in]" => ["reached","distributed"],"search[transit_org_id_is_null]" => 1,"search[to_org_id_eq]" => current_user.default_org.id,:sort => "carrying_bills.bill_date asc,carrying_bills.goods_no",:direction => "asc",:from_org_select => "exclude_current_ability_orgs_for_select",:to_org_select => "current_ability_orgs_for_select"  )',
      :subject => subject,
      :function => {
        :rpt_delivery =>{:title =>"送货报表"}
      }
    }
    SystemFunction.create_by_hash(sf_hash) if sf.blank?
  end

  def down
  end
end
