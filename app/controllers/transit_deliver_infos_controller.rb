# -*- encoding : utf-8 -*-
#coding: utf-8
class TransitDeliverInfosController < BaseController
  table :bill_date,:org,:human_state_name,:user,:note
  def create
    @transit_deliver_info = TransitDeliverInfo.new(params[:transit_deliver_info])
    @transit_deliver_info.carrying_bill_ids = params[:bill_ids] unless params[:bill_ids].blank?
    @transit_deliver_info.carrying_bills.each_with_index do |bill,index|
      bill.transit_hand_fee = params[:transit_hand_fee_edit][index]
    end
    @transit_deliver_info.process
    create!
  end
  #GET search
  #显示查询窗口
  def search
    render :partial => "search"
  end
end
