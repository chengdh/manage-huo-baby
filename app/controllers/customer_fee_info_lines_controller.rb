#coding: utf-8
#客户信息统计
class CustomerFeeInfoLinesController < BaseController
  #GET customer_fee_info_lines/search
  def search
    render :partial => "search"
  end
  #需要重写collection方法
  protected
  def collection
    #总部可查看所有数据 其他机构只能查看自身数据
    if current_user.is_admin? or current_user.default_org.in_summary?
      @search = end_of_association_chain.joins(:customer_fee_info).search(params[:search])
    else
      @search = end_of_association_chain.joins(:customer_fee_info).where(["customer_fee_infos.org_id = ?",current_user.default_org.id]).search(params[:search])
    end
    get_collection_ivar || set_collection_ivar(@search.select("DISTINCT #{resource_class.table_name}.*").order("customer_fee_infos.org_id ASC").paginate(:page => params[:page]))
  end
end
