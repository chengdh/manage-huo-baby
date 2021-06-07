# -*- encoding : utf-8 -*-
class GoodsFeeSettlementListsController < BaseController
  #定义列表显示的列
  table :bill_date,:org,:sum_income_fee,:sum_spending_fee,:sum_rest_fee,:user,:human_state_name
  #查询
  #GET goods_fee_settlement_lists/search
  def search
    render :partial => "search"
  end
  #PUT goods_fee_settlements/:id/post
  #确认清单,确认后将不可修改
  def post
    @goods_fee_settlement_list = resource_class.find(params[:id])
    @goods_fee_settlement_list.post ? flash[:success] = "清单确认成功!" : flash[:error] = "清单确认失败,实领金额应大于0!"
    redirect_to @goods_fee_settlement_list
  end
end

