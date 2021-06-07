#coding: utf-8
#修改内部中转功能的排列顺序
class ChangeInnerTransitFunctionOrder < ActiveRecord::Migration
  def up
    functions = %w(内部中转运单录入 内部中转运单(手工) 内部中转清单-发货 到货清单中转处理 中转到货处理 分货清单管理 客户提货 内部中转-结算员交款清单 中转返款单 中转返款单(总部处理) 中转收款处理 内部中转-现金代收货款支付清单 内部中转-货款转账支付 内部中转-客户提款(现金) 内部中转-客户提款(转账) 内部中转-客户提款结算清单 已发货票据统计 本地未提货统计(中转))
    functions.each_with_index do |func_name,index|
      sf = SystemFunction.find_by_subject_title(func_name)
      sf.update_attributes(:order => index+1) if sf
    end
  end

  def down
  end
end
