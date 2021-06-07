# -*- encoding : utf-8 -*-
#coding: utf-8
#coding: utf-8
module RemittancesHelper
  #汇款状态
  def remittance_states_for_select
    Remittance.state_machine.states.collect{|state| [state.human_name,state.value] }
  end

end

