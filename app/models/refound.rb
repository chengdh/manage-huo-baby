# -*- encoding : utf-8 -*-
#返款清单
class Refound < BaseRefund
  #自动生成返款清单,仅仅针对1级分公司生成
  #from_summary_org_id  收款机构(应是总公司)
  def self.auto_generate_refund(from_summary_org_id)
    admin = User.find_by_username("admin")
    from_summary_org = Org.find(from_summary_org_id)
    from_child_org_ids = from_summary_org.children.map {|c| c.id}
    from_all_org_ids = from_child_org_ids + [from_summary_org_id]

    Org.branch_list.each do |b|
      to_child_branch_ids = Org.branch_list_ids(b.id)
      to_all_org_ids = to_child_branch_ids + [b.id]
      bills = CarryingBill.where(:to_org_id => to_all_org_ids ,:from_org_id => from_all_org_ids,:state => 'settlemented',
                                 :type => ['ComputerBill', 'HandBill', 'ReturnBill',  'AutoCalculateComputerBill'],
                                 :completed => false )

      if bills.present?
        bill_ids = bills.map {|bill| bill.id}
        refund = Refound.new(:from_org_id => b.id,:to_org_id => from_summary_org_id,:user_id => admin.id,:note => "系统自动生成返款清单")
        refund.carrying_bill_ids = bill_ids
        refund.process
      end
    end
  end

  #自动生成返款清单-针对总部
  def self.auto_generate_refund_for_summary_org(to_summary_org_id)
    admin = User.find_by_username("admin")

    to_department_ids = Org.branch_list_ids(to_summary_org_id)

    from_branches = Org.branch_list
    from_branches.each do |b|
      from_child_branch_ids = Org.branch_list_ids(b.id)
      from_all_org_ids = from_child_branch_ids + [b.id]
      bills = CarryingBill.where(:from_org_id => from_all_org_ids ,:to_org_id => to_department_ids,:state => 'settlemented',
                                 :type => ['ComputerBill', 'HandBill', 'ReturnBill',  'AutoCalculateComputerBill'],
                                 :completed => false )

      if bills.present?
        bill_ids = bills.map {|bill| bill.id}
        refund = Refound.new(:from_org_id => to_summary_org_id,:to_org_id => b.id,:user_id => admin.id,:note => "系统自动生成返款清单")
        refund.carrying_bill_ids = bill_ids
        refund.process
      end
    end
  end

  #自动生成返款清单-针对总部
  #FIXME 20160827 数据恢复用
  def self.generate_refund_for_summary_org_for_restore(to_summary_org_id,refund_date)
    admin = User.find_by_username("admin")

    to_department_ids = Org.branch_list_ids(to_summary_org_id)

    from_branches = Org.branch_list
    from_branches.each do |b|
      from_child_branch_ids = Org.branch_list_ids(b.id)
      from_all_org_ids = from_child_branch_ids + [b.id]
      bills = CarryingBill.where(:from_org_id => from_all_org_ids ,
                                 :to_org_id => to_department_ids,
                                 :state => 'refunded',
                                 :bill_date_gte => '2016-05-01',
                                 :bill_date_lte => '2016-08-20',
                                  :refound_id_is_null => true,
                                 :type => ['ComputerBill', 'HandBill', 'ReturnBill',  'AutoCalculateComputerBill'],
                                 :completed => false )

      if bills.present?
        bill_ids = bills.map {|bill| bill.id}
        refund = Refound.new(:from_org_id => to_summary_org_id,:to_org_id => b.id,:user_id => admin.id,:note => "系统自动生成返款清单")
        refund.carrying_bill_ids = bill_ids
        refund.save!
      end
    end
  end


  #重新生成分公司返款清单
  def self.generate_refund_for_branch_org(from_summary_org_id,refund_date)
    admin = User.find_by_username("admin")
    from_summary_org = Org.find(from_summary_org_id)
    from_child_org_ids = from_summary_org.children.map {|c| c.id}
    from_all_org_ids = from_child_org_ids + [from_summary_org_id]

    Org.branch_list.each do |b|
      to_child_branch_ids = Org.branch_list_ids(b.id)
      to_all_org_ids = to_child_branch_ids + [b.id]
      bills = CarryingBill.search(:from_org_id_in => from_all_org_ids ,:to_org_id_in => to_all_org_ids ,
                                  :state_in => ['refunded'],
                                  :type_in => ['ComputerBill', 'HandBill', 'ReturnBill',  'AutoCalculateComputerBill'],
                                  :bill_date_gte => '2016-05-01',
                                  :bill_date_lte => '2016-08-20',
                                  :refound_id_is_null => true,
                                  :completed_eq => false ).all


      if bills.present?
        bill_ids = bills.map {|bill| bill.id}
        refund = Refound.new(:from_org_id => b.id,:to_org_id => from_summary_org_id,:bill_date => refund_date,:user_id => admin.id,:note => "系统自动生成返款清单")
        refund.carrying_bill_ids = bill_ids
        refund.save!
      end
    end
  end
  def self.generate_refund_for_branch_org_with_state_deliveried(from_summary_org_id,refund_date)
    admin = User.find_by_username("admin")
    from_summary_org = Org.find(from_summary_org_id)
    from_child_org_ids = from_summary_org.children.map {|c| c.id}
    from_all_org_ids = from_child_org_ids + [from_summary_org_id]

    Org.branch_list.each do |b|
      to_child_branch_ids = Org.branch_list_ids(b.id)
      to_all_org_ids = to_child_branch_ids + [b.id]
      bills = CarryingBill.search(:from_org_id_in => from_all_org_ids ,:to_org_id_in => to_all_org_ids ,:state_eq => 'deliveried',
                                 :type_in => ['ComputerBill', 'HandBill', 'ReturnBill',  'AutoCalculateComputerBill'],
                                 :bill_date_gte => '2016-05-01',
                                 :bill_date_lte => '2016-08-20',
                                 :completed_eq => false ).all


      if bills.present?
        bill_ids = bills.map {|bill| bill.id}
        refund = Refound.new(:from_org_id => b.id,:to_org_id => from_summary_org_id,:bill_date => refund_date,:user_id => admin.id,:note => "系统自动生成返款清单")
        refund.carrying_bill_ids = bill_ids
        refund.save!
      end
    end
  end
end
