# -*- encoding : utf-8 -*-
#coding: utf-8
class TransitInfosController < BaseController
  table :bill_date,:org,:transit_company,:user,:note,:human_state_name
  def create
    @transit_info = TransitInfo.new(params[:transit_info])
    @transit_info.carrying_bill_ids = params[:bill_ids] unless params[:bill_ids].blank?
    @transit_info.carrying_bills.each_with_index do |bill,index|
      bill.transit_carrying_fee = params[:transit_carrying_fee_edit][index]
      bill.transit_bill_no = params[:transit_bill_no_edit][index]
      bill.transit_to_phone = params[:transit_to_phone_edit][index]
    end
    @transit_info.process
    create!
  end

  def new
    @transit_info = TransitInfo.new(params[:transit_info])
    @transit_info.transit_company = TransitCompany.new
  end
  #GET search
  #显示查询窗口
  def search
    render :partial => "search"
  end
end

