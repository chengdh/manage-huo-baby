#coding: utf-8
#按照吨或方计算运费的运单
class TonVolumeBill < CarryingBill
  #对于原始单据来讲,有一个对应的退货单据
  has_one :return_bill,:foreign_key => "original_bill_id",:class_name => "ReturnBill"

  has_many :bill_lines,:foreign_key => :carrying_bill_id
  #创建/修改数据前生成票据编号和货号
  before_validation :generate_bill_no,:on => :create
  before_validation :generate_goods_no
  #更新数据时,验证运单号/货号不可为空
  validates :bill_no,:goods_no,:to_org_id,:presence => true
  accepts_nested_attributes_for :bill_lines,:reject_if => proc {|attrs| attrs['name'].blank? or attrs['name'].blank? or attrs['amt'].blank? or attrs['amt'].to_i == 0 } 
  #构造默认运单明细
  #after_initialize :build_lines
  private
  def build_lines
    (3 - self.bill_lines.size).times { self.bill_lines.build }
  end
end
