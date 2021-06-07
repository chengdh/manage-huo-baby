#coding: utf-8
module TasksHelper
  def task_states_for_select
    Task.state_machine.states.collect{|state| [state.human_name,state.value] }
  end
  def audit_states_for_select
    [["通过","pass"],["驳回","reject"]]
  end
end
