#coding: utf-8
#同城配送-运输清单
class LocalTownLoadList < BaseLoadList
  def self.auto_load_and_send
    admin = User.first
    bills = CarryingBill.where(:completed => false,
                               :state => :billed,
                               :load_list_id => nil,
                               # :bill_date => 1.days.ago.strftime("%Y-%m-%d"),
                               :type => %w(LocalTownBill HandLocalTownBill)
                              )

    group_bills = bills.group_by do |b|
      [b.from_org,b.to_org]
    end
    #分别生成load_bills
    group_bills.each do |from_to_orgs,bills|
      bill_no = "#{Date.today.strftime("%Y%m%d")}#{from_to_orgs.first.simp_name}#{from_to_orgs.last.simp_name}"
      local_town_load_list = LocalTownLoadList.new(:from_org => from_to_orgs.first,:to_org => from_to_orgs.last,:bill_no => bill_no,:user_id => admin.id,:note => "系统自动生成装货清单")
      bill_ids = bills.map {|b| b.id}
      local_town_load_list.carrying_bill_ids = bill_ids
      #装车;发货
      local_town_load_list.process;local_town_load_list.process
    end
  end
end
