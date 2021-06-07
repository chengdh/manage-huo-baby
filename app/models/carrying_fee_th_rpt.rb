#coding: utf-8
#实提运费报表
class CarryingFeeThRpt < ActiveRecord::Base
  belongs_to :from_org,:class_name => "Org"
  belongs_to :to_org,:class_name => "Org"
  validates :bill_date,:from_org_id,:to_org_id, :presence => true
  validates :carrying_fee, :numericality => {:greater_than => 0}
  attr_accessible :bill_date, :carrying_fee,:from_org,:to_org

  #按照到货地合计
  #分理处实提运费统计
  scope :group_by_to_org_id,select("bill_date,to_org_id,sum(carrying_fee) as carrying_fee").group("to_org_id,bill_date").order("bill_date ASC")

  #按照分公司合计
  #分公司实提运费统计
  scope :group_by_from_org_id,select("bill_date,from_org_id,sum(carrying_fee) as carrying_fee").group("from_org_id,bill_date").order("bill_date ASC")

  #当月提付合计
  scope :sum_cur_mth_carrying_fee_by_to_org,lambda {|to_org_ids| select("to_org_id,sum(carrying_fee) AS carrying_fee").where(:to_org_id => to_org_ids).where(["bill_date >= ? AND bill_date <= ?",Date.today.beginning_of_month,Date.today.end_of_month]) }

  #当月实付运费合计(从本地付出的)
  scope :sum_cur_mth_carrying_fee_by_from_org,lambda {|from_org_ids| select("from_org_id,sum(carrying_fee) AS carrying_fee").where(:from_org_id => from_org_ids).where(["bill_date >= ? AND bill_date <= ?",Date.today.beginning_of_month,Date.today.end_of_month]) }

  #生成报表数据,在凌晨4点调用,生成前一天数据
  #使用wheneven配置cron调用
  def self.generate_rpt
    bill_date = Date.yesterday
    refound_ids = Refound.where(:bill_date => bill_date,:transit_org_id => nil).map {|c| c.id}
    carrying_bills = CarryingBill.refound_sum(refound_ids)
    carrying_bills.each do |c|
      CarryingFeeThRpt.create!(:bill_date => bill_date,
                               :from_org => c.to_org,
                               :to_org => c.from_org,
                               :carrying_fee => c.carrying_fee)
    end
  end
end
