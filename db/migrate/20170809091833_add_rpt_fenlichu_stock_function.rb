#coding: utf-8
#分理处库存统计
class AddRptFenlichuStockFunction < ActiveRecord::Migration
  def up
    group_name = "分拣及装车"
    subject_title = "分理处库存统计"

    subject = "CarryingBill"

    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'simple_search_carrying_bills_path(:rpt_type => "rpt_fenlichu_stock",'+
                         '"search[state_eq]" => "billed",'+
                         '"search[type_in]" => %w(ComputerBill HandBill ReturnBill AutoCalculateComputerBill),' +
                         ':sort => "carrying_bills.bill_date desc,carrying_bills.goods_no",'+
                         ':direction => "asc",'+
                         ':show_fields => ".from_customer_mobile,.insured_fee,.from_short_carrying_fee,.to_short_carrying_fee,.carrying_fee,.carrying_fee_total",' +
                         ':from_org_select => "current_ability_orgs_for_select",'+
                         ':to_org_select => "exclude_current_ability_orgs_for_select" )',
      :subject => subject,
      :function => {
        :rpt_fenlichu_stock =>{ :title => subject_title}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
