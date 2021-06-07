# -*- encoding : utf-8 -*-
#coding: utf-8
class Journal < ActiveRecord::Base
  belongs_to :org
  belongs_to :user
  validates_presence_of :org_id
  default_value_for :bill_date do
    Date.today
  end
  #带org的构造函数
  def self.new_with_org(org,bill_date=Date.today)
    journal = Journal.new(:org => org,:bill_date => bill_date)
    #已结算未汇金额
    journal.settled_no_rebate_fee =
      CarryingBill.search(:state_eq => 'settlemented',:to_org_id_or_transit_org_id_eq => org.id,:pay_type_eq =>'TH' ).relation.sum(:carrying_fee)+ CarryingBill.search(:state_eq => 'settlemented',:to_org_id_or_transit_org_id_eq => org.id).relation.sum(:goods_fee)
    #已提货未结算金额
    journal.deliveried_no_settled_fee =
      CarryingBill.search(:state_eq => 'deliveried',:to_org_id_or_transit_org_id_eq => org.id,:pay_type_eq =>'TH' ).relation.sum(:carrying_fee)+ CarryingBill.search(:state_eq => 'deliveried',:to_org_id_or_transit_org_id_eq => org.id).relation.sum(:goods_fee)
    #黑/红/黄/绿/蓝/白
    journal.black_bills = CarryingBill.search(:state_in =>['reached','distributed'] ,:to_org_id_or_transit_org_id_eq => org.id,:bill_date_lte => 21.days.ago.end_of_day).count
    journal.red_bills = CarryingBill.search(:state_in =>['reached','distributed'] ,:to_org_id_or_transit_org_id_eq => org.id,:bill_date_lte => 17.days.ago.end_of_day,:bill_date_gte => 20.days.ago.end_of_day).count
    journal.yellow_bills = CarryingBill.search(:state_in =>['reached','distributed'] ,:to_org_id_or_transit_org_id_eq => org.id,:bill_date_lte => 13.days.ago.end_of_day,:bill_date_gte => 16.days.ago.end_of_day).count
    journal.green_bills = CarryingBill.search(:state_in =>['reached','distributed'] ,:to_org_id_or_transit_org_id_eq => org.id,:bill_date_lte => 9.days.ago.end_of_day,:bill_date_gte => 12.days.ago.end_of_day).count
    journal.blue_bills = CarryingBill.search(:state_in =>['reached','distributed'] ,:to_org_id_or_transit_org_id_eq => org.id,:bill_date_lte => 5.days.ago.end_of_day,:bill_date_gte => 8.days.ago.end_of_day).count
    journal.white_bills = CarryingBill.search(:state_in =>['reached','distributed'] ,:to_org_id_or_transit_org_id_eq => org.id,:bill_date_gte => 4.days.ago.end_of_day).count
    journal
  end
  #计算合计
  def sum_1
    self.settled_no_rebate_fee + self.deliveried_no_settled_fee + self.input_fee_1 + self.input_fee_2 + self.input_fee_3
  end
  def sum_2
    self.cash + self.deposits + self.goods_fee + self.short_fee + self.other_fee
  end
  def sum_3
    self.black_bills + self.red_bills + self.yellow_bills + self.green_bills + self.blue_bills + self.white_bills
  end
  def sum_4
    self.current_debt + self.current_debt_2_3 + self.current_debt_4_5 + self.current_debt_ge_6
  end
  #导出到excel
  def to_csv
    ret = ["","帐目盘点登记表","",""].export_line_csv(true)
    ret = ["分公司",self.org.name,"盘点日期:",self.bill_date].export_line_csv
    ret += ["帐目金额","","库存金额",""].export_line_csv
    ret += ["已结算未汇金额",self.settled_no_rebate_fee,"库存现金",self.cash].export_line_csv
    ret += ["已提未结算金额",self.deliveried_no_settled_fee,"银行存款",deposits ].export_line_csv
    ret +=[self.input_name_1,self.input_fee_1,"返程货款",self.goods_fee].export_line_csv
    ret +=[self.input_name_2,self.input_fee_2,"短途及赔偿",self.short_fee].export_line_csv
    ret +=[self.input_name_3,self.input_fee_3,"其他开支",self.other_fee].export_line_csv
    ret +=["合计",self.sum_1,"合计",self.sum_2].export_line_csv
    ret +=["未提货票据","","客户欠款",""].export_line_csv
    ret +=["黑票",self.black_bills,"当日欠款",self.current_debt].export_line_csv
    ret +=["红票",self.red_bills,"2~3日欠款",self.current_debt_2_3].export_line_csv
    ret +=["黄票",self.yellow_bills,"4~5日欠款",self.current_debt_4_5].export_line_csv
    ret +=["绿票",self.green_bills,"6日以上欠款",self.current_debt_ge_6].export_line_csv
    ret +=["蓝票",self.blue_bills,"",""].export_line_csv
    ret +=["白票",self.white_bills,"",""].export_line_csv
    ret +=["合计",self.sum_3,"合计",self.sum_4].export_line_csv
    ret +=["分公司经理","","会计",self.user.try(:username)].export_line_csv
    ret
  end
end

