#coding: utf-8
#用于处理从客户端传入的json请求
class Api::V1::DatasetsController < ApplicationController
  before_filter :process_args
  respond_to :json
  #POST /api/vi/datasets/search_read
  #根据客户端传入的请求从数据库中读取数据
  #params[:model]  model name 类似 org,load_list
  #params[:fields]  要返回的字段,用,分割
  #params[:domain] 过滤条件,与meta_search的传递方式类似
  #params[:limit]  数字,限制返回的记录数
  #params[:offset]  数字,记录偏移
  #params[:sort]    排序条件DESC或ASC
  def search_read
    model_clazz = params[:model].classify.constantize
    fields = params[:fields].join(",")
    domain = params[:domain]
    limit = params[:limit].to_i
    limit = 50 if limit == 0
    offset = params[:offset].to_i
    sort = params[:sort]
    sort = "id ASC" if sort.blank?
    @dataset = model_clazz.select(fields).limit(limit).offset(offset).order(sort).search(domain).all
    render :json => {:result => @dataset}
  end

  #POST /api/v1/datasets/call_kw
  #根据传入的参数调用model的方法
  #@params string model modle名称
  #@params string method 要调用的方法
  #@params array args 参数
  #@params int  id model主键
  def call_kw
    model_clazz = params[:model].classify.constantize
    method = params[:method]

    if params[:id].present?

      record = model_clazz.find(params[:id])
      if params[:args].present?
        dataset = record.send(method,*params[:args])
      else

        dataset = record.send(method)
      end
    else
      if params[:args].present?
        dataset = model_clazz.send(method,*params[:args])
      else
        dataset = model_clazz.send(method)
      end
    end
    if dataset.respond_to? :to_json_for_app
      render :json => {:result => JSON.parse(dataset.to_json_for_app)}
    else
      render :json => {:result => dataset}
    end
  end
  private
  #FIXME find方法中,conditons必须是symbol,不能是string
  def process_args
    if params[:args].present?
      params[:args].each_with_index do |a,idx|
        if a.kind_of?(Hash)
          new_hash = a.symbolize_keys
          params[:args][idx] = new_hash
        end
      end
    end
  end
end
