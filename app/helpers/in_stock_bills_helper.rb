#coding: utf-8
module InStockBillsHelper
  #票据状态
  def in_stock_bill_states_for_select
    InStockBill.state_machine.states.collect{|state| [state.human_name,state.value] }
  end
end
