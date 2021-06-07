#coding: utf-8
#分公司价格表
class PriceList < ActiveRecord::Base
  belongs_to :org
  has_many :price_list_lines,:dependent => :destroy
  accepts_nested_attributes_for :price_list_lines
  validates :org_id, presence: true

  #显示所有的明细信息,包括已保存的和新建的
  def all_lines
    fee_unit_ids = price_list_lines.pluck(:fee_unit_id)

    fee_units = FeeUnit.where(["is_active = 1"])
    fee_units = FeeUnit.where(["is_active = 1 AND id NOT IN (?)",fee_unit_ids]) if fee_unit_ids.present?
    fee_units.each do |fu|
      price_list_lines << PriceListLine.new(:fee_unit => fu)
    end
    price_list_lines
  end
end
