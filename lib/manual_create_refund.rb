#coding: utf-8
admin_id = 1
transit_org_id = 2
bills = CarryingBill.search(:type_in => ['InnerTransitBill','HandInnerTransitBill'],:completed_eq => false,:state_eq => "settlemented",:bill_date_lt => '2015-03-15')
group_bills = bills.group_by {|b| [b.from_org_id,b.to_org_id]}
group_bills.each do |k,v|
  bill_ids = v.map {|b| b.id}
  refund = InnerTransitRefund.new(:from_org_id => k.first,:to_org_id => k.last,:transit_org_id => transit_org_id,:note => "手工调整生成",:user_id => admin_id)
  refund.carrying_bill_ids = bill_ids
  refund.process
  refund.save!
end
