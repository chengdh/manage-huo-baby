#coding: utf-8
#手工内部中转运单
class HandInnerTransitBillsController < CarryingBillsController
  defaults :resource_class => HandInnerTransitBill
  #GET search
  #显示查询窗口
  def search
    respond_to do |format|
      format.html
      format.js  {render :partial => "shared/carrying_bills/search",:local => {:local_search => resource_class.search}}
    end
  end
end
