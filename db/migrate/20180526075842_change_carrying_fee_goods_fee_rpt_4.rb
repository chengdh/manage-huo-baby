#coding: utf-8
class ChangeCarryingFeeGoodsFeeRpt4 < ActiveRecord::Migration
  def up
    subject_title = "运费/货款统计"

    sf = SystemFunction.find_by_subject_title(subject_title)
    if sf.present?
      default_action = 'simple_search_carrying_bills_path(:rpt_type =>:carrying_fee_and_goods_fee_rpt,'+
        ':sort => "carrying_bills.bill_date desc,carrying_bills.goods_no",'+
        '"search[bill_date_gte]" => Date.today,' +
        '"search[bill_date_lte]" => Date.today,' +
        ':direction => "asc",'+
        ':show_bill_no_eq => 1,'+
        ':show_fields => ".carrying_fee_total,.insured_fee,.print_counter,.deliver_date,.pay_date,.th_amount,.goods_weight,.goods_volume")'
      sf.update_attributes(:default_action => default_action)
    end
  end

  def down
  end
end
