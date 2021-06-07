#coding: utf-8
#中转装车单到货处理
class ToOrgInnerTransitLoadListsController < BaseLoadListsController
  defaults :resource_class => InnerTransitLoadList, :collection_name => 'inner_transit_load_lists', :instance_name => 'inner_transit_load_list'
  #先跳过基类的验证,然后重写自己的验证
  skip_authorize_resource
  authorize_resource :class => "InnerTransitLoadList",:instance_name => "inner_transit_load_list"
  #显示提货单据打印界面
  #GET to_org_load_list/:id/show_print_th_bill
  def show_print_th_bill
    get_resource_ivar || set_resource_ivar(resource_class.find(params[:id]))
  end

  protected
  def collection
    @search = end_of_association_chain.accessible_by(current_ability,:read_to_org) \
      .to_org_transit_bills(current_user.current_ability_org_ids).search(params[:search])

    get_collection_ivar || set_collection_ivar(@search.select("DISTINCT #{resource_class.table_name}.*").order(sort_column + ' ' + sort_direction).paginate(:page => params[:page]))
  end
end
