#coding: utf-8
#运单货物明细
class BillLine < ActiveRecord::Base
  belongs_to :carrying_bill
  belongs_to :goods_cat
  belongs_to :fee_unit
  # validates_presence_of :goods_cat_id_should_present
  # validates_presence_of :fee_unit_id_should_present
  # validates_presence_of :name_should_present
  validates_numericality_of :price,:volume,:weight
  validates_numericality_of :amt,:greater_than => 0

  default_value_for :volume,0
  default_value_for :weight,0
  default_value_for :qty,0

  private
  def goods_cat_id_should_present
    if carrying_bill.type.eql?("AutoCalculateComputerBill") and goods_cat_id.blank?
      errors.add(:goods_cat_id,"货物类别不可为空.")
    end
  end
  def fee_unit_id_should_present
    if carrying_bill.type.eql?("TonVolumeBill") and fee_unit_id.blank?
      errors.add(:fee_unit_id,"计量单位不可为空.")
    end
  end
  def name_should_present
    if carrying_bill.type.eql?("TonVolumeBill") and name.blank?
      errors.add(:name,"货物名称不可为空.")
    end
  end
end
