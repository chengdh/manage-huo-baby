#coding: utf-8
module BaseRefundsHelper
  #票据状态
  def refound_states_for_select
    BaseRefund.state_machine.states.collect{|state| [state.human_name,state.value] }
  end
end
