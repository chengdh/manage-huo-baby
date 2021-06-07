#coding: utf-8
class VipsController < BaseController
  table :org_id,:code,:name,:phone,:mobile,:bank_id,:bank_card,:level_star,:id_number,:company,:human_vip_state_name,:created_at
  #GET search
  #显示查询窗口
  def search
    @search = resource_class.search(params[:search])
    render :partial => "search",:object => @search
  end
  def index
    super do |format|
      format.csv {send_data resource_class.to_csv(@search)}
    end
  end

  #审核draft状态的vip
  #PUT vips/:id/audit
  def audit
    @vip = Vip.find(params[:id])
    @vip.audit
    render :action => :show
  end

  #导出查询结果为excel
  #GET carrying_bills/export_excel
  def export_excel
    @search = end_of_association_chain.accessible_by(current_ability,:read_with_conditions).search(params[:search])
    xls = render_to_string(:partial => "excel",:layout => false)
    send_data xls,:filename => "vips.xls"
  end


  #同步运单的发货人名称
  #PUT vip/:id/syn_from_customer_name
  def syn_from_customer_name
    @vip = Vip.find(params[:id])
    @vip.syn_from_customer_name
    flash[:notice]="同步发货人名称完毕!"
    render :action => :show
  end
end
