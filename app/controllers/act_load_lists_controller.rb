# -*- encoding : utf-8 -*-
class ActLoadListsController < BaseController
  table :bill_date,:bill_no,:from_org,:to_org,:user,:note
  #GET search
  #显示查询窗口
  def search
    render :partial => "search"
  end

  #GET act_load_lists/1/export_excel
  def export_excel
    @act_load_list = resource_class.find(params[:id],:include => [:from_org,:to_org,:user,:act_load_list_lines])
  end

  #需要重写collection方法,发货地和到货地都能看到相关的单据
  protected
  def collection
    @search = end_of_association_chain.where(["act_load_lists.from_org_id = ? or act_load_lists.to_org_id =?",current_user.default_org.id,current_user.default_org.id]).search(params[:search])
    get_collection_ivar || set_collection_ivar(@search.select("DISTINCT #{resource_class.table_name}.*").order(sort_column + ' ' + sort_direction).paginate(:page => params[:page]))
  end
end
