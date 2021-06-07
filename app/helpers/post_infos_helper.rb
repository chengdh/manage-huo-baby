# -*- encoding : utf-8 -*-
#coding: utf-8
#coding: utf-8
module PostInfosHelper
  #票据状态
  def post_info_states_for_select
    PostInfo.state_machine.states.collect{|state| [state.human_name,state.value] }
  end


end

