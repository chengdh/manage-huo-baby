#coding: utf-8
#发货地－中转装车单
class FromOrgInnerTransitLoadListsController < BaseLoadListsController
  helper_method :current_in_yard?
  defaults :resource_class => InnerTransitLoadList, :collection_name => 'inner_transit_load_lists', :instance_name => 'inner_transit_load_list'
  #先跳过基类的验证,然后重写自己的验证
  skip_authorize_resource
  authorize_resource :class => "InnerTransitLoadList",:instance_name => "inner_transit_load_list"
  protected
  def collection
    @search = end_of_association_chain.accessible_by(current_ability,:read_from_org) \
      .from_org_transit_bills(current_user.current_ability_org_ids).search(params[:search])

    get_collection_ivar || set_collection_ivar(@search.select("DISTINCT #{resource_class.table_name}.*").order(sort_column + ' ' + sort_direction).paginate(:page => params[:page]))
  end
  private
  #判断当前登录用户是否是中转货场
  def current_in_yard?
    current_user.default_org.try(:is_yard)
  end
end
