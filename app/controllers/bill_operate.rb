# -*- encoding : utf-8 -*-
module BillOperate
  def create
    bill = resource_class.new(params[resource_class.model_name.underscore])
    bill.carrying_bill_ids  = params[:bill_ids]  unless params[:bill_ids].blank?
    get_resource_ivar || set_resource_ivar(bill)
    bill.process
    create!
  end
  #PUT/:id/process_handle
  def process_handle
    bill = resource_class.find(params[:id])
    bill = resource_class.includes(:carrying_bills).find(params[:id]) if bill.respond_to? :carrying_bills
    get_resource_ivar || set_resource_ivar(bill)
    bill.process
    #判断是否需要修改数据
    if params[:update_attrs].present?
      bill.update_attributes(params[:update_attrs])
    end
    if bill.valid?
      flash[:success] = "数据处理成功!"
    else
      err_msg = ""
      bill.errors.full_messages.each do |m|
        err_msg += m
      end
      flash[:error] = err_msg
    end
    redirect_to  :action => :show
  end
=begin
  protected
  #重写create_resource,提高执行速度
  def create_resource(object)
    CarryingBill.transaction do
      foreign_key = resource_class.reflect_on_association(:carrying_bills).foreign_key
      object.save
      CarryingBill.where(:completed => false,:id => params[:bill_ids]).update_all(foreign_key => object.id) unless params[:bill_ids].blank?
      object.process
    end
  end
=end

  #票据打印
  module BillPrint
    #PUT computer_bills/:id/print_counter
    #打印计数,每打印一次,计数+1
    def print_counter
      bill = resource_class.find(params[:id])
      get_resource_ivar || set_resource_ivar(bill)
      resource_class.increment_counter(:print_counter,bill.id)
      render :nothing => true
    end
  end
end