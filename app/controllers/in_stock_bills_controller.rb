#coding: utf-8
#实际未提货物清单
class InStockBillsController < BaseController
  table :org,:bill_date,:bills_count,:sum_goods_fee,:sum_carrying_fee_th,
    :sum_from_short_carrying_fee_th,:sum_to_short_carrying_fee_th,:sum_insured_fee_th,:sum_manage_fee_th,:human_state_name

  #POST in_stock_bills
  def create
    @in_stock_bill = InStockBill.new(params[:in_stock_bill])
    params[:bill_ids].each do |b_id|
      @in_stock_bill.in_stock_bill_lines.build(:carrying_bill_id => b_id)
    end
    @in_stock_bill.process
    create!
  end
  #GET search
  #查询
  def search;render :partial => "search"; end
  #GET in_stock_bill/:id/export_excel
  def export_excel
    @in_stock_bill = resource_class.find(params[:id],:include => [:org,:op_org,:user,:carrying_bills])
    xls = render_to_string(:partial => "excel",:layout => false)
    send_data show_or_hide_fields_for_export(xls),:filename => "in_stock_bills.xls"
  end
  #GET in_stock_bills/batch_input
  def batch_input 
    @in_stock_bill = InStockBill.new
  end

  #需要重写collection方法,用于处理分公司/分理处和总部可以查看数据的限制
  #分理处/分公司:只能看到自己的数据
  #总部:可看到所有的数据
  protected
  def collection
    @search = end_of_association_chain.where(["in_stock_bills.org_id = ? or in_stock_bills.op_org_id =?",current_user.default_org.id,current_user.default_org.id]).search(params[:search])
    get_collection_ivar || set_collection_ivar(@search.select("DISTINCT #{resource_class.table_name}.*").order(sort_column + ' ' + sort_direction).paginate(:page => params[:page]))
  end
end
