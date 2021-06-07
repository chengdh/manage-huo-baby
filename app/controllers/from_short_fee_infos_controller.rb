#coding: utf-8
class FromShortFeeInfosController < BaseController
  table :bill_date,:from_org,:to_org,:human_state_name,:sum_from_short_carrying_fee,:audit_date,:note
  def create
    bill = resource_class.new(params[resource_class.model_name.underscore])
    get_resource_ivar || set_resource_ivar(bill)
    params[:bill_ids].each do |id|
      bill.from_short_fee_lines.build(:carrying_bill_id => id)
    end
    create!
  end
  #GET search
  #显示查询窗口
  def search
    render :partial => "search"
  end
  #GET from_short_fee_info/1/export_excel
  def export_excel
    @from_short_fee_info = resource_class.find(params[:id],:include => [:from_org,:to_org,:user,:from_short_fee_lines])
    xls = render_to_string(:partial => "excel",:layout => false)
    send_data show_or_hide_fields_for_export(xls),:filename => "from_short_fee.xls"
  end

  #GET from_short_fee_info/1/export_excel_for_kingdee
  def export_excel_for_kingdee
    @from_short_fee_info = resource_class.find(params[:id],:include => [:from_org,:to_org,:user,:from_short_fee_info_lines])
  end

  #核销短途运费信息
  #PUT from_short_fee_infos/:id/pass
  def pass
    @from_short_fee_info = resource_class.find(params[:id])

    @from_short_fee_info.pass
    #判断是否需要修改数据
    if params[:update_attrs].present?
     @from_short_fee_info.update_attributes(params[:update_attrs])
    end

    flash[:notice] = "短途运费信息审批通过."
    render :show
  end

  #核销短途运费信息
  #PUT from_short_fee_infos/:id/reject
  def reject
    @from_short_fee_info = resource_class.find(params[:id])

    @from_short_fee_info.reject
    #判断是否需要修改数据
    if params[:update_attrs].present?
     @from_short_fee_info.update_attributes(params[:update_attrs])
    end

    flash[:notice] = "短途运费信息已拒绝."
    render :show
  end

  #GET from_short_fee_infos/report_lines
  #统计明细
  def report_lines
    @from_short_fee_lines = FromShortFeeLine.search(:from_short_fee_info_from_org_id_or_from_short_fee_info_to_org_id_in => current_user.current_ability_org_ids)
      .relation.search(params[:search]).all
  end

  #GET from_short_fee_infos/search_lines
  #显示查询窗口
  def search_lines
    render :partial => "search_lines"
  end
  #需要重写collection方法
  protected
  def collection
    @search = end_of_association_chain.where(["from_short_fee_infos.from_org_id in (?) or from_short_fee_infos.to_org_id in (?)",current_user.current_ability_org_ids,current_user.current_ability_org_ids]).search(params[:search])
    get_collection_ivar || set_collection_ivar(@search.select("DISTINCT #{resource_class.table_name}.*").order(sort_column + ' ' + sort_direction).paginate(:page => params[:page]))
  end
end
