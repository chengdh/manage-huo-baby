# -*- encoding : utf-8 -*-
#coding: utf-8
module LoadListsHelper
  #票据状态
  def load_list_states_for_select
    LoadList.state_machine.states.collect{|state| [state.human_name,state.value] }
  end

end

