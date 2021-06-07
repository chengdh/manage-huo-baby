#coding: utf-8
class ChangeCarryingFeeAndGoodsFeeRptFunction < ActiveRecord::Migration
  def up
    subject_title = "运费/货款统计"
    sf = SystemFunction.find_by_subject_title(subject_title)
    sf.update_attributes(:default_action => 'simple_search_carrying_bills_path(:rpt_type =>:carrying_fee_and_goods_fee_rpt,:sort => "carrying_bills.bill_date desc,carrying_bills.goods_no",:direction => "asc",:show_bill_no_eq => 1,:show_fields => ".carrying_fee_total,.insured_fee,.print_counter,.goods_weight,.goods_volume")') if sf

  end

  def down
  end
end
