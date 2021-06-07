# -*- encoding : utf-8 -*-
class BaseController < InheritedResources::Base
  include InheritedResources::TableBuilder
  authorize_resource :except => :index
  before_filter :pre_process_search_params,:only => [:index]
  before_filter :get_unread_messages,:sum_carrying_fee_rpt
  helper_method :sort_column,:sort_direction,:resource_name,:resources_name,:show_view_columns,:last_modified
  respond_to :html,:xml,:js,:json,:csv
  protected
  def collection
    @search = end_of_association_chain.accessible_by(current_ability,:read_with_conditions).search(params[:search])
    set_collection_ivar(@search.select("DISTINCT #{resource_class.table_name}.*").order(sort_column + ' ' + sort_direction).paginate(:page => params[:page])) end
  #压缩js response
  require "jsmin"
  def minify(content)
    min = Smurf::Javascript.new(content)
    min.minified
  end
  #处理导出文件时的显示或隐藏字段
  def show_or_hide_fields_for_export(html_str)
    require 'nokogiri'
    doc = Nokogiri::HTML(html_str)
    #处理显示问题
    show_fields = params[:show_fields]
    hide_fields = params[:hide_fields]
    #如果显示carrying_fee_total,carrying_fee_total_th,k_carrying_fee_total,则显示关联发货短途及到货短途
    #show_relate_fields = ""
    #show_relate_fields +=',.from_short_carrying_fee,.to_short_carrying_fee' if show_fields.try(:include?,'.carrying_fee_total')
    #show_relate_fields +=',.from_short_carrying_fee_th,.to_short_carrying_fee_th' if show_fields.try(:include?,'.carrying_fee_th_total')
    #show_relate_fields +=',.k_from_short_carrying_fee,.k_to_short_carrying_fee' if show_fields.try(:include?,'.k_carrying_fee_total')
    #show_fields += show_relate_fields if show_fields.present?

    doc.css(show_fields).remove_class('hide') if show_fields.present?
    doc.css(hide_fields).remove() if hide_fields.present?
    doc.css(".hide").remove()
    doc.css('th').attr("style","border : thin solid #000;height : 8mm;text-align : center;")
    doc.css('td').attr("style","border : thin solid #000;height : 8mm;")
    doc.to_s
  end
  private
  #排序方法
  #见http://asciicasts.com/episodes/228-sortable-table-columns
  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"
  end
  def sort_column
    params[:sort].present? ? params[:sort] : "#{resource_class.table_name}.created_at"
  end
  def show_view_columns
    resource_class.columns.collect{|column| column.name.to_sym  }
  end

  def resource_name
    resource_class.model_name.human
  end

  def resources_name
    resource_name.pluralize
  end
  protected
  #处理查询时,传入的机构代码,如果传入的机构有下级机构,则进行处理
  def pre_process_search_params
    return if params[:search].blank?
    new_search_params ={}
    #保存原有查询参数
    params[:origin_search] = params[:search].deep_dup
    params[:search].each do |key,value|
      if  ['carrying_bills_from_org_id_eq','carrying_bills_to_org_id_eq','carrying_bills_transit_org_id_eq',
          'carrying_bills_to_org_id_or_carrying_bills_transit_org_id_eq',
          'from_org_id_eq','to_org_id_eq',
          'from_org_id_or_to_org_id_eq',
          'transit_org_id_eq','to_org_id_or_transit_org_id_eq'].include?(key) and value.present? and (the_org = Org.includes(:children).find(value)).children.present?
        change_key = key.to_s.gsub(/_eq/,'_in')
        new_search_params[change_key] = [value] + the_org.children.collect(&:id)
        new_search_params[key]= nil
      end
    end
    params[:search].merge!(new_search_params) if new_search_params.present?
    params[:search]
  end

  #根据传入参数判断哪个是最近日期,如果什么都不传,则返回当前时间
  def last_modified(objs = [])
    default_array = [current_user.updated_at,Date.today.beginning_of_day,Org.first(:order => 'updated_at DESC').try(:updated_at),Role.first(:order => "updated_at DESC").try(:updated_at)]
    if objs.present?
      #控制当前页面是否刷新缓存的因素有三个:当前用户/当前用户默认机构/当前用户默认角色,三个页面中任何一个发生改变,都要重新缓存
      tmp_obj = objs.is_a?(Array) ? objs : [objs]
      default_array += tmp_obj
    end
    default_array.compact!
    default_array.max
  end
  #生成etag,用于缓存页面
  def etag(prefix = "")
    ret = "#{current_user.id}_#{current_user.default_role.id}_#{current_user.default_org.id}"
    ret = "#{prefix}_#{ret}" if prefix.present?
    ret
  end
  def get_unread_messages
    #获取未读消息
    #用户创建后只读取创建日期后的消息
    secure_messages = Message.unread_secure(current_user.id)#.where(["publish_date >= ?",current_user.created_at.to_date]).all
    public_messages = Message.unread_public(current_user.id)#.where(["publish_date >= ?",current_user.created_at.to_date]).all
    @unread_messages = secure_messages + public_messages
  end

  #获取当前机构当月实提运费合计
  def sum_carrying_fee_rpt
    @sum_cur_mth_carrying_fee_by_to_org = CarryingFeeThRpt.sum_cur_mth_carrying_fee_by_to_org(current_user.current_ability_org_ids)
    @sum_cur_mth_carrying_fee_by_from_org = CarryingFeeThRpt.sum_cur_mth_carrying_fee_by_from_org(current_user.current_ability_org_ids)
  end
end
