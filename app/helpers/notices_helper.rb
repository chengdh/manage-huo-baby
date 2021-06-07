#coding : utf-8
module NoticesHelper
  #判断电话号码是否为手机
  #目前很简单,11位即为手机
  def mobile?(call_number)
    call_number.present? and call_number.size == 11
  end
  #notice state描述
  def notice_state_desc(state)
    state_des = nil
    state_des = '草稿' if state.eql?('draft')
    state_des = '已处理' if state.eql?('completed')
    state_des
  end
  #notice line state 描述
  def notice_line_state_desc(state)
    state_des = nil
    state_des = '草稿' if state.eql?('draft')
    state_des = '已拨打' if state.eql?('is_called')
    state_des = '拨打失败' if state.eql?('is_failed')
    state_des = '已发送' if state.eql?('is_sended')
    state_des
  end
  #状态select
  def notice_states_for_select
    [['草稿','draft',],['已处理','completed']]
  end
end
