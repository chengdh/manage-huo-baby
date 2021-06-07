# -*- encoding : utf-8 -*-
module GoodsErrorsHelper
  def goods_error_states_for_select
    GoodsError.state_machine.states.collect{|state| [state.human_name,state.value] }
  end

end

