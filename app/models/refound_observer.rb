#coding: utf-8
class RefoundObserver < ActiveRecord::Observer
  def after_create(refund)
    # refund.create_remittance(:from_org => refund.from_org,:to_org => refund.to_org,:should_fee => refund.sum_th_amount)
    #查找当天的汇款记录,如果找不到则新建
    #NOTE 暂时注释
    r = Remittance.where(:bill_date => refund.bill_date,
                         :from_org_id => refund.from_org_id,
                         :to_org_id => refund.to_org_id).limit(1).first
    if r.blank?
      r = refund.create_remittance(:state => :draft,
                                   :from_org => refund.from_org,
                                   :to_org => refund.to_org,
                                   :user => refund.user,
                                   :should_fee => refund.sum_th_amount)
    else
      r.update_attributes(:should_fee => r.should_fee + refund.sum_th_amount)
    end
  end
end
