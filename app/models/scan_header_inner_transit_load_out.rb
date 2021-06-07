#coding: utf-8
#内部中转-装卸出库单
class ScanHeaderInnerTransitLoadOut < ScanHeader
  #定义状态机
  state_machine :initial => :draft do
    after_transition do |sh,transition|
      sh.carrying_bills.each {|bill| bill.standard_process if bill.state.eql?("inner_transit_loaded_in")}
    end
    event :process do
      #草稿->已装车
      transition :draft => :inner_transit_loaded_out,:inner_transit_loaded_out => :transit_shipped
    end
  end

  #发车
  def ship
    update_attributes(:state => :transit_shipped)
    bill_no = "#{Date.today.strftime("%Y%m%d")}#{to_org.simp_name}"
    load_list = InnerTransitLoadList.new(
      :from_org_id => from_org_id,
      :transit_org_id => from_org_id,
      :to_org_id => to_org_id,
      :bill_no => bill_no,
      :user_id => user_id,
      :driver => driver_name,
      :vehicle_no => v_no,
      :note => note,
      :state => :transit_reached)
    load_list.carrying_bills = carrying_bills
    load_list.scan_lines = scan_lines
    load_list.process
  end
end
