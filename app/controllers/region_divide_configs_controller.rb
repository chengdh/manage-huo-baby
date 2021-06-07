#coding: utf-8
class RegionDivideConfigsController < BaseController
  table :from_region,:to_region,:from_rate,:to_rate,:summary_rate,:is_active

  #GET region_divide_configs/get_config
  #获取设置信息
  #params[:] from_org_id_eq
  #param to_org_id_eq
  def get_config
    @region_divide_config = RegionDivideConfig.get_config(params[:from_org_id_eq],params[:to_org_id_eq])
    respond_to do |format|
      format.json {render :json => @region_divide_config }
    end
  end

end
