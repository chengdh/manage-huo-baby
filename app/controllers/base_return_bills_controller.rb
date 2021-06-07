#coding: utf-8
#退货单-基础类
class BaseReturnBillsController < CarryingBillsController
  include BillOperate::BillPrint
  before_filter :pre_process_search_params,:only => [:new]
  def before_new ; end
  def new
    if params[:search].blank? or params[:search][:bill_no_eq].blank?
      flash[:error] = "请录入原运单号码."
      render :action => :before_new
    else
      the_bills = CarryingBill.search(params[:search]).all
      if the_bills.blank?
        flash[:error] = "未找到原始运单信息,只有运单到货后才可退货."
        render :action => :before_new
      else
        original_bill = the_bills.first
        return_bill = original_bill.generate_return_bill
        get_resource_ivar || set_resource_ivar(return_bill)
        render :new
      end
    end
  end
  def create
    return_bill = resource_class.new(params[resource_class.model_name.underscore.to_sym])
    return_bill.original_bill.return
    get_resource_ivar || set_resource_ivar(return_bill)
    create!
  end
end
