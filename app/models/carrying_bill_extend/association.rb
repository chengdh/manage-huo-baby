# -*- encoding : utf-8 -*-
# 运单association定义相关
module CarryingBillExtend
  module Association
    def self.included(base)
      base.extend(ClassMethods)
      base.class_eval do
        belongs_to :user
        belongs_to :from_org,:class_name => "Org"
        belongs_to :transit_org,:class_name => "Org"
        belongs_to :to_org,:class_name => "Org"
        belongs_to :area

        belongs_to :from_customer,:class_name => "Customer"

        #短驳清单
        belongs_to :short_list

        #票据对应的装车清单
        belongs_to :load_list,:class_name => "BaseLoadList"
        belongs_to :distribution_list,:class_name => "BaseDistributionList"

        belongs_to :deliver_info,:class_name => "BaseDeliverInfo"
        belongs_to :settlement,:class_name => "BaseSettlement"
        belongs_to :refound,:class_name => "BaseRefund"
        belongs_to :payment_list
        belongs_to :pay_info
        belongs_to :post_info,:class_name => "BasePostInfo"

        belongs_to :transit_info
        belongs_to :transit_deliver_info

        #于退货单来讲,所对应的原始票据,未退货的票据为空
        belongs_to :original_bill,:class_name => "CarryingBill"
        #对于原始单据来讲,有一个对应的退货单据
        has_one :return_bill,:foreign_key => "original_bill_id",:class_name => "BaseReturnBill"

        #NOTE 20120424 添加goods_cat
        belongs_to :goods_cat


        #该运单对应的送货信息
        #当前活动的只能有一条
        has_one :send_list_line
        #有多条装车记录
        has_many :act_load_list_lines
        #有多条短途运费明细记录
        has_many :short_fee_info_lines

        #有多条通知明细信息
        has_many :notice_lines

        #有多条运费调整信息
        has_many :adjust_fee_infos

        #有多条运费调整信息
        has_many :adjust_goods_fee_infos

        #运单备注信息
        has_many :bill_notes

        #有一条发货人及收货人信息
        has_one :bill_association_object,:as => :customerable

        #货损理赔信息
        has_one :goods_exception

        #回执付/月结客户付款信息
        has_one :customer_payment_info_line

        #入库 装车
        has_many :scan_lines

        has_one :to_imported_customer,:through => :bill_association_object,:source => :to_customer

        #具有多条扫码信息
        has_many :load_list_with_barcode_lines

        #具有多条货物异常信息
        has_many :barcode_exceptions,:class_name => "LoadListWithBarcodeLine",:conditions => {:state => :goods_exception}

        accepts_nested_attributes_for :bill_association_object #, :reject_if => proc { |attrs| attrs['from_customer_id'].blank? and attrs['to_customer_id'].blank? and attrs['is_urgent'].blank? and attrs['is_receipt'].blank? and attrs['is_deliver'].blank? and attrs['is_list'].blank? }

        accepts_nested_attributes_for :bill_notes,:reject_if => proc {|attrs| attrs[:note].blank?}

        #audited设置
        audited :only => [:carrying_fee,:insured_fee,:from_short_carrying_fee,:to_short_carrying_fee,
                          :goods_fee,:pay_type,:goods_info],
                          :allow_mass_assignment => true,
                          :on => [:update]

      end
    end
    #类方法
    module ClassMethods;end
  end
end
