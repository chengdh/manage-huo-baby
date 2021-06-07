#coding: utf-8
class BaseDeliverInfo < ActiveRecord::Base
  self.table_name = "deliver_infos"
  default_scope :include => [:user,:org,:carrying_bills]
  belongs_to :user
  belongs_to :org
  has_many :carrying_bills,:foreign_key => "deliver_info_id",:order => "goods_no ASC"

  validates_presence_of :customer_name,:deliver_date,:org_id

  #二维码提货后图片上传功能
  has_attached_file :photo_1, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  has_attached_file :photo_2, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"

  validates_attachment_content_type :photo_1, :content_type => /\Aimage\/.*\Z/
  validates_attachment_content_type :photo_2, :content_type => /\Aimage\/.*\Z/
  validates_attachment_presence :photo_1,:if => lambda {|di| di.is_qrcode_pay }
  # validates_attachment_presence :photo_2,:if => lambda {|di| di.is_qrcode_pay }


  #定义状态机
  state_machine :initial => :billed do
    after_transition do |deliver_info,transition|
      deliver_info.carrying_bills.each {|bill| bill.standard_process}
    end
    event :process do
      transition :billed =>:deliveried
    end
  end
  default_value_for :deliver_date do
    Date.today
  end

  #是否是二维码付款
  def is_qrcode_pay
    ret = CarryingBill.search("id_in" => carrying_bill_ids,"from_customer_is_qrcode_pay_eq" => true,"goods_fee_gt" => 0).count
    return ret > 0
  end
  #合计应收运费
  def sum_carrying_fee_th
    self.carrying_bills.to_a.sum(&:carrying_fee_th)
  end
  #合计应收保险费
  def sum_insured_fee_th
    self.carrying_bills.to_a.sum(&:insured_fee_th)
  end
  #合计应收发货短途
  def sum_from_short_carrying_fee_th
    self.carrying_bills.to_a.sum(&:from_short_carrying_fee_th)
  end
  #合计应收到货短途
  def sum_to_short_carrying_fee_th
    self.carrying_bills.to_a.sum(&:to_short_carrying_fee_th)
  end
  #合计应收运费合计
  def sum_carrying_fee_th_total
    self.carrying_bills.to_a.sum(&:carrying_fee_th_total)
  end

  #合计应收代收货款
  def sum_goods_fee
    self.carrying_bills.to_a.sum(&:goods_fee)
  end
  #合计提货应收费用
  def sum_th_amount
    self.carrying_bills.to_a.sum(&:th_amount)
  end
  #运单编号
  def bill_no
    "#{self.carrying_bills.try(:first).try(:bill_no)} 共#{self.carrying_bills.size}票"
  end
  def sum_bills_count
    carrying_bills.size
  end
  #导出
  def self.to_csv(search_obj)
      search_obj.all.export_csv(self.export_options)
  end
  private
  def self.export_options
    {
      :only => [],
      :methods => [:org,:deliver_date,:bill_no,:customer_name,:customer_no,:sum_carrying_fee_th,:sum_insured_fee_th,:sum_from_short_carrying_fee_th,:sum_to_short_carrying_fee_th,:sum_carrying_fee_th_total,:sum_goods_fee,:sum_th_amount]
    }
  end
end
