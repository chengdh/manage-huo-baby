# -*- encoding : utf-8 -*-
class ChangeSumGoodsFeeReportFunction < ActiveRecord::Migration
  def up
    subject_title = "运费/货款统计"
    sf = SystemFunction.find_by_subject_title(subject_title)
    sf.update_attributes(:default_action => 'simple_search_carrying_bills_path(:sort => "carrying_bills.bill_date desc,carrying_bills.goods_no",:direction => "asc",:show_bill_no_eq => 1,:show_fields => ".insured_fee,.carrying_fee_total")') if sf
  end

  def down
  end
end
