#coding: utf-8
#中转收款清单
class ReceiveOutterTransitRefundsController < BaseRefundsController 
  defaults :resource_class => OutterTransitRefund, :collection_name => 'outter_transit_refunds', :instance_name => 'outter_transit_refund'
  skip_authorize_resource
  authorize_resource :class => "OutterTransitRefund",:instance_name => "outter_transit_refund"
  protected
  def collection
    @search = end_of_association_chain.accessible_by(current_ability,:read_arrive).search(params[:search])
    get_collection_ivar || set_collection_ivar(@search.select("DISTINCT #{resource_class.table_name}.*").order(sort_column + ' ' + sort_direction).paginate(:page => params[:page]))
  end
end
