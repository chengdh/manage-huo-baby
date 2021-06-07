#coding: utf-8
#转账客户
class Vip <  Customer
  #attr_protected :code
  # attr_accessor :qr_photo_1_file_name,:qr_photo_2_file_name
  default_scope :order => "code ASC",:include => [:bank,:org]
  belongs_to :bank
  belongs_to :org
  belongs_to :config_transit
  has_many :carrying_bills,:foreign_key => :from_customer_id
  validates :name,:id_number,:org_id,:bank_id,:mobile,:presence => true
  validates :code,:id_number,:bank_card,:uniqueness => true
  validates :bank_card,:length => {:maximum => 30}
  validates :mobile,:length => {:is => 11}
  #validates_length_of :code, :is => 7

  validate :check_code
  #validate :check_bank_card

  before_validation :set_code,:on => :create

  has_attached_file :qr_photo_1, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  has_attached_file :qr_photo_2, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"

  validates_attachment_content_type :qr_photo_1, :content_type => /\Aimage\/.*\Z/
  validates_attachment_content_type :qr_photo_2, :content_type => /\Aimage\/.*\Z/

  #定义状态机
  state_machine :vip_state,:initial => :draft do
    event :audit do
      transition :draft =>:audited
    end
  end

  #导出
  def self.to_csv(search_obj)
    search_obj.all.export_csv(self.export_options)
  end
  def self.export_options
    {
      :only => [],
      :methods => [:org,:name,:code,:phone,:mobile,:address,:bank,:bank_card]
    }
  end

  #同步运单发货人姓名
  #param only_in_complete 只是同步未完成的运单
  def syn_from_customer_name
    if self.carrying_bills.present?
      self.carrying_bills.update_all(:from_customer_name => self.name)
    end
  end

  #对应的客户大资料中的当前级别
  def level
    ret = "level_11"
    imported_customer = ImportedCustomer.find_by_code(code)
    ret = imported_customer.try(:level) if imported_customer.present?
    ret
  end

  #星级标识
  def level_star
    imported_customer = ImportedCustomer.find_by_code(code)
    imported_customer.try(:level_star)
  end

  private
  def set_code
    self.code = self.bank.code + "66" + get_sequence
  end
  #根据机构获取当前机构已有的VIP客户数量
  def get_sequence
    #max_code = Vip.maximum(:code,:conditions => {:bank_id => self.bank_id})
    max_code = Vip.maximum(:code,:conditions => ["bank_id= ? and substring(code,2,2)=?",self.bank_id,'66'])
    next_seq = 1
    next_seq = max_code[/\d{4}$/].to_i + 1 if max_code.present?

    se = "%04d" % next_seq
  end
  def check_code
      errors.add(:code,"编号起始数字不正确(兴业-6 建行-8 浦发-2).") unless code.start_with?(bank.code)
  end
  def check_bank_card
    errors.add(:bank_card,"银行卡号输入不正确(兴业-6 建行-8 浦发-2).") unless bank_card.start_with?(bank.code)
  end
end
