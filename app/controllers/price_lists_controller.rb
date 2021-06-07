#coding: utf-8
#分公司价格表
class PriceListsController < BaseController
  skip_authorize_resource :only => [:price_line]
  table :org,:is_active,:note
  #根据客户端传入的参数获取给定的运价设置
  #GET price_lists/price_line
  def price_line
    @price_line = PriceListLine.search_line(params)
    respond_to do |format|
      format.json {render :json => @price_line.to_json(:include => :fee_unit) }
    end
  end

  #GET search
  #显示查询窗口
  def search
    @search = resource_class.search(params[:search])
    render :partial => "search"
  end
end
