#coding: utf-8
class GoodsCatFeeConfigsController < BaseController
  skip_before_filter :pre_process_search_params
  skip_authorize_resource :only => [:single_config_line]

  #显示批量调整按钮
  #GET goods_cat_fee_configs/:id/show_batch_adjust
  def show_batch_adjust
    respond_to do |format|
      format.js {render :partial => "batch_adjust"}
    end
  end
  #根据客户端传入的参数获取给定的货物分类的运费设置信息
  #GET goods_cat_fee_configs/single_config_line
  def single_config_line
    @goods_cat_fee_config_line = GoodsCatFeeConfigLine.search_line(params)
    respond_to do |format|
      format.json {render :json => @goods_cat_fee_config_line.to_json(:methods => :goods_cat_name ) }
    end
  end
  #GET goods_cat_fee_configs/:id/export_excel
  def export_excel
    @goods_cat_fee_config = resource_class.find(params[:id],:include => [:from_org,:to_org,:goods_cat_fee_config_lines])
    xls = render_to_string(:partial => "show",:layout => false)
    send_data show_or_hide_fields_for_export(xls),:filename => "goods_cat_fee_config.xls"
  end

  #从其他设置信息中拷贝价格
  #GET goods_cat_fee_configs/:id/copy_price
  def copy_price
    @goods_cat_fee_config = GoodsCatFeeConfig.find(params[:id])
    copy_from = GoodsCatFeeConfig.find(params[:copy_from_id])
    copy_from_lines = copy_from.goods_cat_fee_config_lines
    @goods_cat_fee_config.goods_cat_fee_config_lines.each do |l|
      copy_from_line = copy_from_lines.find {|cl| cl.goods_cat_id == l.goods_cat_id}
      l.unit_price = copy_from_line.unit_price; l.bottom_price = copy_from_line.bottom_price if copy_from_line.present?
    end
    render :action => :edit
  end
  protected
  #各个分公司只能看到与自己有关的设置
  def collection
    #分理处也可看到自身费用设置
    default_org = current_user.default_org
    where_sql = ["from_org_id = ? or to_org_id = ?",current_user.default_org_id,current_user.default_org_id]
    if default_org.parent.present?
      where_sql = ["from_org_id in (#{default_org.id},#{default_org.parent.id}) or to_org_id = ?",current_user.default_org_id]
    end
    @search = end_of_association_chain.where(where_sql).search(params[:search])
    get_collection_ivar || set_collection_ivar(@search.select("DISTINCT #{resource_class.table_name}.*").order(sort_column + ' ' + sort_direction).paginate(:page => params[:page]))
  end
end
