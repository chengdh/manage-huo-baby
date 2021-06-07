# -*- encoding : utf-8 -*-
#coding: utf-8
module SettlementsHelper
  #票据状态
  def settlement_states_for_select
    BaseSettlement.state_machine.states.collect{|state| [state.human_name,state.value] }
  end
end

