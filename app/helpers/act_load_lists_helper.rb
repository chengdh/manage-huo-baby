# -*- encoding : utf-8 -*-
module ActLoadListsHelper
  #票据状态
  def act_load_list_states_for_select
    BranchInventory.state_machine.states.collect{|state| [state.human_name,state.value] }
  end
end

