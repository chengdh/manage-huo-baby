#coding: utf-8
module DivideConfigsHelper
  #单据类型选择
  def divide_config_bill_types_for_select
    [["按吨方计算运单","TonVolumeBill"],["分公司运单","BranchBill"]]
  end
end
