# -*- encoding : utf-8 -*-
#定义运单scope相关
module CarryingBillExtend
  module Scope
    def self.included(base)
      base.extend(ClassMethods)
      base.class_eval do

        scope :waitting_short_list_load,lambda {|from_org_id| where(:state => :billed,:from_org_id => from_org_id,:short_list_id => nil)}

        # default_scope {joins(:bill_association_object).includes(:bill_association_object)}
        #营业额统计
        scope :turnover,lambda {select('from_org_id,IFNULL(to_org_id,transit_org_id) as to_org_id,sum(carrying_fee) as sum_carrying_fee,'+
                               'sum(goods_fee) as sum_goods_fee,sum(insured_fee) as sum_insured_fee,'+
                               'sum(from_short_carrying_fee) as sum_from_short_carrying_fee,sum(to_short_carrying_fee) as sum_to_short_carrying_fee,'+
                               'sum(goods_num) as sum_goods_num,sum(1) as sum_bill_count') \
          .where(["state not in ('canceled','invalided')"]) \
          .group('from_org_id,to_org_id')
        }

        #月营业额统计,用于统计发货地每月发生的汇总费用
        scope :mth_turnover,lambda {|f_date,t_date| select('from_org_id,'+
                                                           'pay_type,'+
                                                           'sum(carrying_fee) as sum_carrying_fee,'+
                                                           'sum(goods_fee) as sum_goods_fee,'+
                                                           'sum(insured_fee) as sum_insured_fee,'+
                                                           'sum(k_hand_fee) as sum_k_hand_fee,'+
                                                           'sum(manage_fee) as sum_manage_fee,' +
                                                           'sum(from_short_carrying_fee) as sum_from_short_carrying_fee,'+
                                                           'sum(to_short_carrying_fee) as sum_to_short_carrying_fee,'+
                                                           'sum(goods_num) as sum_goods_num,'+
                                                           'sum(1) as sum_bill_count') \
          .where(["bill_date >= ? AND bill_date <= ? AND state not in (?) ",f_date,t_date,["canceled","invalided"]]) \
          .group('from_org_id,pay_type')}

        #月营业额统计,用于统计到货地每月发生的汇总费用
        scope :mth_turnover_by_to_org,lambda {|f_date,t_date| select('to_org_id,'+
                                                           'pay_type,'+
                                                           'sum(carrying_fee) as sum_carrying_fee,'+
                                                           'sum(goods_fee) as sum_goods_fee,'+
                                                           'sum(insured_fee) as sum_insured_fee,'+
                                                           'sum(k_hand_fee) as sum_k_hand_fee,'+
                                                           'sum(manage_fee) as sum_manage_fee,' +
                                                           'sum(from_short_carrying_fee) as sum_from_short_carrying_fee,'+
                                                           'sum(to_short_carrying_fee) as sum_to_short_carrying_fee,'+
                                                           'sum(goods_num) as sum_goods_num,'+
                                                           'sum(1) as sum_bill_count') \
          .where(["bill_date >= ? AND bill_date <= ? AND state not in (?) ",f_date,t_date,["canceled","invalided"]]) \
          .group('to_org_id,pay_type')}



        #今日收货
        scope :today_billed,lambda {|from_org_ids| select('pay_type,sum(carrying_fee) as carrying_fee,sum(goods_fee) as goods_fee,'+
                                                          'sum(insured_fee) as insured_fee,sum(from_short_carrying_fee) as from_short_carrying_fee,'+
                                                          'sum(to_short_carrying_fee) as to_short_carrying_fee,sum(goods_num) as goods_num,'+
                                                          'sum(1) as bill_count') \
          .where(:from_org_id => from_org_ids,:bill_date => Date.today) \
          .where(["state not in (?) ",["canceled","invalided"]]).group(:pay_type)}

        #今日提货
        scope :today_deliveried,lambda {|to_org_ids| select('carrying_bills.type,pay_type,sum(carrying_fee) as carrying_fee,sum(goods_fee)  as goods_fee'+
                                                            ',sum(insured_fee) as insured_fee,sum(from_short_carrying_fee) as from_short_carrying_fee,'+
                                                            'sum(to_short_carrying_fee) as to_short_carrying_fee,sum(goods_num) as goods_num,'+
                                                            'sum(1) as bill_count') \
          .where(:to_org_id => to_org_ids,:state =>:deliveried) \
          .search(:deliver_info_deliver_date_eq => Date.today) \
          .group('carrying_bills.type,pay_type')}

        #今日提款(仅指现金提款)
        scope :today_paid,lambda {|from_org_ids| select('pay_type,sum(carrying_fee) as carrying_fee,sum(insured_fee) as insured_fee,sum(from_short_carrying_fee) as from_short_carrying_fee,sum(to_short_carrying_fee) as to_short_carrying_fee,sum(goods_fee) as goods_fee,sum(goods_num) as goods_num,sum(k_hand_fee) as k_hand_fee,sum(transit_hand_fee) as transit_hand_fee,sum(1) as bill_count').where(:from_org_id => from_org_ids,:state =>:paid).search(:from_customer_id_is_null => 1,:pay_info_bill_date_eq => Date.today).group('pay_type')}
        #最近票据(5张)
        scope :recent_bills,lambda {|from_org_ids| where(:from_org_id => from_org_ids,:completed => false).order("created_at DESC").limit(5)}

        #待提货票据(不包括中转票据)
        scope :ready_delivery,lambda {|to_org_ids| select('sum(1) as bill_count').where(:to_org_id => to_org_ids,:state => :distributed)}
        #待提款票据
        scope :ready_pay,lambda {|from_org_ids| search(:from_customer_id_is_null => 1).where(:from_org_id => from_org_ids,:state => :payment_listed).select('sum(goods_fee) as goods_fee,sum(1) as bill_count')}

        #预付款期初余额统计
        #计算提付运费 货款 保险费
        scope :prepay_entry_beginning_balance,lambda {|to_org_id| select('sum(1) as bill_count,IFNULL(sum(carrying_fee),0) as sum_carrying_fee,' + 
                                                                         'IFNULL(sum(insured_fee),0) as sum_insured_fee,IFNULL(sum(goods_fee),0) as sum_goods_fee,' +
                                                                         'IFNULL(sum(from_short_carrying_fee),0) as sum_from_short_carrying_fee,' +
                                                                         'IFNULL(sum(to_short_carrying_fee),0) as sum_to_short_carrying_fee,' +
                                                                         'IFNULL(sum(manage_fee),0) as sum_manage_fee').where(:to_org_id => to_org_id,
                                                                                                                              :completed => false,
                                                                                                                              :transit_org_id => nil,
                                                                                                                              :type => ["ComputerBill","HandBill","ReturnBill","AutoCalculateComputerBill"],
                                                                                                                              :state => [:shipped,:reached,:distributed,:deliveried,:settlemented])}
        #运单的提付费用汇总
        scope :sum_by_pay_type_th,lambda {select('sum(1) as bill_count,IFNULL(sum(carrying_fee),0) as sum_carrying_fee,' + 
                                                                         'IFNULL(sum(insured_fee),0) as sum_insured_fee,IFNULL(sum(goods_fee),0) as sum_goods_fee,' +
                                                                         'IFNULL(sum(from_short_carrying_fee),0) as sum_from_short_carrying_fee,' +
                                                                         'IFNULL(sum(to_short_carrying_fee),0) as sum_to_short_carrying_fee,' +
                                                                         'IFNULL(sum(manage_fee),0) as sum_manage_fee').where(:completed => false,:pay_type => CarryingBillExtend::PayType::PAY_TYPE_TH)
        }
        #

        #货款收入情况
        scope :sum_goods_fee_in,lambda {|from_org_ids,date_from,date_to| select('from_org_id,sum(goods_fee) as sum_goods_fee_in').where(:from_org_id => from_org_ids,:state => ["refunded_confirmed","payment_listed","paid","posted"],:updated_at => date_from..date_to).group('from_org_id')}
        #货款支出情况
        scope :sum_goods_fee_out,lambda {|from_org_ids,date_from,date_to| select('from_org_id,sum(goods_fee) as sum_goods_fee_out').where(:from_org_id => from_org_ids,:state => ["paid",'posted'] ,:updated_at => date_from..date_to).group('from_org_id')}

        #按照到货地-发货地分组合计
        scope :group_by_to_org_id_and_from_org_id,select('carrying_bills.to_org_id as to_org_id,carrying_bills.from_org_id as from_org_id,sum(carrying_fee) as carrying_fee, 
                                                         sum(insured_fee) as insured_fee,sum(from_short_carrying_fee) as from_short_carrying_fee, 
                                                         sum(to_short_carrying_fee) as to_short_carrying_fee,sum(goods_fee) as goods_fee, 
                                                         sum(goods_num) as goods_num,sum(k_hand_fee) as k_hand_fee, 
                                                         sum(transit_hand_fee) as transit_hand_fee,sum(1) as bill_count').group('to_org_id,from_org_id')
        #按照发货地-到货地分组合计
        scope :group_by_from_org_id_and_to_org_id,select('carrying_bills.from_org_id as from_org_id,carrying_bills.to_org_id as to_org_id,sum(carrying_fee) as carrying_fee, 
                                                         sum(insured_fee) as insured_fee,sum(from_short_carrying_fee) as from_short_carrying_fee, 
                                                         sum(to_short_carrying_fee) as to_short_carrying_fee,sum(goods_fee) as goods_fee, 
                                                         sum(goods_num) as goods_num,sum(k_hand_fee) as k_hand_fee, 
                                                         sum(transit_hand_fee) as transit_hand_fee,sum(1) as bill_count').group('from_org_id,to_org_id')


        scope :with_association,:include => [:from_org,:to_org,:transit_org,:send_list_line,:short_fee_info_lines,:user,:notice_lines]
        #给定机构待报销的运单列表
        #条件: (from_org_id = $org_id AND from_short_carrying_fee > 0 AND from_short_fee_state ='draft') OR (to_org_id = $org_id AND to_short_carrying_fee > 0 AND to_short_fee_state = 'draft')
        scope :bills_with_from_short_carrying_fee,lambda{|org_ids| where("carrying_bills.from_org_id  in (?) AND from_short_carrying_fee > 0 AND from_short_fee_state ='draft'",org_ids)}
        scope :bills_with_to_short_carrying_fee,lambda{|org_ids| where("carrying_bills.to_org_id in (?) AND to_short_carrying_fee > 0 AND to_short_fee_state = 'draft'",org_ids)}

        #分理处货物滞留统计
        #params org_ids 机构id
        #
        scope :bills_in_branch,lambda {|org_id| select("carrying_bills.*, \
                                      SUM(IFNULL(inventory_moves.qty,0))  AS load_num,
                                      carrying_bills.goods_num - SUM(IFNULL(inventory_moves.qty,0)) AS rest_num") \
          .joins("LEFT OUTER JOIN inventory_moves  \
                                             ON carrying_bills.id = inventory_moves.carrying_bill_id \
                                             AND inventory_moves.from_org_id = carrying_bills.from_org_id \
                                             AND inventory_moves.state in ('billed','shipped','reached')") \
        .where(["carrying_bills.bill_date >='2016-08-27' AND carrying_bills.from_org_id = ?",org_id]) \
        .group("carrying_bills.id") \
        .having("rest_num > 0 ") }

        #货场货物滞留统计
        #FIXME 不再使用
=begin
        scope :bills_in_yard, lambda{ |yard_id| select("carrying_bills.*, \
                                    SUM(IFNULL(m1.qty,0))  AS branch_reached_num, \
                                    carrying_bills.goods_num - SUM(IFNULL(m1.qty,0)) AS branch_rest_num, \
                                    SUM(IFNULL(m2.qty,0))  AS load_num, \
                                    SUM(IFNULL(m1.qty,0)) - SUM(IFNULL(m2.qty,0)) AS rest_num") \
                                      .joins("INNER JOIN inventory_moves AS m1  \
                                             ON carrying_bills.id = m1.carrying_bill_id \
                                             AND m1.state = 'reached' \
                                             AND m1.to_org_id =  #{yard_id}") \
                                      .joins("LEFT OUTER JOIN inventory_moves m2 ON m2.carrying_bill_id = carrying_bills.id \
                                             AND m2.state in ('billed','shipped','reached') \
                                             AND m2.from_org_id = #{yard_id}") \
                                      .group("carrying_bills.id") \
                                      .having("rest_num > 0 ")}


        #分理处货物滞留清单
        scope :bills_inventory_report, lambda{ |yard_id| select("carrying_bills.*, \
                                    SUM(IFNULL(m1.qty,0))  AS branch_reached_num, \
                                    carrying_bills.goods_num - SUM(IFNULL(m1.qty,0)) AS branch_rest_num, \
                                    SUM(IFNULL(m2.qty,0))  AS load_num, \
                                    SUM(IFNULL(m1.qty,0)) - SUM(IFNULL(m2.qty,0)) AS rest_num") \
                                      .joins("LEFT OUTER JOIN inventory_moves AS m1  \
                                             ON carrying_bills.id = m1.carrying_bill_id \
                                             AND m1.state = 'reached' \
                                             AND m1.to_org_id =  #{yard_id}") \
                                      .joins("LEFT OUTER JOIN inventory_moves m2 ON m2.carrying_bill_id = carrying_bills.id \
                                             AND m2.state in ('billed','shipped','reached') \
                                             AND m2.from_org_id = #{yard_id}") \
                                      .group("carrying_bills.id")}

=end
        scope :bills_in_yard, lambda{ |yard_id| select("carrying_bills.*, \
                                    SUM(IFNULL(m1.sum_qty,0))  AS branch_reached_num, \
                                    carrying_bills.goods_num - SUM(IFNULL(m1.sum_qty,0)) AS branch_rest_num, \
                                    SUM(IFNULL(m2.sum_qty,0))  AS load_num, \
                                    SUM(IFNULL(m1.sum_qty,0)) - SUM(IFNULL(m2.sum_qty,0)) AS rest_num") \
        .joins("LEFT OUTER JOIN inventory_ins AS m1  \
                                             ON carrying_bills.id = m1.carrying_bill_id \
                                             AND carrying_bills.bill_date >= '2016-08-27' AND m1.org_id =  #{yard_id}") \
        .joins("LEFT OUTER JOIN inventory_outs m2 ON m2.carrying_bill_id = carrying_bills.id \
                                             AND m2.org_id = #{yard_id}") \
        .group("carrying_bills.id").having("rest_num > 0 ")} 
        #与bills_in_yard的唯一区别是显示所有票据信息,不过滤rest_num > 0
        scope :bills_inventory_report, lambda{ |yard_id| select("carrying_bills.*, \
                                    SUM(IFNULL(m1.sum_qty,0))  AS branch_reached_num, \
                                    carrying_bills.goods_num - SUM(IFNULL(m1.sum_qty,0)) AS branch_rest_num, \
                                    SUM(IFNULL(m2.sum_qty,0))  AS load_num, \
                                    SUM(IFNULL(m1.sum_qty,0)) - SUM(IFNULL(m2.sum_qty,0)) AS rest_num") \
        .joins("LEFT OUTER JOIN inventory_ins AS m1  \
                                             ON carrying_bills.id = m1.carrying_bill_id \
                                             AND m1.org_id =  #{yard_id}") \
        .joins("LEFT OUTER JOIN inventory_outs m2 ON m2.carrying_bill_id = carrying_bills.id \
                                             AND m2.org_id = #{yard_id}") \
        .group("carrying_bills.id")}


        #欠款提货清单
        scope :debt_bills,lambda{|org_id,bill_date| select("carrying_bills.*").where("carrying_bills.state = 'distributed' \ 
                                                                                      AND carrying_bills.completed = 0 \ 
                                                                                      AND carrying_bills.type IN ('ComputerBill', 'HandBill', 'ReturnBill', 'AutoCalculateComputerBill', 'InnerTransitBill', 'HandInnerTransitBill') \
                                                                                      AND carrying_bills.to_org_id = #{org_id} \
                                                                                      AND carrying_bills.id NOT IN \
	                                                                                    (SELECT b.carrying_bill_id carrying_bill_id FROM \
		                                                                                      in_stock_bills a,in_stock_bill_lines b \
	                                                                                        WHERE a.id = b.in_stock_bill_id \
	                                                                                        AND a.bill_date = '#{bill_date}' \
	                                                                                        AND a.org_id = #{org_id})"
                                                                                    )
        }

        #返款清单分组统计-按照到货地
        scope :refound_sum,lambda {|refound_ids| select("from_org_id,to_org_id,sum(carrying_fee) AS carrying_fee")
        .where(:refound_id => refound_ids,:pay_type => CarryingBillExtend::PayType::PAY_TYPE_TH).group(:from_org_id,:to_org_id)
        }

        #按照收货人所在区域分组
        scope :deliver_region_bills,lambda {|deliver_region_id| joins("LEFT OUTER JOIN bill_association_objects  \
          ON bill_association_objects.customerable_id = carrying_bills.id  \
          AND bill_association_objects.customerable_type IN ('ComputerBill','HandBill','AutoCalculateComputerBill','ReturnBill') \
          LEFT OUTER JOIN customers ON customers.id = bill_association_objects.to_customer_id \
          AND customers.type IN ('ImportedCustomer') \
          AND customers.deliver_region_id = #{deliver_region_id}")
        }

        #按照已提货状态统计 到货地/运费支付方式／时间段汇总统计运费
        scope :sum_deliveried_bills,lambda {|from_org_ids,to_org_ids,f_date,t_date| select("case when orgs.parent_id IS NULL then carrying_bills.to_org_id else orgs.parent_id end to_org_id, \
        pay_type, \
        sum(carrying_fee) AS carrying_fee, \
        sum(from_short_carrying_fee) AS from_short_carrying_fee, \
        sum(to_short_carrying_fee) AS to_short_carrying_fee")
          .search(
            :from_org_id_in => from_org_ids,
        :to_org_id_in => to_org_ids,
        :deliver_info_deliver_date_gte => f_date,
        :deliver_info_deliver_date_lte => t_date,
        :type_in => ['ComputerBill', 'HandBill', 'ReturnBill', 'AutoCalculateComputerBill', 'TonVolumeBill'],
        #FIXME 20180305 此处状态应包含 提货后的所有状态
        :state_in => ["deliveried","settlemented","refunded","refunded_confirmed","payment_listed","paid","posted"]
        ).joins(:to_org).group("to_org_id,pay_type").order("to_org_id")
        }

        #按照已提货状态统计 发货地货地/运费支付方式／时间段汇总统计运费
         scope :sum_deliveried_bills_by_from_org,lambda {|from_org_ids,to_org_ids,f_date,t_date| select("carrying_bills.from_org_id,pay_type,sum(carrying_fee) AS carrying_fee, \
                                                                                                sum(from_short_carrying_fee) AS from_short_carrying_fee, \
                                                                                                sum(to_short_carrying_fee) AS to_short_carrying_fee")
           .search(
             :from_org_id_in => from_org_ids,
             :deliver_info_deliver_date_gte => f_date,
             :deliver_info_deliver_date_lte => t_date,
             :type_in => ['ComputerBill', 'HandBill', 'ReturnBill', 'AutoCalculateComputerBill', 'TonVolumeBill'],
             :state_in => ["deliveried","settlemented","refunded","refunded_confirmed","payment_listed","paid","posted"]
         ).group("from_org_id,pay_type").order("from_org_id")
         }

        #未提货金额汇总表
        scope :rpt_no_delivery,lambda {select("case when orgs.parent_id IS NULL then carrying_bills.to_org_id else orgs.parent_id end to_org_id,"+
                 "sum(case when pay_type='TH' then carrying_fee else 0 end) as sum_carrying_fee,"+
                 "sum(goods_fee) as sum_goods_fee,"+
                 "sum(case when pay_type='TH' then insured_fee else 0 end) as sum_insured_fee,"+
                 "sum(case when pay_type='TH' then from_short_carrying_fee else 0 end) as sum_from_short_carrying_fee, " +
                 "sum(case when pay_type='TH' then to_short_carrying_fee else 0 end) as sum_to_short_carrying_fee,"+
                 "sum(case when pay_type='TH' then manage_fee else 0 end) as sum_manage_fee,"+
                 "sum(case when pay_type='TH' then from_short_carrying_fee + to_short_carrying_fee + carrying_fee + insured_fee + manage_fee else 0 end) + sum(goods_fee) as sum_th_amount,"  +
                 "sum(goods_num) as sum_goods_num,sum(1) as sum_bill_count")
          .joins(:to_org)
          .where(["carrying_bills.state in ('reached','distributed')"])
          .group('to_org_id')
        }

        #未到货
        #当日以前的在途、已装车、已入库、已开票
        scope :rpt_no_reached,lambda {select("case when orgs.parent_id IS NULL then carrying_bills.to_org_id else orgs.parent_id end to_org_id,"+
                                     "sum(case when pay_type='TH' then carrying_fee else 0 end) as sum_carrying_fee,"+
                                     "sum(goods_fee) as sum_goods_fee,"+
                                     "sum(case when pay_type='TH' then insured_fee else 0 end) as sum_insured_fee,"+
                                     "sum(case when pay_type='TH' then from_short_carrying_fee else 0 end) as sum_from_short_carrying_fee, " +
                                     "sum(case when pay_type='TH' then to_short_carrying_fee else 0 end) as sum_to_short_carrying_fee,"+
                                     "sum(case when pay_type='TH' then manage_fee else 0 end) as sum_manage_fee,"+
                                     "sum(case when pay_type='TH' then from_short_carrying_fee + to_short_carrying_fee + carrying_fee + insured_fee + manage_fee else 0 end) + sum(goods_fee) as sum_th_amount,"  +
                                     "sum(goods_num) as sum_goods_num,sum(1) as sum_bill_count")
          .joins(:to_org)
          .where(["carrying_bills.state in ('billed','sorted_in','loaded_in','loaded','shipped')"])
          .search(:bill_date_lt => Date.today)
          .group('to_org_id')
        }

        #未返款
        #已提货、已结算票据
        scope :rpt_no_refunded,lambda {select("case when orgs.parent_id IS NULL then carrying_bills.to_org_id else orgs.parent_id end to_org_id,"+
                                      "sum(case when pay_type='TH' then carrying_fee else 0 end) as sum_carrying_fee,"+
                                      "sum(goods_fee) as sum_goods_fee,"+
                                      "sum(case when pay_type='TH' then insured_fee else 0 end) as sum_insured_fee,"+
                                      "sum(case when pay_type='TH' then from_short_carrying_fee else 0 end) as sum_from_short_carrying_fee, " +
                                      "sum(case when pay_type='TH' then to_short_carrying_fee else 0 end) as sum_to_short_carrying_fee,"+
                                      "sum(case when pay_type='TH' then manage_fee else 0 end) as sum_manage_fee,"+
                                      "sum(case when pay_type='TH' then from_short_carrying_fee + to_short_carrying_fee + carrying_fee + insured_fee + manage_fee else 0 end) + sum(goods_fee) as sum_th_amount,"  +
                                      "sum(goods_num) as sum_goods_num,sum(1) as sum_bill_count")
          .joins(:to_org)
          .where(["carrying_bills.state in ('deliveried','settlemented')"])
          .group('to_org_id')
        }

        #已返款
        scope :rpt_refunded,lambda {select("case when orgs.parent_id IS NULL then carrying_bills.to_org_id else orgs.parent_id end to_org_id,"+
                                      "sum(case when pay_type='TH' then carrying_fee else 0 end) as sum_carrying_fee,"+
                                      "sum(goods_fee) as sum_goods_fee,"+
                                      "sum(case when pay_type='TH' then insured_fee else 0 end) as sum_insured_fee,"+
                                      "sum(case when pay_type='TH' then from_short_carrying_fee else 0 end) as sum_from_short_carrying_fee, " +
                                      "sum(case when pay_type='TH' then to_short_carrying_fee else 0 end) as sum_to_short_carrying_fee,"+
                                      "sum(case when pay_type='TH' then manage_fee else 0 end) as sum_manage_fee,"+
                                      "sum(case when pay_type='TH' then from_short_carrying_fee + to_short_carrying_fee + carrying_fee + insured_fee + manage_fee else 0 end) + sum(goods_fee) as sum_th_amount,"  +
                                      "sum(goods_num) as sum_goods_num,sum(1) as sum_bill_count")
          .joins(:to_org)
          .where(["carrying_bills.state in ('refunded','refunded_confirmed')"])
          .group('to_org_id')
        }



        scope :rpt_no_reached,lambda {select("case when orgs.parent_id IS NULL then carrying_bills.to_org_id else orgs.parent_id end to_org_id,"+
                                     "sum(case when pay_type='TH' then carrying_fee else 0 end) as sum_carrying_fee,"+
                                     "sum(goods_fee) as sum_goods_fee,"+
                                     "sum(case when pay_type='TH' then insured_fee else 0 end) as sum_insured_fee,"+
                                     "sum(case when pay_type='TH' then from_short_carrying_fee else 0 end) as sum_from_short_carrying_fee, " +
                                     "sum(case when pay_type='TH' then to_short_carrying_fee else 0 end) as sum_to_short_carrying_fee,"+
                                     "sum(case when pay_type='TH' then manage_fee else 0 end) as sum_manage_fee,"+
                                     "sum(case when pay_type='TH' then from_short_carrying_fee + to_short_carrying_fee + carrying_fee + insured_fee + manage_fee else 0 end) + sum(goods_fee) as sum_th_amount,"  +
                                     "sum(goods_num) as sum_goods_num,sum(1) as sum_bill_count")
          .joins(:to_org)
          .where(["carrying_bills.state in ('billed','sorted_in','loaded_in','loaded','shipped')"])
          .search(:bill_date_lt => Date.today)
          .group('carrying_bills.to_org_id')
        }



        #当日收货
        scope :rpt_today_bills,lambda {select("case when orgs.parent_id IS NULL then carrying_bills.to_org_id else orgs.parent_id end to_org_id,"+
                                      "sum(case when pay_type='TH' then carrying_fee else 0 end) as sum_carrying_fee,"+
                                      "sum(goods_fee) as sum_goods_fee,"+
                                      "sum(case when pay_type='TH' then insured_fee else 0 end) as sum_insured_fee,"+
                                      "sum(case when pay_type='TH' then from_short_carrying_fee else 0 end) as sum_from_short_carrying_fee, " +
                                      "sum(case when pay_type='TH' then to_short_carrying_fee else 0 end) as sum_to_short_carrying_fee,"+
                                      "sum(case when pay_type='TH' then manage_fee else 0 end) as sum_manage_fee,"+
                                      "sum(case when pay_type='TH' then from_short_carrying_fee + to_short_carrying_fee + carrying_fee + insured_fee + manage_fee else 0 end) + sum(goods_fee) as sum_th_amount,"  +
                                      "sum(goods_num) as sum_goods_num,sum(1) as sum_bill_count")
          .joins(:to_org)
          .where(["carrying_bills.state not in ('canceled','invalided')"])
          .search(:bill_date_eq => Date.today)
          .group('to_org_id')
        }

        #内部中转当日返款单金额汇总
        scope :rpt_inner_today_refund,lambda {select("case when orgs.parent_id IS NULL then carrying_bills.to_org_id else orgs.parent_id end to_org_id,"+
                                      "sum(case when pay_type='TH' then carrying_fee else 0 end) as sum_carrying_fee,"+
                                      "sum(goods_fee) as sum_goods_fee,"+
                                      "sum(case when pay_type='TH' then insured_fee else 0 end) as sum_insured_fee,"+
                                      "sum(case when pay_type='TH' then from_short_carrying_fee else 0 end) as sum_from_short_carrying_fee, " +
                                      "sum(case when pay_type='TH' then to_short_carrying_fee else 0 end) as sum_to_short_carrying_fee,"+
                                      "sum(case when pay_type='TH' then manage_fee else 0 end) as sum_manage_fee,"+
                                      "sum(case when pay_type='TH' then from_short_carrying_fee + to_short_carrying_fee + carrying_fee + insured_fee + manage_fee else 0 end) + sum(goods_fee) as sum_th_amount,"  +
                                      "sum(goods_num) as sum_goods_num,sum(1) as sum_bill_count")
          .joins(:to_org)
          .where("carrying_bills.state in ('refunded','transit_refunded_confirmed','refunded_confirmed')")
          .search(:type_in => ["InnerTransitBill","HandInnerTransitBill","InnerTransitReturnBill"],:refound_bill_date_eq => Date.today)
          .group('carrying_bills.to_org_id')
        }

        #内部中转未返款金额汇总
        scope :rpt_inner_no_refunded,lambda {select("case when orgs.parent_id IS NULL then carrying_bills.to_org_id else orgs.parent_id end to_org_id,"+
                                            "sum(case when pay_type='TH' then carrying_fee else 0 end) as sum_carrying_fee,"+
                                            "sum(goods_fee) as sum_goods_fee,"+
                                            "sum(case when pay_type='TH' then insured_fee else 0 end) as sum_insured_fee,"+
                                            "sum(case when pay_type='TH' then from_short_carrying_fee else 0 end) as sum_from_short_carrying_fee, " +
                                            "sum(case when pay_type='TH' then to_short_carrying_fee else 0 end) as sum_to_short_carrying_fee,"+
                                            "sum(case when pay_type='TH' then manage_fee else 0 end) as sum_manage_fee,"+
                                            "sum(case when pay_type='TH' then from_short_carrying_fee + to_short_carrying_fee + carrying_fee + insured_fee + manage_fee else 0 end) + sum(goods_fee) as sum_th_amount,"  +
                                            "sum(goods_num) as sum_goods_num,sum(1) as sum_bill_count")
          .joins(:to_org)
          .where("carrying_bills.state in ('deliveried','settlemented')")
          .search(:type_in => ["InnerTransitBill","HandInnerTransitBill","InnerTransitReturnBill"])
          .group('carrying_bills.to_org_id')
        }

        #内部中转已返款
        scope :rpt_inner_refunded,lambda {select("case when orgs.parent_id IS NULL then carrying_bills.to_org_id else orgs.parent_id end to_org_id,"+
                                            "sum(case when pay_type='TH' then carrying_fee else 0 end) as sum_carrying_fee,"+
                                            "sum(goods_fee) as sum_goods_fee,"+
                                            "sum(case when pay_type='TH' then insured_fee else 0 end) as sum_insured_fee,"+
                                            "sum(case when pay_type='TH' then from_short_carrying_fee else 0 end) as sum_from_short_carrying_fee, " +
                                            "sum(case when pay_type='TH' then to_short_carrying_fee else 0 end) as sum_to_short_carrying_fee,"+
                                            "sum(case when pay_type='TH' then manage_fee else 0 end) as sum_manage_fee,"+
                                            "sum(case when pay_type='TH' then from_short_carrying_fee + to_short_carrying_fee + carrying_fee + insured_fee + manage_fee else 0 end) + sum(goods_fee) as sum_th_amount,"  +
                                            "sum(goods_num) as sum_goods_num,sum(1) as sum_bill_count")
          .joins(:to_org)
          .where("carrying_bills.state in ('refunded','transit_refunded_confirmed')")
          .search(:type_in => ["InnerTransitBill","HandInnerTransitBill","InnerTransitReturnBill"])
          .group('carrying_bills.to_org_id')
        }

        #已提货票据
        scope :after_deliveried,lambda{ where("carrying_bills.state in  ('deliveried','settlemented','refunded','transit_refunded_confirmed','refunded_confirmed','payment_listed','paid','posted')")}

        #未提货票据
        scope :before_deliveried,lambda{ where("carrying_bills.state in  ('billed','sorted_in','loaded_in','loaded','shipped','transit_reached','transit_shipped','reached','distributed','transited')")}

        #始发货可分成票据,不含月结及回执付票据
        scope :divide_bills_from,lambda {|from_org_id,refund_date_from,refund_date_to| select("carrying_bills.from_org_id,"+
                                            "sum(case when pay_type='RE' then 0 else carrying_fee end) as sum_carrying_fee,"+
                                            "sum(goods_fee) as sum_goods_fee,"+
                                            "sum(case when pay_type='RE' then 0 else insured_fee  end) as sum_insured_fee,"+
                                            "sum(case when pay_type='RE' then 0 else from_short_carrying_fee end) as sum_from_short_carrying_fee, " +
                                            "sum(case when pay_type='RE' then 0 else  to_short_carrying_fee end) as sum_to_short_carrying_fee,"+
                                            "sum(case when pay_type='RE' then 0 else manage_fee end) as sum_manage_fee,"+
                                            "sum(case when pay_type='RE' then 0 else from_short_carrying_fee + to_short_carrying_fee + carrying_fee + insured_fee + manage_fee end) + sum(goods_fee) as sum_th_amount,"  +
                                            "sum(goods_num) as sum_goods_num,sum(1) as sum_bill_count")
          .joins(:refound)
          .where("carrying_bills.state in ('refunded','refunded_confirmed','payment_listed','paid','posted')")
          .where(['carrying_bills.from_org_id = ? AND refounds.bill_date >= ? AND refounds.bill_date <= ?',from_org_id,refund_date_from,refund_date_to])
          .search(:type_in => ["ComputerBill","HandBill"])
          .group('carrying_bills.from_org_id')
        }

        #始发货可分成票据,只包含月结及回执付票据
        scope :divide_bills_from_re,lambda {|from_org_id,customer_payment_date_from,customer_payment_date_to| select("carrying_bills.from_org_id,"+
                                            "sum(carrying_fee) as sum_carrying_fee,"+
                                            "sum(goods_fee) as sum_goods_fee,"+
                                            "sum(insured_fee ) as sum_insured_fee,"+
                                            "sum(from_short_carrying_fee ) as sum_from_short_carrying_fee, " +
                                            "sum(to_short_carrying_fee ) as sum_to_short_carrying_fee,"+
                                            "sum(manage_fee ) as sum_manage_fee,"+
                                            "sum(from_short_carrying_fee + to_short_carrying_fee + carrying_fee + insured_fee + manage_fee) + sum(goods_fee) as sum_th_amount,"  +
                                            "sum(goods_num) as sum_goods_num,sum(1) as sum_bill_count")
          .joins(:customer_payment_info_line)
          .where("carrying_bills.state in ('refunded','refunded_confirmed','payment_listed','paid','posted')")
          .where("carrying_bills.additional_state in ('customer_paid')")
          .where(['carrying_bills.from_org_id = ? ',from_org_id])
          .where(:type => ["ComputerBill","HandBill"])
          .search(:customer_payment_info_line_customer_payment_info_bill_date_gte => customer_payment_date_from,
                  :customer_payment_info_line_customer_payment_info_bill_date_lte => customer_payment_date_to)
          .group('carrying_bills.from_org_id')
        }

        #返程货可分成票据,不含月结及回执付票据
        scope :divide_bills_to,lambda {|to_org_id,refund_date_from,refund_date_to| select("carrying_bills.from_org_id,"+
                                            "sum(case when pay_type='RE' then 0 else carrying_fee end) as sum_carrying_fee,"+
                                            "sum(goods_fee) as sum_goods_fee,"+
                                            "sum(case when pay_type='RE' then 0 else insured_fee  end) as sum_insured_fee,"+
                                            "sum(case when pay_type='RE' then 0 else from_short_carrying_fee end) as sum_from_short_carrying_fee, " +
                                            "sum(case when pay_type='RE' then 0 else  to_short_carrying_fee end) as sum_to_short_carrying_fee,"+
                                            "sum(case when pay_type='RE' then 0 else manage_fee end) as sum_manage_fee,"+
                                            "sum(case when pay_type='RE' then 0 else from_short_carrying_fee + to_short_carrying_fee + carrying_fee + insured_fee + manage_fee end) + sum(goods_fee) as sum_th_amount,"  +
                                            "sum(goods_num) as sum_goods_num,sum(1) as sum_bill_count")
          .joins(:refound)
          .where("carrying_bills.state in ('refunded','refunded_confirmed','payment_listed','paid','posted')")
          .where(['carrying_bills.to_org_id = ? AND refounds.bill_date >= ? AND refounds.bill_date <= ?',to_org_id,refund_date_from,refund_date_to])
          .search(:type_in => ["ComputerBill","HandBill"])
          .group('carrying_bills.to_org_id')
        }

        #始发货可分成票据,只包含月结及回执付票据
        scope :divide_bills_to_re,lambda {|to_org_id,customer_payment_date_from,customer_payment_date_to| select("carrying_bills.from_org_id,"+
                                            "sum(carrying_fee) as sum_carrying_fee,"+
                                            "sum(goods_fee) as sum_goods_fee,"+
                                            "sum(insured_fee ) as sum_insured_fee,"+
                                            "sum(from_short_carrying_fee ) as sum_from_short_carrying_fee, " +
                                            "sum(to_short_carrying_fee ) as sum_to_short_carrying_fee,"+
                                            "sum(manage_fee ) as sum_manage_fee,"+
                                            "sum(from_short_carrying_fee + to_short_carrying_fee + carrying_fee + insured_fee + manage_fee) + sum(goods_fee) as sum_th_amount,"  +
                                            "sum(goods_num) as sum_goods_num,sum(1) as sum_bill_count")
          .joins(:customer_payment_info_line)
          .where("carrying_bills.state in ('refunded','refunded_confirmed','payment_listed','paid','posted')")
          .where("carrying_bills.additional_state in ('customer_paid')")
          .where(['carrying_bills.to_org_id = ? ',to_org_id])
          .where(:type => ["ComputerBill","HandBill"])
          .search(:customer_payment_info_line_customer_payment_info_bill_date_gte => customer_payment_date_from,
                  :customer_payment_info_line_customer_payment_info_bill_date_lte => customer_payment_date_to)
          .group('carrying_bills.to_org_id')
        }

        #内部中转可分成票据,不含回执付及月结票据
        scope :divide_inner_transit_bills_from,lambda {|from_org_id,refund_date_from,refund_date_to| select("carrying_bills.from_org_id,"+
                                            "sum(case when pay_type='RE' then 0 else carrying_fee end) as sum_carrying_fee,"+
                                            "sum(goods_fee) as sum_goods_fee,"+
                                            "sum(case when pay_type='RE' then 0 else insured_fee  end) as sum_insured_fee,"+
                                            "sum(case when pay_type='RE' then 0 else from_short_carrying_fee end) as sum_from_short_carrying_fee, " +
                                            "sum(case when pay_type='RE' then 0 else  to_short_carrying_fee end) as sum_to_short_carrying_fee,"+
                                            "sum(case when pay_type='RE' then 0 else manage_fee end) as sum_manage_fee,"+
                                            "sum(case when pay_type='RE' then 0 else from_short_carrying_fee + to_short_carrying_fee + carrying_fee + insured_fee + manage_fee end) + sum(goods_fee) as sum_th_amount,"  +
                                            "sum(goods_num) as sum_goods_num,sum(1) as sum_bill_count")
          .joins(:refound)
          .where("carrying_bills.state in ('refunded','transit_refunded_confirmed','refunded_confirmed','payment_listed','paid','posted')")
          .where(['carrying_bills.from_org_id = ? AND refounds.bill_date >= ? AND refounds.bill_date <= ?',from_org_id,refund_date_from,refund_date_to])
          .search(:type_in => ["InnerTransitBill","HandInnerTransitBill","InnerTransitReturnBill"])
          .group('carrying_bills.from_org_id')
        }

        #内部中转可分成票据,只包含月结及回执付票据
        scope :divide_inner_transit_bills_from_re,lambda {|from_org_id,customer_payment_date_from,customer_payment_date_to| select("carrying_bills.from_org_id,"+
                                            "sum(carrying_fee) as sum_carrying_fee,"+
                                            "sum(goods_fee) as sum_goods_fee,"+
                                            "sum(insured_fee ) as sum_insured_fee,"+
                                            "sum(from_short_carrying_fee ) as sum_from_short_carrying_fee, " +
                                            "sum(to_short_carrying_fee ) as sum_to_short_carrying_fee,"+
                                            "sum(manage_fee ) as sum_manage_fee,"+
                                            "sum(from_short_carrying_fee + to_short_carrying_fee + carrying_fee + insured_fee + manage_fee) + sum(goods_fee) as sum_th_amount,"  +
                                            "sum(goods_num) as sum_goods_num,sum(1) as sum_bill_count")
          .joins(:customer_payment_info_line)
          .where("carrying_bills.state in ('refunded','transit_refunded_confirmed','refunded_confirmed','payment_listed','paid','posted')")
          .where("carrying_bills.additional_state in ('customer_paid')")
          .where(['carrying_bills.from_org_id = ? ',from_org_id])
          .where(:type => ["InnerTransitBill","HandInnerTransitBill","InnerTransitReturnBill"])
          .search(:customer_payment_info_line_customer_payment_info_bill_date_gte => customer_payment_date_from,
                  :customer_payment_info_line_customer_payment_info_bill_date_lte => customer_payment_date_to)
          .group('carrying_bills.from_org_id')
        }
        #内部中转可分成票据,不含回执付及月结票据
        scope :divide_inner_transit_bills_to,lambda {|to_org_id,refund_date_from,refund_date_to| select("carrying_bills.from_org_id,"+
                                            "sum(case when pay_type='RE' then 0 else carrying_fee end) as sum_carrying_fee,"+
                                            "sum(goods_fee) as sum_goods_fee,"+
                                            "sum(case when pay_type='RE' then 0 else insured_fee  end) as sum_insured_fee,"+
                                            "sum(case when pay_type='RE' then 0 else from_short_carrying_fee end) as sum_from_short_carrying_fee, " +
                                            "sum(case when pay_type='RE' then 0 else  to_short_carrying_fee end) as sum_to_short_carrying_fee,"+
                                            "sum(case when pay_type='RE' then 0 else manage_fee end) as sum_manage_fee,"+
                                            "sum(case when pay_type='RE' then 0 else from_short_carrying_fee + to_short_carrying_fee + carrying_fee + insured_fee + manage_fee end) + sum(goods_fee) as sum_th_amount,"  +
                                            "sum(goods_num) as sum_goods_num,sum(1) as sum_bill_count")
          .joins(:refound)
          .where("carrying_bills.state in ('refunded','transit_refunded_confirmed','refunded_confirmed','payment_listed','paid','posted')")
          .where(['carrying_bills.to_org_id = ? AND refounds.bill_date >= ? AND refounds.bill_date <= ?',to_org_id,refund_date_from,refund_date_to])
          .search(:type_in => ["InnerTransitBill","HandInnerTransitBill","InnerTransitReturnBill"])
          .group('carrying_bills.to_org_id')
        }

        #内部中转可分成票据,只包含月结及回执付票据
        scope :divide_inner_transit_bills_to_re,lambda {|to_org_id,customer_payment_date_from,customer_payment_date_to| select("carrying_bills.from_org_id,"+
                                            "sum(carrying_fee) as sum_carrying_fee,"+
                                            "sum(goods_fee) as sum_goods_fee,"+
                                            "sum(insured_fee ) as sum_insured_fee,"+
                                            "sum(from_short_carrying_fee ) as sum_from_short_carrying_fee, " +
                                            "sum(to_short_carrying_fee ) as sum_to_short_carrying_fee,"+
                                            "sum(manage_fee ) as sum_manage_fee,"+
                                            "sum(from_short_carrying_fee + to_short_carrying_fee + carrying_fee + insured_fee + manage_fee) + sum(goods_fee) as sum_th_amount,"  +
                                            "sum(goods_num) as sum_goods_num,sum(1) as sum_bill_count")
          .joins(:customer_payment_info_line)
          .where("carrying_bills.state in ('refunded','transit_refunded_confirmed','refunded_confirmed','payment_listed','paid','posted')")
          .where("carrying_bills.additional_state in ('customer_paid')")
          .where(['carrying_bills.to_org_id = ? ',to_org_id])
          .where(:type => ["InnerTransitBill","HandInnerTransitBill","InnerTransitReturnBill"])
          .search(:customer_payment_info_line_customer_payment_info_bill_date_gte => customer_payment_date_from,
                  :customer_payment_info_line_customer_payment_info_bill_date_lte => customer_payment_date_to)
          .group('carrying_bills.to_org_id')
        }

        #外部中转可分成票据
        scope :divide_outter_transit_bills_from,lambda {|from_org_id,refund_date_from,refund_date_to| select("carrying_bills.from_org_id,"+
                                            "sum(case when pay_type='RE' then 0 else carrying_fee end) as sum_carrying_fee,"+
                                            "sum(goods_fee) as sum_goods_fee,"+
                                            "sum(case when pay_type='RE' then 0 else insured_fee  end) as sum_insured_fee,"+
                                            "sum(case when pay_type='RE' then 0 else from_short_carrying_fee end) as sum_from_short_carrying_fee, " +
                                            "sum(case when pay_type='RE' then 0 else  to_short_carrying_fee end) as sum_to_short_carrying_fee,"+
                                            "sum(case when pay_type='RE' then 0 else manage_fee end) as sum_manage_fee,"+
                                            "sum(case when pay_type='RE' then 0 else from_short_carrying_fee + to_short_carrying_fee + carrying_fee + insured_fee + manage_fee end) + sum(goods_fee) as sum_th_amount,"  +
                                            "sum(goods_num) as sum_goods_num,sum(1) as sum_bill_count")
          .joins(:refound)
          .where("carrying_bills.state in ('refunded','refunded_confirmed','payment_listed','paid','posted')")
          .where(['carrying_bills.from_org_id = ? AND refounds.bill_date >= ? AND refounds.bill_date <= ?',from_org_id,refund_date_from,refund_date_to])
          .search(:type_in => ["TransitBill","HandTransitBill","OutterTransitReturnBill"])
          .group('carrying_bills.from_org_id')
        }



        #便于在前端页面可以使用
        search_methods :bills_with_from_short_carrying_fee,:bills_with_to_short_carrying_fee, \
          :bills_in_branch,:bills_in_yard,:bills_inventory_report,:deliver_region_bills,:after_deliveried,:before_deliveried
      end
    end
    #class methods
    module ClassMethods ; end
  end
end
