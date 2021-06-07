#coding: utf-8
class TransitOrgInnerTransitRefundsController < BaseRefundsController
  defaults :resource_class => InnerTransitRefund, :collection_name => 'inner_transit_refunds', :instance_name => 'inner_transit_refund'
  #先跳过基类的验证,然后重写自己的验证
  skip_authorize_resource
  authorize_resource :class => "InnerTransitRefund",:instance_name => "inner_transit_refund"
  protected
  def collection
    @search = end_of_association_chain.accessible_by(current_ability,:read_transit_org).transit_org_refunds(current_user.current_ability_org_ids).search(params[:search])
    get_collection_ivar || set_collection_ivar(@search.select("DISTINCT #{resource_class.table_name}.*").order(sort_column + ' ' + sort_direction).paginate(:page => params[:page]))
  end
end
