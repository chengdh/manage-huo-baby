module CalculateHandfee
  module ClassMethods
    #得到默认的手续费设置
    #客户需求中
    #< 1000 1元
    #1000 ~ 2000 2元
    #2000 ~ 3000 3元
    def default_hand_fee(goods_fee)
      hand_fee = goods_fee * 0.001
      #如果设置了手续费比例,但是未设置发货地和到达地,也视为默认设置
      default_config_cash = self.find_by_org_id_and_to_org_id_and_is_active(nil,nil,true)
      hand_fee = default_config_cash.rate*goods_fee if default_config_cash
      hand_fee
    end
    #根据设置计算手续费
    def cal_hand_fee(args={:goods_fee => 0,:from_org_id => nil,:to_org_id => nil})
      goods_fee = args.delete(:goods_fee) {|gf| 0 }
      from_org_id = args.delete(:from_org_id)
      to_org_id = args.delete(:to_org_id)
      config = self.find_by_org_id_and_to_org_id_and_is_active(from_org_id,to_org_id,true)
      ret = default_hand_fee(goods_fee)
      ret = config.rate*goods_fee if config
      #判断手续费是否封顶
      max_hand_fee = IlConfig.max_hand_fee.to_i
      ret = max_hand_fee if max_hand_fee > 0 and ret > max_hand_fee
      ret.ceil
    end
  end
  def self.included(receiver)
    receiver.extend ClassMethods
  end
end
