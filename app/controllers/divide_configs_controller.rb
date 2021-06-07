#coding: utf-8
class DivideConfigsController < BaseController
  skip_authorize_resource :only => [:ton_volume_bill_divide_rate,:branch_bill_divide_rate]
  table :bill_type_des,:from_org,:from_org_divide_rate_des,:to_org,:to_org_divide_rate_des,:summary_org,:summary_org_divide_rate_des
  #GET divide_configs/ton_volume_bill_divide_rate
  #获取分成比例
  #search[:from_org_id_eq]
  #search[:to_org_id_eq]
  #search[:fee_unit_id_eq]
  def ton_volume_bill_divide_rate
    from_org_id = params[:search][:from_org_id_eq]
    to_org_id = params[:search][:to_org_id_eq]
    fee_unit_id = params[:search][:fee_unit_id_eq]
    divide_config = DivideConfig.get_ton_volume_bill_divide_rate(from_org_id,to_org_id,fee_unit_id)
    render :json => divide_config
  end

  #GET divide_configs/branch_bill_divide_rate
  #获取分成比例
  #search[:from_org_id_eq]
  #search[:to_org_id_eq]
  def branch_bill_divide_rate
    from_org_id = params[:search][:from_org_id_eq]
    to_org_id = params[:search][:to_org_id_eq]
    divide_config = DivideConfig.get_branch_bill_divide_rate(from_org_id,to_org_id)
    render :json => divide_config
  end
  #GET search
  #显示查询窗口
  def search
    @search = resource_class.search(params[:search])
    render :partial => "search"
  end
end
