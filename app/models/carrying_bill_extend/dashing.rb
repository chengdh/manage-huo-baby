# -*- encoding : utf-8 -*-
#定义与shopify/dashing相关的服务
module CarryingBillExtend
  module Dashing 
    def self.included(base)
      base.extend(ClassMethods)
      base.class_eval do
        #以下方法都是为dashing服务的
        #今日收货
        scope :dashing_today_billed,lambda { |bill_date| select('orgs.name AS from_org_name,from_org_id,pay_type,sum(carrying_fee) AS carrying_fee,'+
                                    'sum(goods_fee) AS goods_fee,sum(insured_fee) AS insured_fee,' +
                                    'sum(from_short_carrying_fee) AS from_short_carrying_fee,'+
                                    'sum(to_short_carrying_fee) AS to_short_carrying_fee,' +
                                    'sum(goods_num) AS goods_num,sum(1) AS bill_count') \
          .joins("INNER JOIN orgs ON carrying_bills.from_org_id = orgs.id") \
          .where(:bill_date => bill_date) \
          .where(["state not in ('canceled','invalided')"]) \
          .order("orgs.order_by ASC") \
          .group("from_org_id,pay_type") }

        #今日提货
        scope :dasing_today_deliveried,select('to_org_id,type,pay_type,sum(carrying_fee) as carrying_fee,'+
                                              'sum(goods_fee)  as goods_fee,sum(insured_fee) as insured_fee,'+
                                              'sum(from_short_carrying_fee) as from_short_carrying_fee,'+
                                              'sum(to_short_carrying_fee) as to_short_carrying_fee,'+
                                              'sum(goods_num) as goods_num,sum(1) as bill_count') \
        .where(:state =>:deliveried) \
        .search(:deliver_info_deliver_date_eq => Date.today) \
        .group('to_org_id,type,pay_type')

        #今日提款(仅指现金提款)
        scope :dashing_today_paid,select('pay_type,sum(carrying_fee) as carrying_fee,sum(insured_fee) as insured_fee,'+
                                         'sum(from_short_carrying_fee) as from_short_carrying_fee,'+
                                         'sum(to_short_carrying_fee) as to_short_carrying_fee,sum(goods_fee) as goods_fee,'+
                                         'sum(goods_num) as goods_num,sum(k_hand_fee) as k_hand_fee,'+
                                         'sum(transit_hand_fee) as transit_hand_fee,sum(1) as bill_count') \
        .where(:state =>:paid) \
        .search(:from_customer_id_is_null => 1,:pay_info_bill_date_eq => Date.today) \
        .group('from_org_id,pay_type')
        #最近票据(5张)
      end
    end

    #class methods
    module ClassMethods 
      #提供当日收货-票据数
      def dashing_bills_count_data
        today_data =  dashing_today_billed(Date.today)
        yesterday_data = dashing_today_billed(1.days.ago.to_date)
        ret = {:today => today_data,:yesterday => yesterday_data}
        ret
      end
    end
  end
end
 
