#coding: utf-8
#分支机构自身客户资料
class BranchCustomersController < BaseController
  #GET branch_customers/query_for_bill_input.json
  #运单录入时,根据手机号及org_id查询客户资料信息
  def query_for_bill_input
    @customer= BranchCustomer.search(params[:search]).first
    # if @customer.blank?
    #   @customer = BranchCustomer.find_by_mobile(params[:search][:mobile_eq])
    # end
    respond_to do |format|
      format.json {render :json => @customer}
    end
  end
  #GET imported_customers/search
  def search
    render :partial => 'search'
  end
  #导出查询结果为excel
  #GET imported_customers/export_excel
  def export_excel
    @search = end_of_association_chain.accessible_by(current_ability,:read_with_conditions).search(params[:search]).order(sort_column + ' ' + sort_direction)
    xls = render_to_string(:partial => "excel",:layout => false)
    send_data show_or_hide_fields_for_export(xls),:filename => "branch_customers.xls"
  end


  #需要重写collection方法
  def collection
    #总部可查看所有数据 其他机构只能查看自身数据
    if current_user.default_org.in_summary?
      @search = end_of_association_chain.search(params[:search])
    else
      @search = end_of_association_chain.where(:org_id => current_user.current_ability_org_ids).search(params[:search])
    end
    get_collection_ivar || set_collection_ivar(@search.select("DISTINCT #{resource_class.table_name}.*").paginate(:page => params[:page]))
  end

end
