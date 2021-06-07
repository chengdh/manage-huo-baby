# -*- encoding : utf-8 -*-
module ImportedCustomersHelper
  def customer_types_for_select
    [["有卡",false],["无卡",true]]
  end

  #客户状态说明
  def imported_customer_state_des(state)
    ret = ""
    ret = "&#8593;" if state.eql?(ImportedCustomer::STATE_UP_LEVEL)
    ret = "&#8595;" if state.eql?(ImportedCustomer::STATE_DOWN_LEVEL)
    ret
  end

  #客户状态说明
  def imported_customer_states_for_select
    [["新升级","up"],["新降级","down"],["无变化","normal"]]
  end
end

