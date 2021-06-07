# -*- encoding : utf-8 -*-
#运单controller基础类
class CarryingBillsController < BaseController
  include AccountingModule
  include ReportModule
  include QueryInterface
  #查询服务,去除layout
  # layout false,:only => [:search_service_page,:search_service]
  layout :resolve_layout

  #NOTE 导出短信文本采用post方式提交
  protect_from_forgery :except => [:export_sms_txt_for_rpt_no_pay]
  skip_before_filter :authenticate_user!,:only => [:search_service_page,:search_service,:single_search_service_page,:single_search_service,:search_service_page_by_customer_code,:search_service_by_customer_code]
  skip_before_filter :get_unread_messages,:only => [:search_service_page,:search_service,:single_search_service_page,:single_search_service,:search_service_page_by_customer_code,:search_service_by_customer_code]
  skip_before_filter :sum_carrying_fee_rpt,:only => [:search_service_page,:search_service,:single_search_service_page,:single_search_service,:search_service_page_by_customer_code,:search_service_by_customer_code]
  skip_authorize_resource :only => [:search_service_page,:search_service,:single_search_service_page,:single_search_service,:search_service_page_by_customer_code,:search_service_by_customer_code,:barcode_exceptions]
  #http_cache :new,:last_modified => Proc.new {|c| c.send(:last_modified)},:etag => Proc.new {|c| c.send(:etag,"carrying_bill_new")}
  #判断是否超过录单时间,超过录单时间后,不可再录入票据
  #before_filter :check_expire,:only => :new
  before_filter :pre_process_search_params,:only => [:index,:rpt_turnover,:turnover_chart,:export_excel,:rpt_turnover_for_refund,
                                                     :rpt_divide,:rpt_divide_department,:export_excel_only_from_to_info,
                                                     :export_excel_for_kingdee,
                                                     :build_accounting_document_from_cash,:build_accounting_document_to_cash]
  belongs_to :base_load_list,
    :base_distribution_list,
    :base_deliver_info,
    :base_settlement,
    :base_refund,
    :payment_list,
    :base_cash_pay_info,
    :base_transfer_pay_info,
    :base_post_info,
    :transit_info,
    :transit_deliver_info,
    :short_list,
    :polymorphic => true,:optional => true

  #覆盖默认的index方法,主要是为了导出
  def index
    super do |format|
      format.csv {send_data resource_class.to_csv(@search)}
      format.json {render :json => collection}
    end
  end
  #DELETE carrying_bills/batch_destroy
  def batch_destroy
    @search = end_of_association_chain.accessible_by(current_ability,:read_with_conditions).search(params[:search]).order(sort_column + ' ' + sort_direction)
    bill_ids = params[:bill_ids]
    delete_bills = resource_class.destroy_all(:id => bill_ids,:state => :billed) if bill_ids.present?
    flash[:notice] = "成功删除了#{delete_bills.size}张运单!"
  end

  #导出查询结果为excel
  #GET carrying_bills/e
  #port_excel
  def export_excel
    @search = end_of_association_chain.accessible_by(current_ability,:read_with_conditions).search(params[:search]).order(sort_column + ' ' + sort_direction)
    xls = render_to_string(:partial => "shared/carrying_bills/excel",:layout => false)
    send_data show_or_hide_fields_for_export(xls),:filename => "bill.xls"
  end

  #导出查询结果为excel
  #GET carrying_bills/export_excel_only_from_to_info
  def export_excel_only_from_to_info
    @search = end_of_association_chain.accessible_by(current_ability,:read_with_conditions).search(params[:search]).order(sort_column + ' ' + sort_direction)
    xls = render_to_string(:partial => "shared/carrying_bills/excel_only_from_to_info",:layout => false)
    send_data show_or_hide_fields_for_export(xls),:filename => "bill.xls"
  end

  #导出查询结果为excel
  #GET carrying_bills/export_excel_for_kingdee
  def export_excel_for_kingdee
    @search = end_of_association_chain.accessible_by(current_ability,:read_with_conditions).search(params[:search]).order(sort_column + ' ' + sort_direction)
    xls = render_to_string(:partial => "shared/carrying_bills/excel_for_kingdee",:layout => false)
    send_data show_or_hide_fields_for_export(xls),:filename => "bills_for_kingdee.xls"
  end

  #导出查询结果为excel
  #转账支付清单导出
  #GET carrying_bills/export_excel_transfer_payment_list_for_kingdee
  def export_excel_transfer_payment_list_for_kingdee
    @search = end_of_association_chain.accessible_by(current_ability,:read_with_conditions).search(params[:search]).order(sort_column + ' ' + sort_direction)
    xls = render_to_string(:partial => "shared/carrying_bills/excel_transfer_payment_list_for_kingdee",:layout => false)
    send_data show_or_hide_fields_for_export(xls),:filename => "transfer_payment_list_for_kingdee.xls"
  end

  #导出短信群发文本
  #GET carrying_bills/export_sms_txt.txt
  def export_sms_txt
    require 'iconv'
    respond_to do |format|
      format.text do
        #FIXME 垃圾短信公司,客户端软件不支持utf-8格式的导出文件,只能进行转换
        send_txt = Iconv.conv("gb2312//IGNORE","utf-8",resource_class.export_sms_txt_for_arrive(params[:bill_ids]))
        send_data send_txt,:type => "text/plain;charset=gb2312;header=present",:filename => 'sms.txt'
      end
    end
  end

  #导出提货未提款短信群发文本
  #POST carrying_bills/export_sms_txt_for_rpt_no_pay.txt
  def export_sms_txt_for_rpt_no_pay
    require 'iconv'
    respond_to do |format|
      format.text do
        #FIXME 垃圾短信公司,客户端软件不支持utf-8格式的导出文件,只能进行转换
        send_txt = Iconv.conv("gb2312//IGNORE","utf-8",resource_class.export_sms_txt_for_rpt_no_pay(params[:bill_ids]))
        send_data send_txt,:type => "text/plain;charset=gb2312;header=present",:filename => 'sms.txt'
      end
    end
  end

  #GET search
  #显示查询窗口
  def search
    respond_to do |format|
      format.html
      format.js  {render :partial => "shared/carrying_bills/search"}
    end
  end
  def show
    super do |format|
      format.js {render :partial => "shared/carrying_bills/show",:locals => {:show => resource }}
    end
  end
  #重写destroy方法
  def destroy
    bill = get_resource_ivar || set_resource_ivar(resource_class.find(params[:id]))
    bill.destroy
    flash[:notice] = "运单已删除."
    redirect_to :root
  end
  #重写修改方法
  def update
    bill = get_resource_ivar || set_resource_ivar(resource_class.find(params[:id]))
    original_bill = bill.clone  #保存原始运单信息
    bill.attributes=params[resource_class.model_name.underscore.to_sym]
    logger.debug "original_carrying_fee = #{bill.original_carrying_fee}"
    logger.debug "carrying_fee = #{bill.carrying_fee}"
    authorize! :update_goods_fee,bill,:message => "你无权修改货款!" if can? :update_goods_fee,original_bill
    logger.debug "pass update_goods_fee authorize"
    if can? :update_all,original_bill
      authorize! :update_all,bill,:message => "你无权修改该票据!"
      logger.debug "pass update_goods_fee authorize"

    elsif can? :update_carrying_fee_100,original_bill
      authorize! :update_carrying_fee_100,bill,:message => "你减免运费金额超过100%!"

      logger.debug "pass update_carrying_fee_100 authorize"
    elsif can? :update_carrying_fee_50,original_bill
      authorize! :update_carrying_fee_50,bill,:message => "你运费金额超过50%!"

      logger.debug "pass update_carrying_fee_50 authorize"
    elsif can? :update_carrying_fee_20,original_bill
      authorize! :update_carrying_fee_20, bill,:message => "你减免运费金额超过20%!"
      logger.debug "pass update_carrying_fee_20 authorize"
    end
    update!
  end

  #PUT /carrying_bills/1/reset
  def reset
    bill = get_resource_ivar || set_resource_ivar(resource_class.find(params[:id]))
    bill.reset
    flash[:success] = "运单已成功重置."
    redirect_to bill
  end
  #运单作废
  #PUT /carrying_bills/1/invalidate
  def invalidate
    bill = get_resource_ivar || set_resource_ivar(resource_class.find(params[:id]))
    bill.invalidate
    flash[:success] = "运单已被作废."
    redirect_to bill
  end
  #运单注销
  #PUT /carrying_bills/:id/cancel
  def cancel
    bill = get_resource_ivar || set_resource_ivar(resource_class.find(params[:id]))
    bill.note += params[:cancel_note] if params[:cancel_note].present?
    bill.cancel
    flash[:success] = "运单已被注销."
    redirect_to bill
  end

  #运单暂扣,只是在已收款/待支付状态时可进行操作
  #PUT /carrying_bills/:id/detain
  def detain
    bill = get_resource_ivar || set_resource_ivar(resource_class.find(params[:id]))
    bill.detain_additional_state!
    flash[:success] = "运单已暂扣"
    render :action => :show
  end

  #解除暂扣
  #PUT carrying_bills/:id/undetain 
  def undetain
    bill = get_resource_ivar || set_resource_ivar(resource_class.find(params[:id]))
    bill.undetain_additional_state!
    flash[:success] = "已解除运单暂扣状态"
    render :action => :show
  end

  #运单挂失
  #PUT carrying_bills/:id/report_loss
  def report_loss
    bill = get_resource_ivar || set_resource_ivar(resource_class.find(params[:id]))
    bill.additional_note = params[:additional_note] if params[:additional_note].present?
    bill.report_loss_additional_state!
    flash[:success] = "运单已挂失"
    render :action => :show
  end


  #提货票据打印次数
  #PUT carrying_bills/:id/th_bill_print_counter
  def th_bill_print_counter
    bill = resource_class.find(params[:id])
    get_resource_ivar || set_resource_ivar(bill)
    bill.increment!(:th_bill_print_count)
    render :nothing => true
  end

  #显示扫码异常信息
  #GET carrying_bills/:id/barcode_exceptions
  def barcode_exceptions
    bill = resource_class.find(params[:id])
    get_resource_ivar || set_resource_ivar(bill)
    respond_to do |format|
      format.html
      format.js  {render :partial => "shared/carrying_bills/barcode_exceptions"}
    end
  end


  private
  #FIXME 不再使用
  def check_expire
    if current_user.default_org.input_expire?
      flash[:error]="录单时间截至到#{current_user.default_org.lock_input_time},已过录单时间."
      redirect_to :back
    end
  end
  def resolve_layout
    case action_name
    when "search_service_page", "search_service","single_search_service_page", "single_search_service","search_service_page_by_customer_code", "search_service_by_customer_code"
      "bootstrap"
    else
      "application"
    end
  end
=begin
  protected
  def collection
    @search = end_of_association_chain.accessible_by(current_ability,:read_with_conditions).search(params[:search]).with_association
    bills = @search.select("DISTINCT #{resource_class.table_name}.*").order(sort_column + ' ' + sort_direction).with_association.paginate(:page => params[:page])
    set_collection_ivar(bills)
  end
=end
end
