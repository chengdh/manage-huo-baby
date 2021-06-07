#coding: utf-8
module AdjustGoodsFeeInfosHelper
  def adjust_goods_fee_info_states_for_select
    AdjustGoodsFeeInfo.state_machine.states.collect{|state| [state.human_name,state.value] }
  end
end
