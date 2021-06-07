#coding: utf-8
#重建view_bills
class RebuildViewBills < ActiveRecord::Migration
  def up
    sql = <<-EOF
    CREATE OR REPLACE VIEW view_bills AS
      SELECT bill_no,goods_fee,state,from_customer_id,(goods_fee - k_hand_fee - IF(pay_type='KG',carrying_fee,0) - IF(pay_type='KG',insured_fee,0) - IF(pay_type='KG',(from_short_carrying_fee + to_short_carrying_fee),0)) AS act_pay_fee FROM carrying_bills
    EOF
    execute sql
  end

  def down
  end
end
