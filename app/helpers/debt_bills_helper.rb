#coding: utf-8
module DebtBillsHelper
  #票据状态
  def debt_bill_states_for_select
    DebtBill.state_machine.states.collect{|state| [state.human_name,state.value] }
  end

end
