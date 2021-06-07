#coding: utf-8
class DeliverRegionsController < BaseController
  table :org,:district_desc,:name,:is_active
  #分支机构只能看到自己设置的送货区域
  protected
  def collection
    @search = end_of_association_chain.where(["deliver_regions.org_id = ? ",current_user.default_org.id]).search(params[:search])
    get_collection_ivar || set_collection_ivar(@search.select("DISTINCT #{resource_class.table_name}.*").order(sort_column + ' ' + sort_direction).paginate(:page => params[:page]))
  end
end
