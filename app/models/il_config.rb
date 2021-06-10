#coding: utf-8
class IlConfig < ActiveRecord::Base
  validates_presence_of :key
  validates :key,:presence => true,:uniqueness => true
  #保价费设置比例
  #废弃不用
  KEY_INSURED_RATE = 'insured_rate'

  #保价费
  KEY_INSURED_FEE = 'insured_fee'

  #运费大于指定金额才产生保险费
  KEY_CARRYING_FEE_GTE_ON_INSURED_FEE = "carrying_fee_gte_on_insured_fee"

  #欠款提货滞纳金比例
  KEY_DEBT_RATE = 'debt_rate'

  #用户名称设置
  KEY_CLIENT_NAME = "client_name"
  #logo设置
  KEY_LOGO = "client_logo"
  #title
  KEY_TITLE = 'system_title'

  #最高手续费 0 = 无限制
  KEY_MAX_HAND_FEE = 'max_hand_fee'
  #一张运单最多打印条码数量
  KEY_MAX_BARCODE_PRINT_COUNT = "max_barcode_print_count"

  #微信号
  KEY_WEIXIN = "logistics"
  #微信二维码图片url
  KEY_WEIXIN_QRCODE_URL = ""

  #积分兑换比例
  KEY_VIP_POINT_RATE = "vip_points_rate"

  #分理处分成设置
  KEY_DIVIDE_COST_FEE ="divide_cost_fee"

  def self.weixin
    weixin ||= self.find_by_key(KEY_WEIXIN)
    weixin ||= self.create(:key => KEY_WEIXIN,:title => '微信公众号码',:value => 'weixin')
    weixin.value
  end

  def self.weixin_qr_logo
    weixin_logo ||= self.find_by_key(KEY_WEIXIN_QRCODE_URL)
    weixin_logo ||= self.create(:key => KEY_WEIXIN_QRCODE_URL,:title => '微信二维码',:value => '/assets/weixin.jpg')
    weixin_logo.value
  end


  def self.max_barcode_print_count
    max_barcode_print_count ||= self.find_by_key(KEY_MAX_BARCODE_PRINT_COUNT)
    max_barcode_print_count ||= self.create(:key => KEY_MAX_BARCODE_PRINT_COUNT,:title => '每票最多打印条码张数',:value => '100')
    max_barcode_print_count.value
  end

  def self.debt_rate
    debt_rate ||= self.find_by_key(KEY_DEBT_RATE)
    debt_rate ||= self.create(:key => KEY_DEBT_RATE,:title => '欠款提货罚金比例',:value => '0.01')
    debt_rate.value
  end
  def self.insured_rate
    insured_rate ||= self.find_by_key(KEY_INSURED_RATE)
    insured_rate ||= self.create(:key => KEY_INSURED_RATE,:title => '保价费比例设置',:value => '0.003')
    insured_rate.value
  end
  #保险费,默认2元
  def self.insured_fee
    insured_fee ||= self.find_by_key(KEY_INSURED_FEE)
    insured_fee ||= self.create(:key => KEY_INSURED_FEE,:title => '默认保价费',:value => '2')
    insured_fee.value
  end
  #运费大于等于指定金额时才产生保险费
  def self.carrying_fee_gte_on_insured_fee
    carrying_fee_gte ||= self.find_by_key(KEY_CARRYING_FEE_GTE_ON_INSURED_FEE)
    carrying_fee_gte ||= self.create(:key => KEY_CARRYING_FEE_GTE_ON_INSURED_FEE,:title => '运费大于等于指定金额时才产生保险费',:value => '16')
    carrying_fee_gte.value
  end

  def self.client_name
    client_name ||=self.find_by_key(KEY_CLIENT_NAME)
    client_name ||= self.create(:key => KEY_CLIENT_NAME,:title => '公司名称',:value => '管货宝')
    client_name.value
  end
  def self.client_logo
    client_logo ||= self.find_by_key(KEY_LOGO)
    client_logo ||= self.create(:key => KEY_LOGO,:title => '公司标志',:value => '/assets/yujiu-logo.png')
    client_logo.value
  end
  def self.system_title
    system_title ||= self.find_by_key(KEY_TITLE)
    system_title ||= self.create(:key => KEY_TITLE,:title => '系统名称',:value => '管货宝-开源物流平台')
    system_title.value
  end
  def self.max_hand_fee
    system_title ||= self.find_by_key(KEY_MAX_HAND_FEE)
    system_title ||= self.create(:key => KEY_MAX_HAND_FEE,:title => '最高手续费(0表示上不封顶)',:value => '0')
    system_title.value
  end
  def self.vip_point_rate
    system_title ||= self.find_by_key(KEY_VIP_POINT_RATE)
    system_title ||= self.create(:key => KEY_VIP_POINT_RATE,:title => '积分兑换比例',:value => '1')
    system_title.value
  end

  def self.divide_cost_fee
    system_title ||= self.find_by_key(KEY_DIVIDE_COST_FEE)
    system_title ||= self.create(:key => KEY_DIVIDE_COST_FEE,:title => '分理处分成固定费用',:value => '10000')
    system_title.value
  end
end
