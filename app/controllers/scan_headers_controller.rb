#coding: utf-8
class ScanHeadersController < BaseController
  include BillOperate
  table :from_org,:to_org,:bill_date,:user,:human_state_name
  #GET search
  #显示查询窗口
  def search
    render :partial => "shared/scan_headers/search"
  end
end
