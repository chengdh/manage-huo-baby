#coding: utf-8
#客户费用合计
class CustomerFeeInfo < ActiveRecord::Base
  belongs_to :org
  belongs_to :user
  has_many :customer_fee_info_lines,:dependent => :delete_all,:order => "fee DESC"
  validates_presence_of :org_id,:mth

  #从运单中生成数据
  #默认导入上月数据
  #按照 姓名 + 电话 认定为同一人
  def self.generate_data(org_id,mth=1.months.ago.strftime("%Y%m"))
    cfi = self.find_or_create_by_mth_and_org_id(mth,org_id)
    cfi.customer_fee_info_lines.clear
    #得到给定时间段的客户数据(从运单表中提取)
    #f_date = 1.months.ago.beginning_of_month
    #t_date = 1.months.ago.end_of_month
    f_date = "#{mth[0..3]}-#{mth[4..5]}-01"
    t_date = Date.strptime(f_date,'%Y-%m-%d').end_of_month.strftime("%Y-%m-%d")
    org = Org.find(org_id)
    children_org_ids =  org.children.map(&:id)
    org_ids = children_org_ids + [org_id]

    #按照转账客户卡号进行统计
    CarryingBill.search(:from_customer_id_is_not_null => true,
                        #:from_customer_id_eq => 221191,
                        :from_org_id_in => org_ids,
                        :bill_date_gte => f_date,
                        :bill_date_lte => t_date,
                        :state_ni => ['canceled','invalided'] ) \
      .select('from_customer_id,sum(carrying_fee) sum_carrying_fee') \
      .group('from_customer_id').each do |bill|
      if bill.from_customer.present?
        cfi.customer_fee_info_lines.create!(:name =>bill.try(:from_customer).try(:name),
                                            :phone => bill.try(:from_customer).try(:mobile),
                                            :code => bill.try(:from_customer).try(:code),
                                            :fee => bill.sum_carrying_fee)
      end
    end

    CarryingBill.search(:from_customer_id_is_null => true,
                        :from_org_id_in => org_ids,
                        :bill_date_gte => f_date,
                        :bill_date_lte => t_date,
                        :state_ni => ['canceled','invalided'] ) \
      .select('from_customer_name,from_customer_mobile,sum(carrying_fee) sum_carrying_fee') \
      .group('from_customer_name,from_customer_mobile').each do |bill|
      cfi.customer_fee_info_lines.create(:name =>bill.from_customer_name,
                                         :phone => bill.from_customer_mobile,
                                         :fee => bill.sum_carrying_fee)
    end
    #返程货统计
    #CarryingBill.search(:to_org_id_eq => org_id,:bill_date_gte => f_date,:bill_date_lte => t_date) \
    #  .select('to_customer_name,to_customer_mobile,sum(carrying_fee) sum_carrying_fee') \
    #  .group('to_customer_name,to_customer_phone').each do |bill|
    #  the_line = cfi.customer_fee_info_lines.find_or_create_by_name_and_phone(bill.to_customer_name,bill.to_customer_mobile)
    #  the_line.update_attributes(:fee => bill.sum_carrying_fee + the_line.fee)
    #end
    ImportedCustomer.update_state!(org_id)
  end
  #导出到csv
  def to_csv
    ret = ["#{self.org}#{self.mth}客户信息列表"].export_line_csv(true)
    ret += self.customer_fee_info_lines.export_csv(CustomerFeeInfo.export_options,false)
    ret
  end
  private
  def self.export_options
    {
      :only => [:name,:phone,:fee]
    }
  end
end
