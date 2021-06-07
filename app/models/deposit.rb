#coding: utf-8
#保证金录入
class Deposit < ActiveRecord::Base
  belongs_to :org
  belongs_to :user
  validates :org_id,:user_id, presence: true
  validates :deposit_fee_1,:deposit_fee_2,:deposit_fee_3,numericality: true
  def sum_deposit_fee
    deposit_fee_1 + deposit_fee_2 + deposit_fee_3
  end

  #提货分公司管控
  def self.rpt_branch_mc_1(from_org_ids,to_org_ids,params_search)
    return [] if to_org_ids.blank?
    #保证金
    deposits = Deposit.where(:org_id => to_org_ids).search(:deposit_fee_1_gt => 0).group(:org_id)
    #未提货
    search_rpt_no_delivery = CarryingBill.where(:from_org_id => from_org_ids,:to_org_id => to_org_ids).rpt_no_delivery.search(params_search)
    carrying_bills_rpt_no_delivery = search_rpt_no_delivery.all

    #未到货
    search_rpt_no_reached = CarryingBill.where(:from_org_id => from_org_ids,:to_org_id => to_org_ids).rpt_no_reached.search(params_search)
    carrying_bills_rpt_no_reached = search_rpt_no_reached.all

    #今日收货
    search_rpt_today_bills = CarryingBill.where(:from_org_id => from_org_ids,:to_org_id => to_org_ids).rpt_today_bills.search(params_search)
    carrying_bills_rpt_today_bills = search_rpt_today_bills.all

    #郑发未返款票据
    search_rpt_no_refunded = CarryingBill.where(:from_org_id => from_org_ids,:to_org_id => to_org_ids).rpt_no_refunded.search(params_search)
    carrying_bills_rpt_no_refunded = search_rpt_no_refunded.all
    group_bills_rpt_no_refunded = carrying_bills_rpt_no_refunded.group_by(&:to_org)

    #郑发当日已返款票据
    search_rpt_refunded = CarryingBill.where(:from_org_id => from_org_ids,:to_org_id => to_org_ids,:bill_date => Date.today).rpt_refunded.search(params_search)
    carrying_bills_rpt_refunded = search_rpt_refunded.all
    group_bills_rpt_refunded = carrying_bills_rpt_refunded.group_by(&:to_org)



    #内部中转未返款
    search_inner_rpt_no_refunded = CarryingBill.where(:to_org_id => to_org_ids).rpt_inner_no_refunded
    carrying_bills_inner_rpt_no_refunded = search_inner_rpt_no_refunded.all
    group_bills_inner_rpt_no_refunded = carrying_bills_inner_rpt_no_refunded.group_by(&:to_org)

    #内部中转当日已返款
    search_inner_rpt_refunded = CarryingBill.where(:to_org_id => to_org_ids,:bill_date => Date.today).rpt_inner_refunded
    carrying_bills_inner_rpt_refunded = search_inner_rpt_refunded.all
    group_bills_inner_rpt_refunded = carrying_bills_inner_rpt_refunded.group_by(&:to_org)


    group_deposits = deposits.group_by(&:org)
    group_bills_rpt_no_delivery= carrying_bills_rpt_no_delivery.group_by(&:to_org)
    group_bills_rpt_no_reached = carrying_bills_rpt_no_reached.group_by(&:to_org)
    group_bills_rpt_today_bills = carrying_bills_rpt_today_bills.group_by(&:to_org)
    to_orgs = group_deposits.keys
    ret = []
    to_orgs.each do |to_org|
      deposit_fee = group_deposits[to_org].try(:first).try(:sum_deposit_fee).to_i
      bottom_deposit_fee = deposit_fee*0.8
      th_amount_no_delivery =  group_bills_rpt_no_delivery[to_org].try(:sum,&:sum_th_amount)
      th_amount_no_delivery = 0.0 if th_amount_no_delivery.blank?
      th_amount_no_reached = group_bills_rpt_no_reached[to_org].try(:sum,&:sum_th_amount)
      th_amount_no_reached = 0.0 if th_amount_no_reached.blank?
      th_amount_today_bills =  group_bills_rpt_today_bills[to_org].try(:sum,&:sum_th_amount)
      th_amount_today_bills =0.0 if th_amount_today_bills.blank?
      sum_th_amount = th_amount_no_delivery +  th_amount_no_reached +  th_amount_today_bills
      sum_diff = sum_th_amount - bottom_deposit_fee
      risk_rate = deposit_fee > 0 ? (sum_th_amount/deposit_fee)*100.0 : 100.0

      th_amount_no_refunded = group_bills_rpt_no_refunded[to_org].try(:sum,&:sum_th_amount)
      th_amount_no_refunded = 0.0 if th_amount_no_refunded.blank?

      th_amount_refunded = group_bills_rpt_refunded[to_org].try(:sum,&:sum_th_amount)
      th_amount_refunded = 0.0 if th_amount_refunded.blank?



      th_amount_inner_no_refunded =  group_bills_inner_rpt_no_refunded[to_org].try(:sum,&:sum_th_amount)
      th_amount_inner_no_refunded = 0.0 if th_amount_inner_no_refunded.blank?

      th_amount_inner_refunded =  group_bills_inner_rpt_refunded[to_org].try(:sum,&:sum_th_amount)
      th_amount_inner_refunded = 0.0 if th_amount_inner_refunded.blank?


      sum_2 = th_amount_no_refunded + th_amount_refunded  + th_amount_inner_no_refunded + th_amount_inner_refunded


      ret <<
      {
        :org_name => to_org.name,
        :deposit_fee => deposit_fee,
        :bottom_deposit_fee => bottom_deposit_fee,
        :th_amount_no_delivery => th_amount_no_delivery,
        :th_amount_no_reached => th_amount_no_reached,
        :th_amount_today_bills => th_amount_today_bills,
        :sum_th_amount => sum_th_amount,
        :sum_diff => sum_diff,
        :risk_rate => risk_rate.round(2),
        :th_amount_no_refunded => th_amount_no_refunded + th_amount_refunded ,
        :th_amount_inner_no_refunded => th_amount_inner_no_refunded + th_amount_inner_refunded,
        :sum_2 => sum_2
      }
    end
    ret
  end

  #预付分公司管控
  #to_org_ids 分公司id数组
  #params_search 查询条件
  def self.rpt_branch_mc_2(from_org_ids,to_org_ids,params_search)
    return [] if to_org_ids.blank?
    ret = []
    to_orgs = Org.where(:id => to_org_ids)
    #未到货
    search_rpt_no_reached = CarryingBill.where(:from_org_id => from_org_ids,:to_org_id => to_org_ids).rpt_no_reached.search(params_search)
    carrying_bills_rpt_no_reached = search_rpt_no_reached.all

    #今日收货
    search_rpt_today_bills = CarryingBill.where(:from_org_id => from_org_ids,:to_org_id => to_org_ids).rpt_today_bills.search(params_search)
    carrying_bills_rpt_today_bills = search_rpt_today_bills.all

    #内部中转今日返款
    search_inner_rpt_today_refund = CarryingBill.where(:to_org_id => to_org_ids).rpt_inner_today_refund
    carrying_bills_inner_rpt_today_refund = search_inner_rpt_today_refund.all

    group_bills_rpt_no_reached = carrying_bills_rpt_no_reached.group_by(&:to_org)
    group_bills_rpt_today_bills = carrying_bills_rpt_today_bills.group_by(&:to_org)
    group_bills_inner_rpt_today_refund = carrying_bills_inner_rpt_today_refund.group_by(&:to_org)
    to_orgs.each do |to_org|
      #当前欠款
      now_debts = 0.0
      #实收汇款
      act_pay_fee = 0.0
      th_amount_no_reached = group_bills_rpt_no_reached[to_org].try(:sum,&:sum_th_amount)
      th_amount_no_reached = 0.0 if th_amount_no_reached.blank?
      th_amount_today_bills =  group_bills_rpt_today_bills[to_org].try(:sum,&:sum_th_amount)
      th_amount_today_bills =0.0 if th_amount_today_bills.blank?

      th_amount_inner_today_refund =  group_bills_inner_rpt_today_refund[to_org].try(:sum,&:sum_th_amount)
      th_amount_inner_today_refund = 0.0 if th_amount_inner_today_refund.blank?

      sum_th_amount = now_debts + th_amount_no_reached +  th_amount_today_bills + th_amount_inner_today_refund
      sum_diff = sum_th_amount - act_pay_fee
      ret <<
      {
        :org_name => to_org.name,
        :now_debts => now_debts,
        :th_amount_no_reached => th_amount_no_reached,
        :th_amount_today_bills => th_amount_today_bills,
        :th_amount_inner_today_refund => th_amount_inner_today_refund,
        :sum_th_amount => sum_th_amount,
        :act_pay_fee => act_pay_fee ,
        :sum_diff => sum_diff
      }
    end
    ret
  end
end
