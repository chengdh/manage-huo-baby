# -*- encoding : utf-8 -*-
# 付款方式定义
module CarryingBillExtend
  module PayType
    PAY_TYPE_CASH = "CA"    #现金付
    PAY_TYPE_TH = "TH"      #提货付
    PAY_TYPE_RETURN = "RE"  #回执付
    PAY_TYPE_K_GOODSFEE = "KG"  #自货款扣除
    #付款方式描述
    def self.pay_types
      ret = ActiveSupport::OrderedHash.new
      ret["提货付"] = PAY_TYPE_TH
      ret["现金付"] = PAY_TYPE_CASH
      # ret["回执付"] = PAY_TYPE_RETURN
      # 取消回执付，变为月结
      ret["月结"] = PAY_TYPE_RETURN
      ret["货款扣运费"] = PAY_TYPE_K_GOODSFEE
      ret
    end
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      #为保持兼容性,在carrying_bill类中也提供了pay_types方式
      def pay_types
        ret = PayType.pay_types.clone
        ret.delete('月结')
        ret.delete('货款扣运费')
        ret
      end

      def pay_types_for_search
        ret = PayType.pay_types.clone
        ret.delete('货款扣运费')
        ret
      end
    end
  end
end
