#coding: utf-8
module CustomerPaymentInfosHelper
  def customer_pay_types_for_select
    CustomerPaymentInfo::CUSTOMER_PAY_TYPES_FOR_SELECT.map {|k,v| [v,k]}
  end
  def customer_pay_type_des(pay_type)
    CustomerPaymentInfo::CUSTOMER_PAY_TYPES_FOR_SELECT[pay_type]
  end
  def customer_payment_info_states_for_select
    CustomerPaymentInfo.state_machine.states.collect{|state| [state.human_name,state.value] }
  end


end
