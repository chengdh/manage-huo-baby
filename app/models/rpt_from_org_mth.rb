#coding: utf-8
#运费货款统计表
class RptFromOrgMth < ActiveRecord::Base
  belongs_to :from_org,:class_name => "Org"

  #生成月统计数据
  def self.generate_data(mth = nil)
    mth = 1.months.ago.strftime("%Y%m") if mth.blank?
    f_date,t_date = parse_mth(mth)
    sum_infos = CarryingBill.mth_turnover(f_date,t_date)
    sum_infos.each do |s|
      delete_all(:mth => mth,:from_org_id => s.from_org_id,:pay_type => s.pay_type,:to_org_id => nil)
      attrs = s.attributes
      attrs[:mth] = mth
      create(attrs)
    end
  end

  #生成月统计数据by to_org_id
  def self.generate_data_ty_to_org(mth = nil)
    mth = 1.months.ago.strftime("%Y%m") if mth.blank?
    f_date,t_date = parse_mth(mth)
    sum_infos = CarryingBill.mth_turnover_by_to_org(f_date,t_date)
    sum_infos.each do |s|
      delete_all(:mth => mth,:to_org_id => s.to_org_id,:pay_type => s.pay_type,:from_org_id => nil)
      attrs = s.attributes
      attrs[:mth] = mth
      create(attrs)
    end
  end



  def from_org_name
    from_org.try(:name)
  end

  private
  #mth 形式为201411
  #将mth 转换为起始与终止日期
  #如果mth为nil,返回上个月的起止日期
  def self.parse_mth(mth)
    if mth.blank?
      return 1.months.ago.beginning_of_month.to_date,1.months.ago.end_of_month.to_date
    end
    f_date = Date.strptime(mth,"%Y%m")
    t_date = f_date.end_of_month
    return f_date,t_date
  end
end
