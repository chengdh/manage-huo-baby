#coding: utf-8
#短驳单确认
class ArriveShortListsController < BaseController
  include BillOperate
  table :bill_date,:bill_no,:from_org,:to_org,:vehicle_no,:driver,:mobile,:human_state_name,:user
  defaults :resource_class => ShortList, :collection_name => 'short_lists', :instance_name => 'short_list'
  #先跳过基类的验证,然后重写自己的验证
  skip_authorize_resource
  authorize_resource :class => "ShortList",:instance_name => "short_list"

  #GET search
  #显示查询窗口
  def search
    render :partial => "short_lists/search"
  end


  protected
  def collection
    @search = end_of_association_chain.accessible_by(current_ability,:read_arrive).search(params[:search])
    get_collection_ivar || set_collection_ivar(@search.select("DISTINCT #{resource_class.table_name}.*").order(sort_column + ' ' + sort_direction).paginate(:page => params[:page]))
  end
end
