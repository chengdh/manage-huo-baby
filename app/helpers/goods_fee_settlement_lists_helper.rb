# -*- encoding : utf-8 -*-
module GoodsFeeSettlementListsHelper
  #票据状态
  def goods_fee_settlement_list_states_for_select
    GoodsFeeSettlementList.state_machine.states.collect{|state| [state.human_name,state.value] }
  end
end

