# -*- encoding : utf-8 -*-
#coding: utf-8
module ShortFeeInfosHelper
  #票据状态
  def short_fee_info_states_for_select
    ShortFeeInfo.state_machine.states.collect{|state| [state.human_name,state.value] }
  end

end

