#coding: utf-8
#结算员交款清单
class Settlement < BaseSettlement
  #自动生成结算员交款清单
  def self.auto_generate_settlement

    admin = User.find_by_username("admin")
    #只是生成分理处及一级分公司的结算员交款清单
    orgs = Org.branch_list
    orgs += Org.department_list

    orgs.each do |b|
      child_branch_ids = Org.branch_list_ids(b.id)
      all_org_ids = child_branch_ids + [b.id]
      bills = CarryingBill.where(:to_org_id => all_org_ids ,:state => 'deliveried',:type => ['ComputerBill', 'HandBill', 'ReturnBill',  'AutoCalculateComputerBill'],:completed => false )
      if bills.present?
        bill_ids = bills.map {|bill| bill.id}
        settlement = Settlement.new(:bill_date => Date.today,:org_id => b.id,:user_id => admin.id,:note => "系统自动生成结算清单")
        settlement.carrying_bill_ids = bill_ids
        #处理结算清单
        settlement.process
      end
    end
  end


  #根据提货状态生成结算单
  def self.generate_settlement_for_deliveried(set_date)

    admin = User.find_by_username("admin")
    #只是生成分理处及一级分公司的结算员交款清单
    orgs = Org.branch_list
    orgs += Org.department_list

    orgs.each do |b|
      child_branch_ids = Org.branch_list_ids(b.id)
      all_org_ids = child_branch_ids + [b.id]
      bills = CarryingBill.search(:to_org_id_eq => all_org_ids ,
                                 :state_eq => 'deliveried',
                                 :type_in => ['ComputerBill', 'HandBill', 'ReturnBill',  'AutoCalculateComputerBill'],
                                 :bill_date_gte => '2016-05-01',
                                 :bill_date_lte => '2016-08-20',
                                 :deliver_info_id_is_null => true,
                                 :completed_eq => false ).all
      if bills.present?
        bill_ids = bills.map {|bill| bill.id}
        settlement = Settlement.new(:bill_date => set_date,:org_id => b.id,:user_id => admin.id,:note => "系统自动生成结算清单")
        settlement.carrying_bill_ids = bill_ids
        #处理结算清单
        settlement.process
      end
    end
  end

  #从settlement状态生成结算清单
  def self.generate_settlement_for_settlemented(set_date)

    admin = User.find_by_username("admin")
    #只是生成分理处及一级分公司的结算员交款清单
    orgs = Org.branch_list
    orgs += Org.department_list

    orgs.each do |b|
      child_branch_ids = Org.branch_list_ids(b.id)
      all_org_ids = child_branch_ids + [b.id]
      bills = CarryingBill.search(:to_org_id_eq => all_org_ids ,
                                 :state_eq => 'settlemented',
                                 :type_in => ['ComputerBill', 'HandBill', 'ReturnBill',  'AutoCalculateComputerBill'],
                                 :bill_date_gte => '2016-05-01',
                                 :bill_date_lte => '2016-08-20',
                                 :settlement_id_is_null => true,
                                 :completed_eq => false ).all
      if bills.present?
        bill_ids = bills.map {|bill| bill.id}
        settlement = Settlement.new(:bill_date => set_date,
                                    :state => "settlemented",
                                    :org_id => b.id,
                                    :user_id => admin.id,
                                    :note => "系统自动生成结算清单")
        settlement.carrying_bill_ids = bill_ids
        settlement.save!
      end
    end
  end
end
