#coding: utf-8
class ChangeRptNoPayDefaultActionAddShortFe < ActiveRecord::Migration
  def up
    sf = SystemFunction.find_by_subject_title("提货未提款统计")
    sf.update_attributes(:default_action => 'simple_search_carrying_bills_path(:rpt_type => "rpt_no_pay",'+
                         '"search[state_eq]" => "payment_listed","search[goods_fee_gt]" => 0,'+
                         ':sort => "carrying_bills.bill_date desc,carrying_bills.goods_no",'+
                         ':direction => "asc",'+
                         ':show_fields => ".insured_fee,.from_short_carrying_fee,.to_short_carrying_fee,.carrying_fee,.carrying_fee_total",' +
                         ':from_org_select => "current_ability_orgs_for_select",'+
                         ':to_org_select => "exclude_current_ability_orgs_for_select" )') if sf
  end

  def down
  end
end
