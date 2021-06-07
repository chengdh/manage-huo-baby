#coding: utf-8
module ScanHeaderLoadOutsHelper
  #票据状态
  def scan_header_load_out_states_for_select
    ScanHeaderLoadOut.state_machine.states.collect{|state| [state.human_name,state.value] }
  end
end
