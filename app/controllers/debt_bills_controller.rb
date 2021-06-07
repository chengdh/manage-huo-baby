#coding: utf-8
#欠款提货清单
class DebtBillsController < BaseController
  table :org,:bill_date,:bills_count,:sum_goods_fee,:sum_carrying_fee_th,
    :sum_from_short_carrying_fee_th,:sum_to_short_carrying_fee_th,:sum_insured_fee_th,:sum_manage_fee_th,:sum_fine,:human_state_name

  #POST in_stock_bills
  def create
    @debt_bill = DebtBill.new(params[:debt_bill])
    params[:bill_ids].each do |b_id|
      @debt_bill.debt_bill_lines.build(:carrying_bill_id => b_id)
    end
    @debt_bill.process
    create!
  end

  #GET search
  #查询
  def search;render :partial => "search"; end
  #GET in_stock_bill/:id/export_excel
  def export_excel
    @debt_bill = resource_class.find(params[:id],:include => [:org,:op_org,:user,:carrying_bills])
    xls = render_to_string(:partial => "excel",:layout => false)
    send_data show_or_hide_fields_for_export(xls),:filename => "debt_bill.xls"
  end

  #需要重写collection方法,用于处理分公司/分理处和总部可以查看数据的限制
  #分理处/分公司:只能看到自己的数据
  #总部:可看到所有的数据
  protected
  def collection
    @search = end_of_association_chain.where(["debt_bills.org_id = ? or debt_bills.op_org_id =?",current_user.default_org.id,current_user.default_org.id]).search(params[:search])
    get_collection_ivar || set_collection_ivar(@search.select("DISTINCT #{resource_class.table_name}.*").order(sort_column + ' ' + sort_direction).paginate(:page => params[:page]))
  end
end
