#coding: utf-8
#分理处/分公司营业额统计图
class RptFromOrgMthsController < BaseController
  #GET rpt_from_org_mts/data.json
  #获取需要统计的数据
  def data
    org_ids = params[:org_ids]
    mths = params[:mths]
    from_mth = params[:from_mth]
    to_mth = params[:to_mth]
    fee_type = params[:fee_type]
    data_to_org = params[:data_to_org].present? ? true : false
    if from_mth.present? and to_mth.present?
      if data_to_org
        @rpt_from_org_mths = RptFromOrgMth.where(["to_org_id in (?) AND mth >= ? AND mth <= ?",org_ids,from_mth,to_mth])
      else
        @rpt_from_org_mths = RptFromOrgMth.where(["from_org_id in (?) AND mth >= ? AND mth <= ?",org_ids,from_mth,to_mth])
      end
    end
    if mths.present?
      if data_to_org
        @rpt_from_org_mths = RptFromOrgMth.where(["to_org_id in (?) AND mth in (?) ",org_ids,mths])
      else
        @rpt_from_org_mths = RptFromOrgMth.where(["from_org_id in (?) AND mth in (?) ",org_ids,mths])
      end
    end
    respond_to do |format|
      format.json {render :json => {:result => @rpt_from_org_mths,:orgs => Org.where(:id => params[:org_ids])}}
    end
  end

  #按照选择月份进行查询
  #GET rpt_from_org_mths/before_data_with_selected_mths
  def before_data_with_selected_mths ; end
end
