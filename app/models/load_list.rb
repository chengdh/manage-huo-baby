#coding: utf-8
#普通货物运输清单
class LoadList < BaseLoadList
  #自动装车及发货处理
  #只是将当日运单装车
  #summary_org_id 总部货场
  #每晚12:20分运行
  def self.auto_load_and_send(summary_org_id,exclude_to_org_ids=[])
    summary_org = Org.find(summary_org_id)
    child_org_ids = summary_org.children.map {|c| c.id}

    admin = User.first
    bills = CarryingBill.where(:from_org_id => child_org_ids,
                               :transit_org_id => nil,
                               :completed => false,
                               :state => [:billed,:short_list_reached],
                               :load_list_id => nil,
                               # :bill_date => 3.days.ago.strftime("%Y-%m-%d"),
                               :type => %w(ComputerBill HandBill ReturnBill AutoCalculateComputerBill)
                              ).search(:bill_date_lte => 1.days.ago.strftime("%Y-%m-%d"),:to_org_id_ni => exclude_to_org_ids)
    # .search(:bill_date_lte => 1.days.ago.strftime("%Y-%m-%d"))

    group_bills = bills.group_by do |b|
      cur_to_org = Org.find(b.to_org_id)
      cur_to_org.parent_id.blank? ? cur_to_org.id : cur_to_org.parent.id
    end
    #分别生成load_bills
    group_bills.each do |to_org_id,bills|
      to_org = Org.find(to_org_id)
      bill_no = "#{Date.today.strftime("%Y%m%d")}#{summary_org.simp_name}#{to_org.simp_name}"
      load_list = LoadList.new(:from_org_id => summary_org_id,:to_org_id => to_org_id,:bill_no => bill_no,:user_id => admin.id,:note => "系统自动生成装货清单")
      bill_ids = bills.map {|b| b.id}
      load_list.carrying_bill_ids = bill_ids
      #装车;发货
      load_list.process;load_list.process
    end
  end
  def self.auto_load_and_send_for_billed(summary_org_id,exclude_to_org_ids=[],note="未扫描装车")
    summary_org = Org.find(summary_org_id)
    child_org_ids = summary_org.children.map {|c| c.id}

    admin = User.first
    bills = CarryingBill.where(:from_org_id => child_org_ids,
                               :transit_org_id => nil,
                               :completed => false,
                               :state => :billed,
                               :load_list_id => nil,
                               # :bill_date => 3.days.ago.strftime("%Y-%m-%d"),
                               :type => %w(ComputerBill HandBill ReturnBill AutoCalculateComputerBill)
                              ).search(:bill_date_lte => 1.days.ago.strftime("%Y-%m-%d"),:to_org_id_ni => exclude_to_org_ids)

    group_bills = bills.group_by do |b|
      cur_to_org = Org.find(b.to_org_id)
      cur_to_org.parent_id.blank? ? cur_to_org.id : cur_to_org.parent.id
    end
    #分别生成load_bills
    group_bills.each do |to_org_id,bills|
      to_org = Org.find(to_org_id)
      bill_no = "#{Date.today.strftime("%Y%m%d")}#{summary_org.simp_name}#{to_org.simp_name}"
      load_list = LoadList.new(:from_org_id => summary_org_id,:to_org_id => to_org_id,:bill_no => bill_no,:user_id => admin.id,:note => note)
      bill_ids = bills.map {|b| b.id}
      load_list.carrying_bill_ids = bill_ids
      #装车;发货
      load_list.process;load_list.process
    end
  end

  #将所有扫过条码的票据装车并发走
  #bill_date 要处理那一天的运单
  #FIXME 注意,如果是晚12点以后发车,bill_date应该提前一天
  def self.auto_load_and_send_for_scanded(bill_date,summary_org_id,exclude_to_org_ids=[],note="扫描票据自动装车")
    admin = User.first_admin
    summary_org = Org.find(summary_org_id)
    child_org_ids = summary_org.children.map {|c| c.id}
    yard_inventory_ids = YardInventory.where(:bill_date => bill_date,:from_org_id => summary_org_id,:state => :billed ).pluck(:id)
    carrying_bill_ids = ActLoadListLine.where(:act_load_list_id => yard_inventory_ids).pluck(:carrying_bill_id)

    bills = CarryingBill.where(
      :id => carrying_bill_ids,
      :from_org_id => child_org_ids + [summary_org_id],
      :transit_org_id => nil,
      :completed => false,
      :state => :short_list_reached,
      :load_list_id => nil,
      :type => %w(ComputerBill HandBill ReturnBill AutoCalculateComputerBill)
    ).search(:to_org_id_ni => exclude_to_org_ids)

    group_bills = bills.group_by do |b|
      cur_to_org = Org.find(b.to_org_id)
      cur_to_org.parent_id.blank? ? cur_to_org.id : cur_to_org.parent.id
    end
    #分别生成load_bills
    group_bills.each do |to_org_id,bills|
      to_org = Org.find(to_org_id)
      bill_no = "#{Date.today.strftime("%Y%m%d")}#{summary_org.simp_name}#{to_org.simp_name}"
      load_list = LoadList.new(:from_org_id => summary_org_id,:to_org_id => to_org_id,:bill_no => bill_no,:user_id => admin.id,:note => note)
      bill_ids = bills.map {|b| b.id}
      load_list.carrying_bill_ids = bill_ids
      #装车;发货
      load_list.process;load_list.process
    end

    #自动确认YardInventory
    yard_inventories = YardInventory.where(:id => yard_inventory_ids)

    #装车;检查;到货确认
    yard_inventories.each {|yi| yi.process;yi.check;yi.process}
  end
end
