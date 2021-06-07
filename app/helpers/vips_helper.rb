#coding: utf-8
module VipsHelper
  #客户状态
  def vip_states_for_select
    Vip.state_machines[:vip_state].states.collect{|state| [state.human_name,state.value] }
  end
end

