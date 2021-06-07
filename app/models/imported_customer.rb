#coding: utf-8
#自运单导入的客户资料,用于客户分级
class ImportedCustomer < Customer
  belongs_to :org

  validates :org_id,:name, :presence => true
  default_scope :order => "cur_fee DESC"
  #以下定义状态
  STATE_NORMAL = 'normal'           #正常状态,没有下降
  STATE_1_MTH_DOWN = 'down_1mth'    #低于标准一个月
  STATE_2_MTH_DOWN = 'down_2mth'    #低于标准两个月
  STATE_3_MTH_DOWN = 'down_3mth'    #低于标准三个月
  STATE_4_MTH_DOWN = 'down_4mth'    #低于标准四个月
  STATE_UP_LEVEL = 'up'
  STATE_DOWN_LEVEL = 'down'

  #导入上月客户数据
  def self.import(summary_org_id)
    #Branch.where(:is_active => true).all.each {|org| CustomerFeeInfo.generate_data(org.id)}
    CustomerFeeInfo.generate_data(summary_org_id)
  end
  #重新生成数据
  def self.re_generate_data(summary_org_id)
    CustomerFeeInfoLine.destroy_all
    CustomerFeeInfo.destroy_all
    ImportedCustomer.destroy_all
    #重新生成2015年至上月的所有数据
    (1..12).each do |i|
      CustomerFeeInfo.generate_data(summary_org_id,"2015" + "%02d" % i)
    end
    #2016年的数据
    (1..5).each do |i|
      CustomerFeeInfo.generate_data(summary_org_id,"2016" + "%02d" % i)
    end
  end
  #计算vip的状态和级别
  def self.update_state!(org_id)
    #只计算持卡客户的级别
    vip_infos = self.where(:org_id => org_id).search(:code_is_not_null => true)
    vip_infos.each do |vip_info|
      vip_info.cal_state!
      vip_info.save!
    end
  end
  #设置level描述
  def self.states
    ordered_hash = ActiveSupport::OrderedHash.new
    ordered_hash[STATE_NORMAL] = "正常"
    ordered_hash[STATE_1_MTH_DOWN] = "下降-1个月"
    ordered_hash[STATE_2_MTH_DOWN] = "下降-2个月"
    ordered_hash[STATE_3_MTH_DOWN] = "下降-3个月"
    ordered_hash[STATE_4_MTH_DOWN] = "下降-4个月"
    ordered_hash
  end

  #获取转账客户所属机构
  def own_org
    return org if code.blank?
    Vip.find_by_code(code).try(:org)
  end
  def address_desc_for_print
    "#{deliver_region.try(:district_desc_for_print)}"
  end
  def address_desc
    "#{deliver_region}>#{name}"
  end

  #根据vip_info的当前信息计算其状态
  #贵宾客户分三个级别：钻石、金卡、银卡、普通
  #如升级后期贵宾客户所发货物运费低于所制定比例标准一个月，以黄色显示，第二个月以红色显示，第三个月以黑色显示，第四个月自动降级。
  #201604 不再降级,每年1月份计算降级
  def cal_state!
    cur_year = Date.today.year
    last_year = Date.today.year - 1

    self.state = STATE_NORMAL

    #每年1月份计算上年费用情况,进行级别更改
    if Date.today.month == 1
      last_year_sum_fee = self.year_sum_fee(last_year)
      #根据金额判断其级别
      the_level = CustomerLevelConfig.get_level(self.org_id,last_year_sum_fee)
      self.state = STATE_DOWN_LEVEL if self.level > the_level
      self.state = STATE_UP_LEVEL if self.level < the_level

      self.level = the_level
    end
    #如果计算级别高于当前级别,则客户升级
    cur_level = self.level.blank? ? CustomerLevelConfig::VIP_NORMAL : self.level
    cur_year_sum_fee = self.cur_year_sum_fee
    next_level  = CustomerLevelConfig.get_level(self.org_id,cur_year_sum_fee)

    self.cur_fee = cur_year_sum_fee
    if next_level > cur_level
      self.level = next_level
      self.state = STATE_UP_LEVEL
    end
  end
  def org_name
    self.org.name
  end
  def level_des
    CustomerLevelConfig.levels[self.level]
  end
  def state_des
    CustomerLevelConfig.states[self.state]
  end
  #某年运费合计
  #如有卡号,以卡号为准汇总
  #无卡号,以手机号为准
  def year_sum_fee(year)
    sum_fee = 0
    mth_range = ("#{year}01".."#{year}12").to_a
    if code.present?
      sum_fee = CustomerFeeInfoLine.search("customer_fee_info_mth_in" => mth_range,:code_eq => code).sum(:fee)
    else
      sum_fee = CustomerFeeInfoLine.search("customer_fee_info_mth_in" => mth_range,:name_eq => name,:phone_eq => mobile).sum(:fee)
    end
    sum_fee
  end
  #当年运费合计
  def cur_year_sum_fee
    year_sum_fee(Date.today.year)
  end
  #总运费
  def sum_fee
    if code.present?
      sum_fee = CustomerFeeInfoLine.search(:code_eq => code,:code_is_not_null => true).sum(:fee)
    else
      sum_fee = CustomerFeeInfoLine.search(:phone_eq => mobile,:name_eq => name,:phone_is_not_null => true).sum(:fee)
    end
    sum_fee
  end
  #级别显示-星号
  def level_star
    ret = ""
    ret = "★★★" if level.eql?("level_99")
    ret = "★★" if level.eql?("level_88")
    ret = "★" if level.eql?("level_66")
    ret
  end
  #积分
  def year_sum_points(year)
    rate = IlConfig.vip_point_rate.to_f
    (year_sum_fee(year)*rate).round
  end
  #当年积分
  def cur_year_sum_points
    rate = IlConfig.vip_point_rate.to_f
    (cur_year_sum_fee*rate).round
  end
  #总积分
  def sum_points
    rate = IlConfig.vip_point_rate.to_f
    (sum_fee*rate).round
  end
end
