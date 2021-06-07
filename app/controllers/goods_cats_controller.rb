#coding: utf-8
#货物分类
class GoodsCatsController < BaseController
  #使用http缓存数据到客户端
  #http_cache :index,:last_modified => Proc.new {|c| c.send(:last_modified)},:etag => Proc.new {|c| c.send(:etag,"goods_cat_index")}
  #提取所有机构
  def index
    @goods_cats = GoodsCat.search(params[:search]).order('parent_id ASC,easy_code ASC')
  end
  def new
    super do |format|
      format.js {render :partial => "form"}
    end
  end
  def edit
    super do |format|
      format.js {render :partial => "form"}
    end
  end
end
