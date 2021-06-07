#coding: utf-8
#分理处分成比例
class DivideList < ActiveRecord::Base
  belongs_to :org
  has_many :divide_list_lines,:dependent => :destroy
  validates :org_id, presence: true
  validates :distance_from_summary,:price_per_mile,numericality: true
  accepts_nested_attributes_for :divide_list_lines

  #显示所有的明细信息,包括已保存的和新建的
  def all_lines
    price_list_line_ids = divide_list_lines.pluck(:price_list_line_id)

    price_list_lines = nil
    if divide_list_line_ids.blank?
      price_list_lines = PriceListLine.order("price_list_id") 
    else
      price_list_lines = PriceListLine.where(["id NOT IN (?)",price_list_line_ids]).order("price_list_id") 
    end
    price_list_lines.each do |pll|
      divide_list_lines << DivideListLine.new(:price_list_line => pll)
    end
    divide_list_lines
  end

  #显示按照分公司分组的分成明细
  def grouped_all_lines
    all_lines.group_by {|l| l.try(:price_list_line).try(:price_list).try(:org)}
  end

  #获取分成比例信息
  def self.get_divide_rate(from_org_id,to_org_id,fee_unit_id)
    ret = 0.0
    divide_list = self.find_by_org_id_and_is_active(from_org_id,true)
    to_org = Org.find(to_org_id)
    to_org_ids = [to_org_id]
    to_org_ids += to_org.parent_id if to_org.parent_id.present?
    if divide_list.present?
      divide_line = divide_list.divide_list_lines.search(:price_list_line_price_list_org_id_in => [to_org_ids],
                                           :price_list_line_price_list_is_active_eq => true,
                                           :price_list_line_fee_unit_id_eq => fee_unit_id).try(:first)
      ret = divide_line.try(:divide_rate)
    end
    ret
  end
end
