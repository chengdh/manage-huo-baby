#coding: utf-8
class DeliverInfosController < BaseDeliverInfosController
  defaults :resource_class => DeliverInfo
  # before_filter :check_settlemented,:only => :new
  private
  #判断是否已结算
  def check_settlemented
    if Settlement.exists?(:org_id => current_user.default_org_id,:bill_date => Date.today)
      flash[:error] = "当日结算后不可再作提货操作!!"
      redirect_to :action => :index
    end
  end
end
