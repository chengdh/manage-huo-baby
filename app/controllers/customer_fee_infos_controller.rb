# -*- encoding : utf-8 -*-
#coding: utf-8
class CustomerFeeInfosController < BaseController
  table :org,:mth,:user,:created_at
  #GET /customer_fee_infos/search
  def search
    render :partial => "search"
  end
  #GET /customer_fee_infos/:id
  #导出到csv
  def show
    super do |format|
      format.csv {send_data resource.to_csv}
    end
  end
end

