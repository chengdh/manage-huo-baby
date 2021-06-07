#coding: utf-8
#修改外部中转功能的顺序
class ChangeOutterTransitFunctionOrder < ActiveRecord::Migration
  def up
    functions = %w(中转运单录入 手工中转运单录入 外部中转-货物运输清单 外部中转-到货清单 货物中转 中转提货 外部中转-结算员交款清单 外部中转-返款清单 外部中转-收款清单 外部中转-现金代收货款支付清单 外部中转-货款转账支付 外部中转-客户提款(现金) 外部中转-客户提款(转账) 外部中转-客户提款结算清单 外部中转-已发货票据统计 外部中转-本地未提货统计)
    functions.each_with_index do |func_name,index|
      sf = SystemFunction.find_by_subject_title(func_name)
      sf.update_attributes(:order => index+1) if sf
    end
  end

  def down
  end
end
