#coding: utf-8
#月结客户付款明细
class CustomerPaymentInfosController < BaseController
  table :bill_date,:from_org,:bill_no,:customer_name,:pay_type_des,:sum_carrying_fee,:human_state_name
  def create
    bill = resource_class.new(params[resource_class.model_name.underscore])
    get_resource_ivar || set_resource_ivar(bill)
    params[:bill_ids].each do |id|
      bill.customer_payment_info_lines.build(:carrying_bill_id => id)
    end
    bill.customer_payment_month_and_re
    create!
  end
  #GET search
  #显示查询窗口
  def search
    render :partial => "search"
  end
  #GET short_fee_info/1/export_excel
  def export_excel
    @customer_payment_info = resource_class.find(params[:id],:include => [:from_org,:user,:customer_payment_info_lines])
    xls = render_to_string(:partial => "excel",:layout => false)
    send_data xls,:filename => "customer_payment_info.xls"
  end
  #需要重写collection方法
  protected
  def collection
    @search = end_of_association_chain.where(["customer_payment_infos.from_org_id in (?) ",current_user.current_ability_org_ids]).search(params[:search])
    get_collection_ivar || set_collection_ivar(@search.select("DISTINCT #{resource_class.table_name}.*").order(sort_column + ' ' + sort_direction).paginate(:page => params[:page]))
  end
end
