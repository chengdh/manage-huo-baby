#coding: utf-8
module FromShortFeeInfosHelper
  #票据状态
  def from_short_fee_info_states_for_select
    FromShortFeeInfo.state_machine.states.collect{|state| [state.human_name,state.value] }
  end
  def carrying_bills_states_for_select
    [["已提货",'deliveried'],["未提货",'no_deliveried']]
  end
end
