#coding: utf-8
module AdjustFeeInfosHelper
  def adjust_fee_info_states_for_select
    AdjustFeeInfo.state_machine.states.collect{|state| [state.human_name,state.value] }
  end
end
