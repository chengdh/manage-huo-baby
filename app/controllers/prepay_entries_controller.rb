#coding: utf-8
#预付款记录
class PrepayEntriesController < BaseController
  table :bill_date,:org,:note,:debit,:credit,:balance
  #GET search
  #显示查询窗口
  def search
    render :partial => "search"
  end

  #导出查询结果为excel
  #GET prepay_entries/export_excel
  def export_excel
    @search = end_of_association_chain.accessible_by(current_ability,:read_with_conditions).search(params[:search]).order("org_id ASC,created_at ASC")
    xls = render_to_string(:partial => "excel",:layout => false)
    send_data show_or_hide_fields_for_export(xls),:filename => "prepay_entries.xls"
  end


  protected
  def collection
    #NOTE 总部操作人员可看到所有数据
    #外部操作人员只能看到自己的
    current_org = current_user.default_org
    if current_org.in_summary?
      @search = end_of_association_chain.accessible_by(current_ability,:read_with_conditions).search(params[:search])
    else
      @search = end_of_association_chain.where(:org_id => current_user.default_org_id).search(params[:search])
    end

    set_collection_ivar(@search.select("DISTINCT #{resource_class.table_name}.*").order("org_id ASC,created_at ASC").paginate(:page => params[:page]))
  end
end
