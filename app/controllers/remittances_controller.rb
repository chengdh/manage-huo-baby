# -*- encoding : utf-8 -*-
#coding: utf-8
class RemittancesController < BaseController
  include BillOperate
  table :bill_date,:from_org,:to_org,:should_fee,:inner_transit_refund_should_fee,:sum_should_fee,:act_fee,:pos_fee,:quick_fee,:other_fee,:total_fee,:diff_fee,:validate_user,:human_state_name,:note
  #GET search
  #显示查询窗口
  def search
    render :partial => "search"
  end
  #需要重写collection方法
  protected
  def collection
    @search = end_of_association_chain.where(["remittances.from_org_id in (?) or remittances.to_org_id in (?)",current_user.current_ability_org_ids,current_user.current_ability_org_ids]).search(params[:search])
    get_collection_ivar || set_collection_ivar(@search.select("DISTINCT #{resource_class.table_name}.*").order(sort_column + ' ' + sort_direction).paginate(:page => params[:page]))
  end
end
