# -*- encoding : utf-8 -*-
# 定义运单state_machine相关方法
module CarryingBillExtend
  module StateMachine
    def self.included(base)
      base.class_eval do
        #定义state_machine
        #已开票
        #已装车
        #已发出
        #已到货
        #已分发(分货处理)
        #已中转(针对中转票据)
        #已提货
        #已日结(结算员已交款)
        #已返款
        #已到帐
        #已提款
        #已退货
        state_machine :initial => :billed do
          #运单处理完成后,设置completed标志
          #存在以下几种情况；
          #1 现金付回执付运单,没有代收货款,提货后,运单已经完成
          #2 现金提款运单,提款日接后(posted),运单完成
          #3 转账提款运单,提款后(paid),运单完成
          #4 运单退货后,自动完成
          #5 退货单返款清单确认后,自动完成
          #在这几种情况下,自动设置completed标志

          after_transition :on => :standard_process,:deliveried => :settlemented,:do => :set_completed_settlemented
          after_transition :on => :standard_process,:paid => :posted,:do => :set_completed_posted
          after_transition :on => :standard_process,:payment_listed => :paid,:do => :set_completed_paid

          before_transition :on => :return,any => :returned,:do => :set_return_flag
          after_transition :on => :return,any => :returned,:do => :set_completed_returned

          after_transition :on => :standard_process,:refunded => :refunded_confirmed,:do => :set_completed_refunded_confirmed

          #正常运单处理流程(包括机打运单/手工运单/退货单据)
          event :standard_process do
            #:short_list_loaded 短驳已装车,:short_list_shipped 短驳已发货,:short_list_reached 短驳已到达
            transition [:billed,:short_list_loaded,:short_list_shipped,:short_list_reached,:sorted_in,:loaded_in] => :loaded,
              :loaded => :shipped,                      #发货
              :deliveried => :settlemented,             #日结清单
              :settlemented => :refunded,               #返款
              :refunded_confirmed => :payment_listed,   #支付清单
              :payment_listed => :paid,                 #货款已支付
              :paid => :posted #过帐结束

            #非内部中转运单,有发货-收货处理
            transition :shipped => :reached,:refunded => :refunded_confirmed,:if => lambda {|bill| not ['InnerTransitBill','HandInnerTransitBill'].include?(bill.type)}

            #普通运单到货后有分发操作,外部中转运单不存在分发操作
            transition :reached => :distributed,:distributed => :deliveried,:if => lambda {|bill| not ['TransitBill','HandTransitBill','OutterTransitReturnBill'].include?(bill.type)}

            #外部中转运单处理流程
            transition :reached => :transited,:transited => :deliveried,:if => lambda {|bill| ['TransitBill','HandTransitBill'].include?(bill.type)}

            #外部中转退货单处理流程
            transition :reached => :deliveried,:if => lambda {|bill| ['OutterTransitReturnBill'].include?(bill.type)}

            #内部中转运单
            #内部中转退货运单
            #内部中转票据需要中转地进行确认处理
            transition :shipped => :transit_reached,
              #内部中转装卸组卸车入库 -> 装车出库
              :inner_transit_loaded_in => :inner_transit_loaded_out,
              #发车
              [:transit_reached,:inner_transit_loaded_out] => :transit_shipped,
              :transit_shipped => :reached,:refunded => :transit_refunded_confirmed,
              :transit_refunded_confirmed => :refunded_confirmed,
              :if => lambda {|bill|  ['InnerTransitBill','HandInnerTransitBill','InnerTransitReturnBill'].include?(bill.type)}
          end

          #退货单处理流程
          #退货处理中,根据当前票据状态产生退货票据
          #after_transition :on => :return,[:reached,:distributed] => :returned,:do => :generate_return_bill
          event :return do
            #货物已发出,进行退货操作,会自动生成一张相反的单据
            transition [:reached,:distributed,:transited] => :returned
          end
          #运单重置处理
          before_transition :on => :reset,any => :billed,:do => :set_reset_flag
          after_transition :on => :reset,any => :billed,:do => :reset_bill
          event :reset do
            transition any => :billed
          end
          #中转部结算交款后,直接进行交款确认,无需再进行返款
          event :direct_refunded_confirmed do
            transition :settlemented => :refunded_confirmed
          end

          #运单作废操作
          after_transition :on => :invalidate,:billed => :invalided,:do => :set_completed_invalid
          event :invalidate do
            transition :billed => :invalided
          end

          #运单注销处理

          before_transition :on => :cancel,[:reached,:distributed] => :canceled,:do => :set_cancel_flag
          after_transition :on => :cancel,[:reached,:distributed] => :canceled,:do => :set_completed_cancel
          event :cancel do
            transition [:reached,:distributed] => :canceled
          end


          #根据运单状态进行验证操作
          state :shipped,:reached do
            validates_presence_of :load_list_id
          end
          state :transited do
            validates_presence_of :transit_info_id
          end

          state :distributed do
            validates_presence_of :distribution_list_id
          end
          state :deliveried do
            validates_presence_of :deliver_info_id, :unless => :transit_bill?
          end
          state :deliveried do
            validates_presence_of :transit_deliver_info_id, :if => :transit_bill?
          end
          #
          state :settlemented do
            validates_presence_of :settlement_id
          end
          state :refunded,:refunded_confirmed do
            validates_presence_of :refound_id
          end
          state :payment_listed do
            validates_presence_of :payment_list_id
          end
          state :paid do
            validates_presence_of :pay_info_id
          end
          state :posted do
            validates_presence_of :post_info_id
          end
        end

        #短途运费状态声明
        state_machine :from_short_fee_state,:initial => :draft,:namespace => :from_short_fee do
          #发货地短途运费核销
          event :write_off  do
            transition :draft => :saved,:saved => :offed
          end
        end
        #短途运费状态声明
        state_machine :to_short_fee_state,:initial => :draft,:namespace => :to_short_fee do
          #发货地短途运费核销
          event :write_off  do
            transition :draft => :saved,:saved => :offed
          end
        end

        #附加状态声明,用于处理主状态之外的状态处理
        state_machine :additional_state,:initial => :draft,:namespace => :additional_state do
          #暂扣
          event :detain do
            transition :draft => :detained
          end
          #解除暂扣
          event :undetain do
            transition :detained => :draft
          end

          #挂失
          event :report_loss do
            transition :draft => :lossed
          end
          #月结/回执付-客户付款
          event :customer_payment_month_and_re do
            transition :draft => :customer_paid
          end
        end
      end
    end

    private
    #设置重置标志
    def set_reset_flag
      #只在在途、到货、分货、提货、日结、状态下记录reset
      if ['shipped','reached','distributed','deliveried','settlemented'].include?(state)
        reset_goods_info = goods_info.to_s + '#reset'
        self.update_attributes(:goods_info => reset_goods_info)
      end
    end
    #重置票据
    def reset_bill
      self.update_attributes(:load_list_id => nil,:distribution_list_id => nil,:deliver_info_id => nil,:settlement_id => nil,:refound_id => nil,:payment_list_id => nil,:pay_info_id => nil,:post_info_id => nil,:transit_info_id => nil,:short_list_id => nil,:completed => false)
    end

    #根据运单不同情况设置completed标志
    #现金付/回执付/无代收货款,自动置结束标记
    def set_completed_settlemented
      self.update_attributes(:completed => true) if [PayType::PAY_TYPE_RETURN,PayType::PAY_TYPE_CASH].include?(self.pay_type) and self.goods_fee == 0
    end
    #现金提款
    def set_completed_posted
      self.update_attributes(:completed => true) if self.goods_fee_cash?
    end
    #转账提款
    def set_completed_paid
      self.update_attributes(:completed => true) unless self.goods_fee_cash?
    end

    #设置退货标志
    def set_return_flag
      #只在到货、分货、状态下记录return
      if ['reached','distributed'].include?(state)
        return_goods_info = goods_info.to_s + '#return'
        self.update_attributes(:goods_info => return_goods_info)
      end
    end

    #退货后,原始单据直接标志为完成
    def set_completed_returned
      self.update_attributes(:completed => true)
    end
    #提货付运费且货款为0,收款清单确认后,自动完成
    def set_completed_refunded_confirmed
      self.update_attributes(:completed => true) if self.pay_type.eql? PayType::PAY_TYPE_TH and self.goods_fee == 0
    end
    #运单作废后,设标志为完成
    def set_completed_invalid
      self.update_attributes(:completed => true)
    end

    #设置注销标志
    def set_cancel_flag
      cancel_goods_info = goods_info.to_s + '#cancel'
      self.update_attributes(:goods_info => cancel_goods_info)
    end

    #运单注销后,设标志为完成
    def set_completed_cancel
      self.update_attributes(:completed => true)
    end
  end
end
