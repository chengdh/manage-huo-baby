#coding: utf-8
#同城快运-返款单
class LocalTownRefund < BaseRefund
  #自动生成返款清单
  #from_summary_org_id  收款机构(应是总公司)
  def self.auto_generate_refund(from_summary_org_id)
    admin = User.first
    #只是生成分理处及一级分公司的结算员交款清单
    from_orgs = Org.department_list
    to_orgs = Org.department_list

    from_orgs.each do |f_org|
      to_orgs.each do |t_org|
        bills = CarryingBill.where(:from_org_id => f_org.id,:to_org_id => t_org.id ,:state => 'settlemented',:type => ['LocalTownBill', 'HandLocalTownBill'],:completed => false )
        if bills.present?
          bill_ids = bills.map {|bill| bill.id}
          refund = LocalTownRefound.new(:from_org_id => b.id,:to_org_id => from_summary_org_id,:user_id => admin.id,:note => "系统自动生成返款清单")
          refund.carrying_bill_ids = bill_ids
          refund.process
        end
      end
    end
  end
end
