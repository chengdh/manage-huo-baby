#coding: utf-8
#同城快运-收款清单
class ReceiveLocalTownRefundsController < BaseRefundsController
  defaults :resource_class => LocalTownRefund, :collection_name => 'local_town_refunds', :instance_name => 'local_town_refund'
  #先跳过基类的验证,然后重写自己的验证
  skip_authorize_resource
  authorize_resource :class => "LocalTownRefund",:instance_name => "local_town_refund"
  protected
  def collection
    @search = end_of_association_chain.accessible_by(current_ability,:read_arrive).search(params[:search])
    get_collection_ivar || set_collection_ivar(@search.select("DISTINCT #{resource_class.table_name}.*").order(sort_column + ' ' + sort_direction).paginate(:page => params[:page]))
  end
end
