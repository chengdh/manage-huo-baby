# -*- encoding : utf-8 -*-
#coding: utf-8
class JournalsController < BaseController
  table :bill_date,:org_id,:user_id
  def new
    @journal = Journal.find_by_org_id_and_bill_date(current_user.default_org.id,Date.today)
    if @journal.present?
      redirect_to @journal
    else
      @journal = Journal.new_with_org(current_user.default_org) if @journal.blank?
    end
  end
  #GET search
  #显示查询窗口
  def search
    @search = resource_class.search(params[:search])
    render :partial => "search",:object => @search
  end
  def show
    super do |format|
      format.csv {send_data resource.to_csv}
    end
  end
end

