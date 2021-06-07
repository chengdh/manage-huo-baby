#coding: utf-8
#分成 比例表
class DivideListsController < BaseController
  #GET search
  #显示查询窗口
  def search
    @search = resource_class.search(params[:search])
    render :partial => "search"
  end
end
