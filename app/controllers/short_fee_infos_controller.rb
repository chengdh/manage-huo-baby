# -*- encoding : utf-8 -*-
class ShortFeeInfosController < BaseController
  table :bill_date,:org,:human_state_name,:sum_write_off_fee,:write_off_date,:note
  def create
    bill = resource_class.new(params[resource_class.model_name.underscore])
    get_resource_ivar || set_resource_ivar(bill)
    params[:bill_ids].each do
      |id| bill.short_fee_info_lines.build(:carrying_bill_id => id)
    end
    bill.write_off
    create!
  end
  #GET search
  #显示查询窗口
  def search
    render :partial => "search"
  end
  #GET short_fee_info/1/export_excel
  def export_excel
    @short_fee_info = resource_class.find(params[:id],:include => [:org,:user,:short_fee_info_lines])
  end

  #GET short_fee_info/1/export_excel_for_kingdee
  def export_excel_for_kingdee
    @short_fee_info = resource_class.find(params[:id],:include => [:org,:user,:short_fee_info_lines])
  end

  #核销短途运费信息
  #PUT short_fee_infos/:id/write_off
  def write_off
    @short_fee_info = resource_class.find(params[:id])
    @short_fee_info.write_off
    flash[:notice] = "核销短途运费信息成功."
    render :show
  end

  #生成凭证
  #GET short_fee_infos/:id/build_accounting_document
  def build_accounting_document
    @short_fee_info = resource_class.find(params[:id])
    @cr_lines,@dr_lines,@cr_detail_lines,@dr_detail_lines,@context = @short_fee_info.build_accounting_document
  end

  #需要重写collection方法
  protected
  def collection
    @search = end_of_association_chain.where(["short_fee_infos.org_id = ? or short_fee_infos.op_org_id =?",current_user.default_org.id,current_user.default_org.id]).search(params[:search])
    get_collection_ivar || set_collection_ivar(@search.select("DISTINCT #{resource_class.table_name}.*").order(sort_column + ' ' + sort_direction).paginate(:page => params[:page]))
  end
end
