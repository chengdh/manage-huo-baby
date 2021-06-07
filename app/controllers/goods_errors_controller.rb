# -*- encoding : utf-8 -*-
class GoodsErrorsController < BaseController
  table :bill_date,:org,:except_des,:except_num,:note,:user,:human_state_name
  #需要跳过对update的权限检查,在进行核销/理赔/责任鉴定时候,使用了update
  skip_authorize_resource :only => :update
  def update
    bill = resource_class.find(params[:id])
    get_resource_ivar || set_resource_ivar(bill)
    update!
    bill.process if bill.valid?
  end

  #GET /goods_exceptions/1/show_authorize
  #显示授权核销界面
  def show_authorize
    goods_error = resource_class.find(params[:id])
    get_resource_ivar || set_resource_ivar(goods_error)
    goods_error.build_gerror_authorize
  end
  #显示查询窗口
  def search
    render :partial => "search"
  end
  #需要重写collection方法
  protected
  def collection
    @search = end_of_association_chain.where(["goods_errors.org_id in (?) or goods_errors.op_org_id in (?)",current_user.current_ability_org_ids,current_user.current_ability_org_ids]).search(params[:search])
    get_collection_ivar || set_collection_ivar(@search.select("DISTINCT #{resource_class.table_name}.*").order(sort_column + ' ' + sort_direction).paginate(:page => params[:page]))
  end

end

