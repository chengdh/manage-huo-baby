#coding: utf-8
#分成比例设置
class DivideConfig < ActiveRecord::Base
  belongs_to :from_org,:class_name => "Org"
  belongs_to :transit_org,:class_name => "Org"
  belongs_to :to_org,:class_name => "Org"
  belongs_to :summary_org,:class_name => "Org"
  belongs_to :other_org_1,:class_name => "Org"
  belongs_to :other_org_2,:class_name => "Org"
  belongs_to :other_org_3,:class_name => "Org"
  validates :from_org_divide_rate,:transit_org_divide_rate,:to_org_divide_rate,
    :summary_org_divide_rate,:other_org_1_divide_rate,:other_org_2_divide_rate,
    :other_org_3_divide_rate,:numericality => true

  def bill_type_des
    ret = ""
    ret = "按吨方计算运单" if bill_type.eql?("TonVolumeBill")
    ret = "分公司运单" if bill_type.eql?("BranchBill")
    ret
  end
  def from_org_divide_rate_des
    "#{from_org_divide_rate*100}%"
  end
  def transit_org_divide_rate_des
    "#{transit_org_divide_rate*100}%"
  end
  def to_org_divide_rate_des
    "#{to_org_divide_rate*100}%"
  end
  def summary_org_divide_rate_des
    "#{summary_org_divide_rate*100}%"
  end

  #获取branch_bill分成比例
  def self.get_branch_bill_divide_rate(from_org_id,to_org_id)
    divide_config = self.where(:from_org_id => from_org_id,:to_org_id => to_org_id,:bill_type => "BranchBill").try(:first)
    #如果找不到数据,则查询父机构是否进行了设置
    from_org_ids = [from_org_id]
    from_org = Org.find(from_org_id)
    from_org_ids += [from_org.parent_id] if from_org.parent_id.present?

    to_org_ids = [to_org_id]
    to_org = Org.find(to_org_id)
    to_org_ids += [to_org.parent_id] if to_org.parent_id.present?
    if divide_config.blank? and (from_org.parent_id.present? or to_org.parent_id.present?)
      divide_config = self.where(:from_org_id => [from_org_ids],
                                 :to_org_id => [to_org_ids],
                                 :bill_type => "BranchBill").try(:first)
    end

    f_divide_rate = divide_config.try(:from_org_divide_rate).to_f
    t_divide_rate = divide_config.try(:to_org_divide_rate).to_f
    ts_divide_rate = divide_config.try(:transit_org_divide_rate).to_f

    transit_org_id = divide_config.try(:transit_org_id)
    summary_org_id = Org.where(:is_active => true,:is_summary => true).try(:first).id

    s_divide_rate = 1.0 - f_divide_rate - t_divide_rate - ts_divide_rate
    ret = {
      :from_org => [from_org_id,f_divide_rate],
      :to_org => [to_org_id , t_divide_rate],
      :transit_org => [transit_org_id , ts_divide_rate],
      :summary_org => [summary_org_id , s_divide_rate]
    }

  end

  #获去ton_volume_bill的分成比例信息
  def self.get_ton_volume_bill_divide_rate(from_org_id,to_org_id,fee_unit_id)
    f_divide_rate = DivideList.get_divide_rate(from_org_id,to_org_id,fee_unit_id)
    divide_config = self.where(:from_org_id => from_org_id,:to_org_id => to_org_id,:bill_type => "TonVolumeBill").try(:first)
    #如果找不到数据,则查询父机构是否进行了设置
    from_org_ids = [from_org_id]
    from_org = Org.find(from_org_id)
    from_org_ids += [from_org.parent_id] if from_org.parent_id.present?

    to_org_ids = [to_org_id]
    to_org = Org.find(to_org_id)
    to_org_ids += [to_org.parent_id] if to_org.parent_id.present?
    if divide_config.blank? and from_org.parent_id.present?
      divide_config = self.where(:from_org_id => [from_org_ids],
                                 :to_org_id => [to_org_ids],
                                 :bill_type => "TonVolumeBill").try(:first)
    end

    t_divide_rate = divide_config.try(:to_org_divide_rate).to_f

    summary_org = Org.where(:is_active => true,:is_summary => true).try(:first)

    s_divide_rate = 1.0 - f_divide_rate - t_divide_rate
    ret = {
      :from_org => [from_org_id,f_divide_rate],
      :to_org => [to_org_id , t_divide_rate],
      :summary_org => [summary_org.id , s_divide_rate]
    }
  end
end
