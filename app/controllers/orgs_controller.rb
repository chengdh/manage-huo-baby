# -*- encoding : utf-8 -*-
class OrgsController < BaseController
  #使用http缓存数据到客户端
  #http_cache :index,:last_modified => Proc.new {|c| c.send(:last_modified)},:etag => Proc.new {|c| c.send(:etag,"org_index")}
  skip_before_filter :authenticate_user!,:only => [:index]
  skip_authorize_resource :only => :index

  #提取所有机构
  def index
    @orgs = Org.search(params[:search]).order('parent_id ASC,created_at DESC')
    respond_to do |format|
      format.xml {render :xml => @orgs.to_xml(:dasherize => false,:skip_types => true)}
      format.json {render :json => @orgs }
      format.html
    end
  end
  def new
    set_resource_ivar(resource_class.new_with_config)
    new! do |format|
      format.js {render :partial => "form"}
    end
  end
  def edit
    super do |format|
      format.js {render :partial => "form"}
    end
  end
  #显示到货地选择窗口
  #GET orgs/:id/show_org_permits
  def show_org_permits
    @org = Org.find(params[:id])
    render :partial => "form_org_permit"
  end
end
