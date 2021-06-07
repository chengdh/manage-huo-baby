# -*- encoding : utf-8 -*-
class ImportedCustomersController < BaseController
  layout :resolve_layout
  skip_authorize_resource :only => [:search_service_page_by_customer_code,:search_service_by_customer_code]
  #检查上月是否有数据导入
  #before_filter :check_data,:only => :index
  # def create
  #   if params[:org_id].present?
  #     CustomerFeeInfo.generate_data(params[:org_id])
  #   else
  #     Branch.where(:is_active => true).all.each {|org| CustomerFeeInfo.generate_data(org.id)}
  #   end
  #   flash[:success] = "生成客户分级数据完毕"
  #   redirect_to imported_customers_url("search[org_id_eq]" => params[:org_id])
  # end #
  # #GET imported_customers/:id/fee_lines
  #显示客户每月运费合计明细
  def fee_lines
    @customer = ImportedCustomer.find(params[:id])

    #@customer_fee_info_lines = CustomerFeeInfoLine.where(:name => @customer.name,:phone => @customer.mobile).includes(:customer_fee_info).order("created_at DESC")
    mth_range = ("#{Date.today.year}01".."#{Date.today.year}12").to_a
    mth_range = ("201601".."#{Date.today.year}12").to_a
    if @customer.code.present?
      @customer_fee_info_lines = CustomerFeeInfoLine.search(:customer_fee_info_mth_in => mth_range.to_a ,:code_eq => @customer.code).includes(:customer_fee_info).order("created_at DESC")
    else
      @customer_fee_info_lines = CustomerFeeInfoLine.search(:customer_fee_info_mth_in => mth_range.to_a ,:name_eq => @customer.name,:phone_eq => @customer.mobile).includes(:customer_fee_info).order("created_at DESC")
    end

    respond_to do |format|
      format.js {render :partial => "fee_lines"}
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
    xls = render_to_string(:partial => "imported_customers/excel",:layout => false)
    send_data show_or_hide_fields_for_export(xls),:filename => "imported_customers.xls"
  end
  #按照客户卡号查询积分
  def search_service_page_by_customer_code ; end

  #积分查询结果
  def search_service_by_customer_code
    @imported_customers = ImportedCustomer.search(params[:search]).relation
    respond_to do |format|
      format.html
      format.xml {render :xml => @imported_customers.to_xml(:skip_types => true,:dasherize => false)}
    end
  end


  private
  def check_data
    return if params[:search].blank?
    conditions = {:mth => 1.months.ago.strftime('%Y%m'),:org_id => current_user.current_ability_org_ids}
    conditions[:org_id] = params[:search][:org_id_eq] if params[:search][:org_id_eq].present?
    if !CustomerFeeInfo.exists?(conditions)
      flash[:alert] = "没有生成#{1.months.ago.strftime('%Y%m')}月的客户分级信息,请先生成客户分级信息"
    end
  end
  #需要重写collection方法
  def collection
    #防止 level_in传入空字符串
    params[:search][:level_in].delete_if {|l| l.eql?("") } if params[:search][:level_in].present?
    #总部可查看所有数据 其他机构只能查看自身数据
    if current_user.default_org.in_summary?
      @search = end_of_association_chain.search(params[:search])
    else
      @search = end_of_association_chain.where(:org_id => current_user.current_ability_org_ids).search(params[:search])
    end
    get_collection_ivar || set_collection_ivar(@search.select("DISTINCT #{resource_class.table_name}.*").paginate(:page => params[:page]))
  end
  def resolve_layout
    case action_name
    when "search_service_page_by_customer_code", "search_service_by_customer_code"
      "bootstrap"
    else
      "application"
    end
  end

end
