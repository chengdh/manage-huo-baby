#coding: utf-8
class InnerTransitRefundObserver < ActiveRecord::Observer
  #NOTE 暂时注释
  def after_create(inner_transit_refund)
    #查找当天的汇款记录,如果找不到则新建
    r = Remittance.where(:bill_date => inner_transit_refund.bill_date,:from_org_id => inner_transit_refund.from_org_id,:to_org_id => inner_transit_refund.transit_org_id).limit(1).first
    if r.blank?
      r = inner_transit_refund.create_remittance(:state => :draft,
                                                 :from_org => inner_transit_refund.from_org,
                                                 :to_org => inner_transit_refund.transit_org,
                                                 :user => inner_transit_refund.user,
                                                 :inner_transit_refund_should_fee => inner_transit_refund.sum_th_amount)
    else
      r.update_attributes(:inner_transit_refund_should_fee => r.inner_transit_refund_should_fee + inner_transit_refund.sum_th_amount)
    end
  end
end
